touch vifmrun.sh
echo '#!/usr/bin/env bash' >> vifmrun.sh
echo 'readonly ID_PREVIEW="preview"' >> vifmrun.sh
echo '' >> vifmrun.sh
echo '#PLAY_GIF="yes"' >> vifmrun.sh
echo '# By enabling this option the GIF will be animated, by leaving it commented like it' >> vifmrun.sh
echo '# is now will make the gif previews behave the same way as video previews.' >> vifmrun.sh
echo '' >> vifmrun.sh
echo '#AUTO_REMOVE="yes"' >> vifmrun.sh
echo '# By enabling this option the script will remove the preview file after it is drawn' >> vifmrun.sh
echo '# and by doing so the preview will always be up-to-date with the file.' >> vifmrun.sh
echo '# This however, requires more CPU and therefore affects the overall performance.' >> vifmrun.sh
echo '' >> vifmrun.sh
echo '# The messy code below is for moving pages in pdf files in the vifm file preview by' >> vifmrun.sh
echo '# utilizing the < and > keys which will be bound to `vifmimg inc` or `vifmimg dec`.' >> vifmrun.sh
echo 'PDF_PAGE_CONFIG="$HOME/.config/vifm/vifmimgpdfpage"' >> vifmrun.sh
echo 'PDF_FILE_CONFIG="$HOME/.config/vifm/vifmimgpdffile"' >> vifmrun.sh
echo 'PDF_PAGE=1' >> vifmrun.sh
echo 'PDF_FILE=""' >> vifmrun.sh
echo '# Initialize the variables and required files' >> vifmrun.sh
echo '[[ -f "$PDF_PAGE_CONFIG" ]] && PDF_PAGE=$(cat $PDF_PAGE_CONFIG) || touch $PDF_PAGE_CONFIG' >> vifmrun.sh
echo '[[ -f "$PDF_FILE_CONFIG" ]] && PDF_FILE=$(cat $PDF_FILE_CONFIG) || touch $PDF_FILE_CONFIG' >> vifmrun.sh
echo '' >> vifmrun.sh
echo '' >> vifmrun.sh
echo '# Create temporary working directory if the directory structure doesn't exist' >> vifmrun.sh
echo 'if [[ ! -d "/tmp$PWD/" ]]; 'then'' >> vifmrun.sh
echo '    mkdir -p "/tmp$PWD/"' >> vifmrun.sh
echo ''fi'' >> vifmrun.sh
echo '' >> vifmrun.sh
echo 'function inc() {' >> vifmrun.sh
echo '	VAL="$(cat $PDF_PAGE_CONFIG)"' >> vifmrun.sh
echo '	echo "$(expr $VAL + 1)" > $PDF_PAGE_CONFIG' >> vifmrun.sh
echo '}' >> vifmrun.sh
echo '' >> vifmrun.sh
echo 'function dec() {' >> vifmrun.sh
echo '	VAL="$(cat $PDF_PAGE_CONFIG)"' >> vifmrun.sh
echo '	echo "$(expr $VAL - 1)" > $PDF_PAGE_CONFIG' >> vifmrun.sh
echo '	if [[ $VAL -le 0 ]]; then' >> vifmrun.sh
echo '		echo 0 > $PDF_PAGE_CONFIG' >> vifmrun.sh
echo '	fi' >> vifmrun.sh
echo '}' >> vifmrun.sh
echo '' >> vifmrun.sh
echo 'function previewclear() {' >> vifmrun.sh
echo '    declare -p -A cmd=([action]=remove [identifier]="$ID_PREVIEW") \' >> vifmrun.sh
echo '        > "$FIFO_UEBERZUG"' >> vifmrun.sh
echo '}' >> vifmrun.sh
echo '' >> vifmrun.sh
echo 'function fileclean() {' >> vifmrun.sh
echo '    if [[ -f "/tmp$PWD/$6.png" ]]; then' >> vifmrun.sh
echo '        rm -f "/tmp$PWD/$6.png"' >> vifmrun.sh
echo '    elif  [[ -d "/tmp$PWD/$6/" ]]; then' >> vifmrun.sh
echo '        rm -rf "/tmp$PWD/$6/"' >> vifmrun.sh
echo '    fi' >> vifmrun.sh
echo '}' >> vifmrun.sh
echo '' >> vifmrun.sh
echo 'function preview() {' >> vifmrun.sh
echo '    declare -p -A cmd=([action]=add [identifier]="$ID_PREVIEW"' >> vifmrun.sh
echo '        [x]="$2" [y]="$3" [width]="$4" [height]="$5" \' >> vifmrun.sh
echo '        [path]="$PWD/$6") \' >> vifmrun.sh
echo '        > "$FIFO_UEBERZUG"' >> vifmrun.sh
echo '}' >> vifmrun.sh
echo '' >> vifmrun.sh
echo 'function previewvideo() {' >> vifmrun.sh
echo '    if [[ ! -f "/tmp$PWD/$6.png" ]]; then' >> vifmrun.sh
echo '        ffmpegthumbnailer -i "$PWD/$6" -o "/tmp$PWD/$6.png" -s 0 -q 10' >> vifmrun.sh
echo '    fi' >> vifmrun.sh
echo '    declare -p -A cmd=([action]=add [identifier]="$ID_PREVIEW"' >> vifmrun.sh
echo '        [x]="$2" [y]="$3" [width]="$4" [height]="$5" \' >> vifmrun.sh
echo '        [path]="/tmp$PWD/$6.png") \' >> vifmrun.sh
echo '        > "$FIFO_UEBERZUG"' >> vifmrun.sh
echo '}' >> vifmrun.sh
echo '' >> vifmrun.sh
echo 'function previewepub() {' >> vifmrun.sh
echo '    if [[ ! -f "/tmp$PWD/$6.png" ]]; then' >> vifmrun.sh
echo '        epub-thumbnailer "$6" "/tmp$PWD/$6.png" 1024' >> vifmrun.sh
echo '    fi' >> vifmrun.sh
echo '    declare -p -A cmd=([action]=add [identifier]="$ID_PREVIEW"' >> vifmrun.sh
echo '        [x]="$2" [y]="$3" [width]="$4" [height]="$5" \' >> vifmrun.sh
echo '        [path]="/tmp$PWD/$6.png") \' >> vifmrun.sh
echo '        > "$FIFO_UEBERZUG"' >> vifmrun.sh
echo '}' >> vifmrun.sh
echo '' >> vifmrun.sh
echo 'function  previewaudio() {' >> vifmrun.sh
echo '  if [[ ! -f "/tmp${PWD}/$6.png" ]]; then' >> vifmrun.sh
echo '    ffmpeg -i "$6" "/tmp${PWD}/$6.png" -y &> /dev/null' >> vifmrun.sh
echo '  fi' >> vifmrun.sh
echo '  declare -p -A cmd=([action]=add [identifier]="$ID_PREVIEW"' >> vifmrun.sh
echo '                     [x]="$2" [y]="$3" [width]="$4" [height]="$5" \' >> vifmrun.sh
echo '                     [path]="/tmp${PWD}/$6.png") \' >> vifmrun.sh
echo '    > "$FIFO_UEBERZUG"' >> vifmrun.sh
echo '}' >> vifmrun.sh
echo '' >> vifmrun.sh
echo 'function previewfont() {' >> vifmrun.sh
echo '  if [[ ! -f "/tmp${PWD}/$6.png" ]]; then' >> vifmrun.sh
echo '    fontpreview -i "$6" -o "/tmp${PWD}/$6.png"' >> vifmrun.sh
echo '  fi' >> vifmrun.sh
echo '  declare -p -A cmd=([action]=add [identifier]="$ID_PREVIEW"' >> vifmrun.sh
echo '                     [x]="$2" [y]="$3" [width]="$4" [height]="$5" \' >> vifmrun.sh
echo '                     [path]="/tmp${PWD}/$6.png") \' >> vifmrun.sh
echo '    > "$FIFO_UEBERZUG"' >> vifmrun.sh
echo '}' >> vifmrun.sh
echo '' >> vifmrun.sh
echo 'function previewgif() {' >> vifmrun.sh
echo '    if [[ ! -d "/tmp$PWD/$6/" ]]; then' >> vifmrun.sh
echo '        mkdir -p "/tmp$PWD/$6/"' >> vifmrun.sh
echo '        convert -coalesce "$PWD/$6" "/tmp$PWD/$6/$6.png"' >> vifmrun.sh
echo '    fi' >> vifmrun.sh
echo '    if [[ ! -z "$PLAY_GIF" ]]; then' >> vifmrun.sh
echo '        for frame in $(ls -1 /tmp$PWD/$6/$6*.png | sort -V); do' >> vifmrun.sh
echo '            declare -p -A cmd=([action]=add [identifier]="$ID_PREVIEW"' >> vifmrun.sh
echo '                [x]="$2" [y]="$3" [width]="$4" [height]="$5" \' >> vifmrun.sh
echo '                [path]="$frame") \' >> vifmrun.sh
echo '                > "$FIFO_UEBERZUG"' >> vifmrun.sh
echo '            # Sleep between frames to make the animation smooth.' >> vifmrun.sh
echo '            sleep .07' >> vifmrun.sh
echo '        done' >> vifmrun.sh
echo '    else' >> vifmrun.sh
echo '            declare -p -A cmd=([action]=add [identifier]="$ID_PREVIEW"' >> vifmrun.sh
echo '                [x]="$2" [y]="$3" [width]="$4" [height]="$5" \' >> vifmrun.sh
echo '                [path]="/tmp$PWD/$6/$6-0.png") \' >> vifmrun.sh
echo '                > "$FIFO_UEBERZUG"' >> vifmrun.sh
echo '    fi' >> vifmrun.sh
echo '}' >> vifmrun.sh
echo '' >> vifmrun.sh
echo 'function previewpdf() {' >> vifmrun.sh
echo '    if [[ ! "$6" == "$PDF_FILE" ]]; then' >> vifmrun.sh
echo '        PDF_PAGE=1' >> vifmrun.sh
echo '        echo1 > $PDF_PAGE_CONFIG' >> vifmrun.sh
echo '        rm -f "/tmp$PWD/$6.png"' >> vifmrun.sh
echo '    fi' >> vifmrun.sh
echo '' >> vifmrun.sh
echo '    if [[ ! "$PDF_PAGE" == "1" ]] && [[ -f "/tmp$PWD/$6.png" ]]; then' >> vifmrun.sh
echo '        rm -f "/tmp$PWD/$6.png"' >> vifmrun.sh
echo '    fi' >> vifmrun.sh
echo '' >> vifmrun.sh
echo '    if [[ ! -f "/tmp$PWD/$6.png" ]]; then' >> vifmrun.sh
echo '        pdftoppm -png -f $PDF_PAGE -singlefile "$6" "/tmp$PWD/$6"' >> vifmrun.sh
echo '    fi' >> vifmrun.sh
echo '    echo "$6" > $PDF_FILE_CONFIG' >> vifmrun.sh
echo '' >> vifmrun.sh
echo '    declare -p -A cmd=([action]=add [identifier]="$ID_PREVIEW"' >> vifmrun.sh
echo '        [x]="$2" [y]="$3" [width]="$4" [height]="$5" \' >> vifmrun.sh
echo '        [path]="/tmp$PWD/$6.png") \' >> vifmrun.sh
echo '        > "$FIFO_UEBERZUG"' >> vifmrun.sh
echo '}' >> vifmrun.sh
echo '' >> vifmrun.sh
echo '' >> vifmrun.sh
echo 'function previewmagick() {' >> vifmrun.sh
echo '    if [[ ! -f "/tmp$PWD/$6.png" ]]; then' >> vifmrun.sh
echo '        convert -thumbnail $(identify -format "%wx%h" "$6") "$PWD/$6" "/tmp$PWD/$6.png"' >> vifmrun.sh
echo '    fi' >> vifmrun.sh
echo '    declare -p -A cmd=([action]=add [identifier]="$ID_PREVIEW"' >> vifmrun.sh
echo '        [x]="$2" [y]="$3" [width]="$4" [height]="$5" \' >> vifmrun.sh
echo '        [path]="/tmp$PWD/$6.png") \' >> vifmrun.sh
echo '        > "$FIFO_UEBERZUG"' >> vifmrun.sh
echo '}' >> vifmrun.sh
echo '' >> vifmrun.sh
echo '' >> vifmrun.sh
echo '' >> vifmrun.sh
echo 'function main() {' >> vifmrun.sh
echo '    case "$1" in' >> vifmrun.sh
echo '        "inc") inc "$@" ;;' >> vifmrun.sh
echo '        "dec") dec "$@" ;;' >> vifmrun.sh
echo '        "clear") previewclear "$@" ;;' >> vifmrun.sh
echo '        "clean") fileclean "$@" ;;' >> vifmrun.sh
echo '        "draw") preview "$@" ;;' >> vifmrun.sh
echo '        "videopreview") previewvideo "$@" ;;' >> vifmrun.sh
echo '        "epubpreview") previewepub "$@" ;;' >> vifmrun.sh
echo '        "gifpreview") previewgif "$@" ;;' >> vifmrun.sh
echo '        "pdfpreview") previewpdf "$@" ;;' >> vifmrun.sh
echo '        "magickpreview") previewmagick "$@" ;;' >> vifmrun.sh
echo '        "audiopreview") previewaudio "$@" ;;' >> vifmrun.sh
echo '        "fontpreview") previewfont "$@" ;;' >> vifmrun.sh
echo '        *) echo "Unknown command: '$@'" ;;' >> vifmrun.sh
echo '    esac' >> vifmrun.sh
echo '}' >> vifmrun.sh
echo 'main "$@" ' >> vifmrun.sh
