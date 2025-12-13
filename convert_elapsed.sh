#!/usr/bin/env bash
set -euo pipefail

progname="$(basename "$0")"
usage() {
  cat <<FOOBARBAZ
Usage: $progname [ -i ] [file]
Converts elapsed time stamps from MM:SS to MMhSSs.
- If 'file' is provided, writes result to stdout.
- With '-i', edits the file in-place safely.
- If no file provided, reads from stdin.

Examples:
  $progname ships-output.txt
  $progname -i ships-output.txt
  cat ships-output.txt | $progname
FOOBARBAZ
}

inplace=0
while getopts ":ih" opt; do
  case $opt in
    i) inplace=1 ;;
    h) usage; exit 0 ;;
    \?) echo "Invalid option: -$OPTARG" >&2; usage; exit 2 ;;
  esac
done
shift $((OPTIND-1))

process() {
  # Replace MM:SS (1-2 digits minutes, exactly 2 digits seconds)
  # with MMmSSs globally on each line.
  # NOTE: The sed that comes with a Mac didn't work. To fix
  # this, replace sed with gsed (GNU sed), which you can via 
  # the usual ways (e.g. brew)
  sed -E 's/\b([0-9]{1,2}):([0-9]{2})\b/\1m\2s/g'
}

if [ $# -eq 0 ]; then
  if [ "$inplace" -eq 1 ]; then
    echo "Error: -i requires a filename" >&2; exit 2
  fi
  process
else
  file="$1"
  if [ "$inplace" -eq 1 ]; then
    tmp="$(mktemp "${TMPDIR:-/tmp}/convert_elapsed.XXXXXX")"
    if process <"$file" >"$tmp"; then
      mv "$tmp" "$file"
    else
      rm -f "$tmp"
      echo "Processing failed" >&2
      exit 1
    fi
  else
    process <"$file"
  fi
fi
