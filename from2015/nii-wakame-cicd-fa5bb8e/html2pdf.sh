#!/bin/bash
#
# Download:
#  wkhtmltopdf http://wkhtmltopdf.org/
#
# Usage:
#  1. Open the markdown with Atom editor
#  2. Preview the markdown
#  3. Save as HTML
#
set -e
set -o pipefail
set -u

PATH="${PATH}:/cygdrive/c/Program Files/wkhtmltopdf/bin"
type -P wkhtmltopdf >/dev/null

baseurl="file:///$(cygpath.exe -t mixed $(pwd))"
suffix=md.html

for i in ${@}; do
  src=${baseurl}/${i}
  dst=${i%.${suffix}}.pdf

  echo "[INFO] Generating ${dst}..."
  time wkhtmltopdf ${src} ${dst}
done
