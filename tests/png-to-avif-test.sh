#!/usr/bin/env bash
set -euo pipefail

SETUP_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd -P)"
SCRIPT="$SETUP_ROOT/skills/infographic-bytebytego-style/scripts/png-to-avif"
SKILL="$SETUP_ROOT/skills/infographic-bytebytego-style/SKILL.md"
TEST_ROOT="$(mktemp -d)"
FAKE_BIN="$TEST_ROOT/bin"
INPUT="$TEST_ROOT/diagram.png"
EXPECTED_INPUT="$TEST_ROOT/diagram.expected.png"
LOG="$TEST_ROOT/tools.log"
trap 'rm -rf "$TEST_ROOT"' EXIT

[[ -x "$SCRIPT" ]]
grep -q 'convert an existing PNG infographic to AVIF' "$SKILL"
grep -q 'scripts/png-to-avif' "$SKILL"

mkdir -p "$FAKE_BIN"
printf 'source pixels stay unchanged\n' > "$INPUT"
cp "$INPUT" "$EXPECTED_INPUT"

cat > "$FAKE_BIN/avifenc" <<'EOF'
#!/usr/bin/env bash
set -euo pipefail
printf 'avifenc %s\n' "$*" >> "$PNG_TO_AVIF_TEST_LOG"
for argument in "$@"; do
    output="$argument"
done
if [[ "${PNG_TO_AVIF_TEST_MODE:-normal}" == "encode-failure" ]]; then
    exit 1
fi
if [[ "${PNG_TO_AVIF_TEST_MODE:-normal}" == "oversized" ]]; then
    bytes=150001
else
    bytes=70000
fi
truncate -s "$bytes" "$output"
EOF

cat > "$FAKE_BIN/avifdec" <<'EOF'
#!/usr/bin/env bash
set -euo pipefail
printf 'avifdec %s\n' "$*" >> "$PNG_TO_AVIF_TEST_LOG"
if [[ "${PNG_TO_AVIF_TEST_MODE:-normal}" == "decode-failure" ]]; then
    exit 1
fi
for argument in "$@"; do
    output="$argument"
done
cp "$PNG_TO_AVIF_TEST_INPUT" "$output"
EOF

cat > "$FAKE_BIN/magick" <<'EOF'
#!/usr/bin/env bash
set -euo pipefail
printf 'magick %s\n' "$*" >> "$PNG_TO_AVIF_TEST_LOG"
case "$1" in
    identify)
        for argument in "$@"; do
            input="$argument"
        done
        if [[ "${PNG_TO_AVIF_TEST_MODE:-normal}" == "dimension-mismatch" && "$input" == *decoded.png ]]; then
            printf '1023x1536'
        else
            printf '1024x1536'
        fi
        ;;
    compare)
        if [[ "${PNG_TO_AVIF_TEST_MODE:-normal}" == "quality-failure" ]]; then
            printf '700 (0.007)\n' >&2
        else
            printf '400 (0.004)\n' >&2
        fi
        exit 1
        ;;
    *)
        exit 2
        ;;
esac
EOF

chmod +x "$FAKE_BIN/avifenc" "$FAKE_BIN/avifdec" "$FAKE_BIN/magick"

PATH="$FAKE_BIN:$PATH" PNG_TO_AVIF_TEST_INPUT="$INPUT" PNG_TO_AVIF_TEST_LOG="$LOG" "$SCRIPT" "$INPUT"

OUTPUT="${INPUT%.png}.avif"
[[ -f "$OUTPUT" ]]
[[ "$(wc -c < "$OUTPUT" | tr -d '[:space:]')" == "70000" ]]
cmp -s "$INPUT" "$EXPECTED_INPUT"
grep -q -- 'avifenc -q 55 -s 0 --yuv 444' "$LOG"
grep -q -- 'avifdec .*decoded.png' "$LOG"
grep -q -- 'magick compare -metric DSSIM' "$LOG"

printf 'keep existing derivative\n' > "$OUTPUT"
if PATH="$FAKE_BIN:$PATH" PNG_TO_AVIF_TEST_INPUT="$INPUT" PNG_TO_AVIF_TEST_LOG="$LOG" "$SCRIPT" "$INPUT" 2>/dev/null; then
    printf 'expected conversion to refuse an existing AVIF\n' >&2
    exit 1
fi
[[ "$(cat "$OUTPUT")" == "keep existing derivative" ]]

PATH="$FAKE_BIN:$PATH" PNG_TO_AVIF_TEST_INPUT="$INPUT" PNG_TO_AVIF_TEST_LOG="$LOG" "$SCRIPT" --force "$INPUT"
[[ "$(wc -c < "$OUTPUT" | tr -d '[:space:]')" == "70000" ]]

for mode in encode-failure oversized decode-failure dimension-mismatch quality-failure; do
    printf 'keep last valid derivative\n' > "$OUTPUT"
    if PATH="$FAKE_BIN:$PATH" PNG_TO_AVIF_TEST_INPUT="$INPUT" PNG_TO_AVIF_TEST_LOG="$LOG" PNG_TO_AVIF_TEST_MODE="$mode" "$SCRIPT" --force "$INPUT" 2>/dev/null; then
        printf 'expected %s conversion to fail\n' "$mode" >&2
        exit 1
    fi
    [[ "$(cat "$OUTPUT")" == "keep last valid derivative" ]]
done
