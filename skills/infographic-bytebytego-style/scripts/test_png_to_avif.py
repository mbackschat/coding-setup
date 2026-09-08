import os
from pathlib import Path
import subprocess
import tempfile
import unittest


HELPER = Path(__file__).with_name("png-to-avif")
FAKE_TOOL = '''#!/usr/bin/env python3
import os
from pathlib import Path
import sys

tool = Path(sys.argv[0]).name
args = sys.argv[1:]
if tool == "avifenc":
    Path(os.environ["AVIF_TEST_LOG"]).write_text("\\n".join(args))
    Path(args[-1]).write_bytes(b"x" * int(os.environ.get("AVIF_TEST_BYTES", "150000")))
elif tool == "avifdec":
    if os.environ.get("AVIF_TEST_DECODE_FAIL"):
        sys.exit(1)
    Path(args[-1]).write_bytes(b"decoded")
elif args[0] == "identify":
    print(os.environ.get("AVIF_TEST_DIMENSIONS", "1536x1024") if args[-1].endswith("decoded.png") else "1536x1024")
elif args[0] == "compare":
    print("262 (" + os.environ.get("AVIF_TEST_DSSIM", "0.004") + ")", file=sys.stderr)
    sys.exit(1)
else:
    sys.exit(2)
'''


class ExportProfilesTest(unittest.TestCase):
    def setUp(self):
        self.scratch = tempfile.TemporaryDirectory(prefix="avif-profile-test-")
        self.addCleanup(self.scratch.cleanup)
        self.root = Path(self.scratch.name)
        self.source = self.root / "diagram with spaces.png"
        self.source.write_bytes(b"unchanged archival source")
        self.output = self.source.with_suffix(".avif")
        self.bin = self.root / "bin"
        self.bin.mkdir()
        for name in ("avifenc", "avifdec", "magick"):
            tool = self.bin / name
            tool.write_text(FAKE_TOOL)
            tool.chmod(0o755)
        self.env = dict(os.environ, PATH=f"{self.bin}:{os.environ['PATH']}", AVIF_TEST_LOG=str(self.root / "encode.log"))

    def run_helper(self, *options, **settings):
        result = subprocess.run(["bash", str(HELPER), *options, str(self.source)], env=dict(self.env, **settings), capture_output=True, text=True, timeout=10)
        self.assertEqual(self.source.read_bytes(), b"unchanged archival source")
        self.assertEqual(list(self.root.glob(".png-to-avif.*")), [])
        return result

    def test_default_accepts_exact_web_ceiling_and_keeps_encoding_settings(self):
        result = self.run_helper()
        self.assertEqual(result.returncode, 0, result.stderr)
        self.assertEqual(self.output.stat().st_size, 150000)
        args = (self.root / "encode.log").read_text().splitlines()
        self.assertEqual(args[:6], ["-q", "55", "-s", "0", "--yuv", "444"])

    def test_default_and_explicit_web_profile_reject_one_byte_over_ceiling(self):
        for options in ((), ("--profile", "web-compact")):
            with self.subTest(options=options):
                result = self.run_helper(*options, AVIF_TEST_BYTES="150001")
                self.assertNotEqual(result.returncode, 0)
                self.assertIn("above the 150000-byte ceiling", result.stderr)
                self.assertFalse(self.output.exists())

    def test_poster_accepts_larger_output_without_weakening_encoding(self):
        result = self.run_helper("--profile", "poster", AVIF_TEST_BYTES="150001")
        self.assertEqual(result.returncode, 0, result.stderr)
        self.assertEqual(self.output.stat().st_size, 150001)
        self.assertIn("profile poster", result.stdout)
        args = (self.root / "encode.log").read_text().splitlines()
        self.assertEqual(args[:6], ["-q", "55", "-s", "0", "--yuv", "444"])

    def test_poster_still_rejects_excessive_distortion(self):
        result = self.run_helper("--profile", "poster", AVIF_TEST_DSSIM="0.00601")
        self.assertNotEqual(result.returncode, 0)
        self.assertIn("above the 0.006 ceiling", result.stderr)
        self.assertFalse(self.output.exists())

    def test_poster_still_rejects_changed_dimensions(self):
        result = self.run_helper("--profile", "poster", AVIF_TEST_DIMENSIONS="768x512")
        self.assertNotEqual(result.returncode, 0)
        self.assertIn("Dimension verification failed", result.stderr)
        self.assertFalse(self.output.exists())

    def test_poster_still_rejects_decode_failure(self):
        result = self.run_helper("--profile", "poster", AVIF_TEST_DECODE_FAIL="1")
        self.assertNotEqual(result.returncode, 0)
        self.assertIn("decode verification failed", result.stderr)
        self.assertFalse(self.output.exists())

    def test_unknown_profile_is_rejected_before_encoding(self):
        result = self.run_helper("--profile", "unknown")
        self.assertNotEqual(result.returncode, 0)
        self.assertIn("Unknown profile", result.stderr)
        self.assertFalse((self.root / "encode.log").exists())

    def test_existing_sibling_requires_force_even_for_poster(self):
        self.output.write_bytes(b"existing")
        result = self.run_helper("--profile", "poster")
        self.assertNotEqual(result.returncode, 0)
        self.assertEqual(self.output.read_bytes(), b"existing")
        result = self.run_helper("--force", "--profile", "poster")
        self.assertEqual(result.returncode, 0, result.stderr)
        self.assertEqual(self.output.stat().st_size, 150000)


if __name__ == "__main__":
    unittest.main()
