#!/usr/bin/env bash
readonly ID_PREVIEW="preview"

#PLAY_GIF="yes"
# By enabling this option the GIF will be animated, by leaving it commented like it
# is now will make the gif previews behave the same way as video previews.

#AUTO_REMOVE="yes"
# By enabling this option the script will remove the preview file after it is drawn
# and by doing so the preview will always be up-to-date with the file.
# This however, requires more CPU and therefore affects the overall performance.

# The messy code below is for moving pages in pdf files in the vifm file preview by
# utilizing the < and > keys which will be bound to `vifmimg inc` or `vifmimg dec`.
PDF_PAGE_CONFIG="$HOME/.config/vifm/vifmimgpdfpage"
PDF_FILE_CONFIG="$HOME/.config/vifm/vifmimgpdffile"
PDF_PAGE=1
PDF_FILE=""
# Initialize the variables and required files
[[ -f "$PDF_PAGE_CONFIG" ]] && PDF_PAGE=$(cat $PDF_PAGE_CONFIG) || touch $PDF_PAGE_CONFIG
[[ -f "$PDF_FILE_CONFIG" ]] && PDF_FILE=$(cat $PDF_FILE_CONFIG) || touch $PDF_FILE_CONFIG


#!/usr/bin/env bash
readonly ID_PREVIEW="preview"

#PLAY_GIF="yes"
# By enabling this option the GIF will be animated, by leaving it commented like it
# is now will make the gif previews behave the same way as video previews.

#AUTO_REMOVE="yes"
# By enabling this option the script will remove the preview file after it is drawn
# and by doing so the preview will always be up-to-date with the file.
# This however, requires more CPU and therefore affects the overall performance.

# The messy code below is for moving pages in pdf files in the vifm file preview by
# utilizing the < and > keys which will be bound to `vifmimg inc` or `vifmimg dec`.
PDF_PAGE_CONFIG="$HOME/.config/vifm/vifmimgpdfpage"
PDF_FILE_CONFIG="$HOME/.config/vifm/vifmimgpdffile"
PDF_PAGE=1
PDF_FILE=""
# Initialize the variables and required files
[[ -f "$PDF_PAGE_CONFIG" ]] && PDF_PAGE=$(cat $PDF_PAGE_CONFIG) || touch $PDF_PAGE_CONFIG
[[ -f "$PDF_FILE_CONFIG" ]] && PDF_FILE=$(cat $PDF_FILE_CONFIG) || touch $PDF_FILE_CONFIG


#!/usr/bin/env bash
export FIFO_UEBERZUG="/tmp/vifm-ueberzug-${PPID}"

if [ ! -x $(command -v ueberzug >/dev/null 2>&1) ]; then
	vifm
	exit
fi

function cleanup {
    rm "$FIFO_UEBERZUG" 2>/dev/null
    pkill -P $$ 2>/dev/null
}
pkill -P $$ 2>/dev/null
rm "$FIFO_UEBERZUG" 2>/dev/null
mkfifo "$FIFO_UEBERZUG" >/dev/null
trap cleanup EXIT 2>/dev/null
tail --follow "$FIFO_UEBERZUG" | ueberzug layer --silent --parser bash 2>&1 >/dev/null &

vifm "$@"
cleanup
#!/usr/bin/env bash
export FIFO_UEBERZUG="/tmp/vifm-ueberzug-${PPID}"

if [ ! -x $(command -v ueberzug >/dev/null 2>&1) ]; then
	vifm
	exit
fi

function cleanup {
    rm "$FIFO_UEBERZUG" 2>/dev/null
    pkill -P $$ 2>/dev/null
}
pkill -P $$ 2>/dev/null
rm "$FIFO_UEBERZUG" 2>/dev/null
mkfifo "$FIFO_UEBERZUG" >/dev/null
trap cleanup EXIT 2>/dev/null
tail --follow "$FIFO_UEBERZUG" | ueberzug layer --silent --parser bash 2>&1 >/dev/null &

vifm "$@"
cleanup
