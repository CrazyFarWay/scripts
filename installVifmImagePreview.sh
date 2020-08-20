sh installVifmImagePreviewDependencies.sh

touch vifmimg
touch vifmrun

echo '#!/usr/bin/env bash' >> vifmimg
echo 'readonly ID_PREVIEW="preview"' >> vifmimg
echo '' >> vifmimg
echo 'PDF_PAGE_CONFIG="$HOME/.config/vifm/vifmimgpdfpage"' >> vifmimg
echo 'PDF_FILE_CONFIG="$HOME/.config/vifm/vifmimgpdffile"' >> vifmimg
echo 'PDF_PAGE=1' >> vifmimg
echo 'PDF_FILE=""' >> vifmimg
echo '[[ -f "$PDF_PAGE_CONFIG" ]] && PDF_PAGE=$(cat $PDF_PAGE_CONFIG) || touch $PDF_PAGE_CONFIG' >> vifmimg
echo '[[ -f "$PDF_FILE_CONFIG" ]] && PDF_FILE=$(cat $PDF_FILE_CONFIG) || touch $PDF_FILE_CONFIG' >> vifmimg
echo '' >> vifmimg
echo '' >> vifmimg
echo 'if [[ ! -d "/tmp$PWD/" ]]; then' >> vifmimg
echo '    mkdir -p "/tmp$PWD/"' >> vifmimg
echo 'fi' >> vifmimg
echo '' >> vifmimg
echo 'function inc() {' >> vifmimg
echo '	VAL="$(cat $PDF_PAGE_CONFIG)"' >> vifmimg
echo '	echo "$(expr $VAL + 1)" > $PDF_PAGE_CONFIG' >> vifmimg
echo '}' >> vifmimg
echo '' >> vifmimg
echo 'function dec() {' >> vifmimg
echo '	VAL="$(cat $PDF_PAGE_CONFIG)"' >> vifmimg
echo '	echo "$(expr $VAL - 1)" > $PDF_PAGE_CONFIG' >> vifmimg
echo '	if [[ $VAL -le 0 ]]; then' >> vifmimg
echo '		echo 0 > $PDF_PAGE_CONFIG' >> vifmimg
echo '	fi' >> vifmimg
echo '}' >> vifmimg
echo '' >> vifmimg
echo 'function previewclear() {' >> vifmimg
echo '    declare -p -A cmd=([action]=remove [identifier]="$ID_PREVIEW") \' >> vifmimg
echo '        > "$FIFO_UEBERZUG"' >> vifmimg
echo '}' >> vifmimg
echo '' >> vifmimg
echo 'function fileclean() {' >> vifmimg
echo '    if [[ -f "/tmp$PWD/$6.png" ]]; then' >> vifmimg
echo '        rm -f "/tmp$PWD/$6.png"' >> vifmimg
echo '    elif  [[ -d "/tmp$PWD/$6/" ]]; then' >> vifmimg
echo '        rm -rf "/tmp$PWD/$6/"' >> vifmimg
echo '    fi' >> vifmimg
echo '}' >> vifmimg
echo '' >> vifmimg
echo 'function preview() {' >> vifmimg
echo '    declare -p -A cmd=([action]=add [identifier]="$ID_PREVIEW"' >> vifmimg
echo '        [x]="$2" [y]="$3" [width]="$4" [height]="$5" \' >> vifmimg
echo '        [path]="$PWD/$6") \' >> vifmimg
echo '        > "$FIFO_UEBERZUG"' >> vifmimg
echo '}' >> vifmimg
echo '' >> vifmimg
echo 'function previewvideo() {' >> vifmimg
echo '    if [[ ! -f "/tmp$PWD/$6.png" ]]; then' >> vifmimg
echo '        ffmpegthumbnailer -i "$PWD/$6" -o "/tmp$PWD/$6.png" -s 0 -q 10' >> vifmimg
echo '    fi' >> vifmimg
echo '    declare -p -A cmd=([action]=add [identifier]="$ID_PREVIEW"' >> vifmimg
echo '        [x]="$2" [y]="$3" [width]="$4" [height]="$5" \' >> vifmimg
echo '        [path]="/tmp$PWD/$6.png") \' >> vifmimg
echo '        > "$FIFO_UEBERZUG"' >> vifmimg
echo '}' >> vifmimg
echo '' >> vifmimg
echo 'function previewepub() {' >> vifmimg
echo '    if [[ ! -f "/tmp$PWD/$6.png" ]]; then' >> vifmimg
echo '        epub-thumbnailer "$6" "/tmp$PWD/$6.png" 1024' >> vifmimg
echo '    fi' >> vifmimg
echo '    declare -p -A cmd=([action]=add [identifier]="$ID_PREVIEW"' >> vifmimg
echo '        [x]="$2" [y]="$3" [width]="$4" [height]="$5" \' >> vifmimg
echo '        [path]="/tmp$PWD/$6.png") \' >> vifmimg
echo '        > "$FIFO_UEBERZUG"' >> vifmimg
echo '}' >> vifmimg
echo '' >> vifmimg
echo 'function  previewaudio() {' >> vifmimg
echo '  if [[ ! -f "/tmp${PWD}/$6.png" ]]; then' >> vifmimg
echo '    ffmpeg -i "$6" "/tmp${PWD}/$6.png" -y &> /dev/null' >> vifmimg
echo '  fi' >> vifmimg
echo '  declare -p -A cmd=([action]=add [identifier]="$ID_PREVIEW"' >> vifmimg
echo '                     [x]="$2" [y]="$3" [width]="$4" [height]="$5" \' >> vifmimg
echo '                     [path]="/tmp${PWD}/$6.png") \' >> vifmimg
echo '    > "$FIFO_UEBERZUG"' >> vifmimg
echo '}' >> vifmimg
echo '' >> vifmimg
echo 'function previewfont() {' >> vifmimg
echo '  if [[ ! -f "/tmp${PWD}/$6.png" ]]; then' >> vifmimg
echo '    fontpreview -i "$6" -o "/tmp${PWD}/$6.png"' >> vifmimg
echo '  fi' >> vifmimg
echo '  declare -p -A cmd=([action]=add [identifier]="$ID_PREVIEW"' >> vifmimg
echo '                     [x]="$2" [y]="$3" [width]="$4" [height]="$5" \' >> vifmimg
echo '                     [path]="/tmp${PWD}/$6.png") \' >> vifmimg
echo '    > "$FIFO_UEBERZUG"' >> vifmimg
echo '}' >> vifmimg
echo '' >> vifmimg
echo 'function previewgif() {' >> vifmimg
echo '    if [[ ! -d "/tmp$PWD/$6/" ]]; then' >> vifmimg
echo '        mkdir -p "/tmp$PWD/$6/"' >> vifmimg
echo '        convert -coalesce "$PWD/$6" "/tmp$PWD/$6/$6.png"' >> vifmimg
echo '    fi' >> vifmimg
echo '    if [[ ! -z "$PLAY_GIF" ]]; then' >> vifmimg
echo '        for frame in $(ls -1 /tmp$PWD/$6/$6*.png | sort -V); do' >> vifmimg
echo '            declare -p -A cmd=([action]=add [identifier]="$ID_PREVIEW"' >> vifmimg
echo '                [x]="$2" [y]="$3" [width]="$4" [height]="$5" \' >> vifmimg
echo '                [path]="$frame") \' >> vifmimg
echo '                > "$FIFO_UEBERZUG"' >> vifmimg
echo '            sleep .07' >> vifmimg
echo '        done' >> vifmimg
echo '    else' >> vifmimg
echo '            declare -p -A cmd=([action]=add [identifier]="$ID_PREVIEW"' >> vifmimg
echo '                [x]="$2" [y]="$3" [width]="$4" [height]="$5" \' >> vifmimg
echo '                [path]="/tmp$PWD/$6/$6-0.png") \' >> vifmimg
echo '                > "$FIFO_UEBERZUG"' >> vifmimg
echo '    fi' >> vifmimg
echo '}' >> vifmimg
echo '' >> vifmimg
echo 'function previewpdf() {' >> vifmimg
echo '    if [[ ! "$6" == "$PDF_FILE" ]]; then' >> vifmimg
echo '        PDF_PAGE=1' >> vifmimg
echo '        echo 1 > $PDF_PAGE_CONFIG' >> vifmimg
echo '        rm -f "/tmp$PWD/$6.png"' >> vifmimg
echo '    fi' >> vifmimg
echo '' >> vifmimg
echo '    if [[ ! "$PDF_PAGE" == "1" ]] && [[ -f "/tmp$PWD/$6.png" ]]; then' >> vifmimg
echo '        rm -f "/tmp$PWD/$6.png"' >> vifmimg
echo '    fi' >> vifmimg
echo '' >> vifmimg
echo '    if [[ ! -f "/tmp$PWD/$6.png" ]]; then' >> vifmimg
echo '        pdftoppm -png -f $PDF_PAGE -singlefile "$6" "/tmp$PWD/$6"' >> vifmimg
echo '    fi' >> vifmimg
echo '    echo "$6" > $PDF_FILE_CONFIG' >> vifmimg
echo '' >> vifmimg
echo '    declare -p -A cmd=([action]=add [identifier]="$ID_PREVIEW"' >> vifmimg
echo '        [x]="$2" [y]="$3" [width]="$4" [height]="$5" \' >> vifmimg
echo '        [path]="/tmp$PWD/$6.png") \' >> vifmimg
echo '        > "$FIFO_UEBERZUG"' >> vifmimg
echo '}' >> vifmimg
echo '' >> vifmimg
echo '' >> vifmimg
echo 'function previewmagick() {' >> vifmimg
echo '    if [[ ! -f "/tmp$PWD/$6.png" ]]; then' >> vifmimg
echo '        convert -thumbnail $(identify -format "%wx%h" "$6") "$PWD/$6" "/tmp$PWD/$6.png"' >> vifmimg
echo '    fi' >> vifmimg
echo '    declare -p -A cmd=([action]=add [identifier]="$ID_PREVIEW"' >> vifmimg
echo '        [x]="$2" [y]="$3" [width]="$4" [height]="$5" \' >> vifmimg
echo '        [path]="/tmp$PWD/$6.png") \' >> vifmimg
echo '        > "$FIFO_UEBERZUG"' >> vifmimg
echo '}' >> vifmimg
echo '' >> vifmimg
echo '' >> vifmimg
echo '' >> vifmimg
echo 'function main() {' >> vifmimg
echo '    case "$1" in' >> vifmimg
echo '        "inc") inc "$@" ;;' >> vifmimg
echo '        "dec") dec "$@" ;;' >> vifmimg
echo '        "clear") previewclear "$@" ;;' >> vifmimg
echo '        "clean") fileclean "$@" ;;' >> vifmimg
echo '        "draw") preview "$@" ;;' >> vifmimg
echo '        "videopreview") previewvideo "$@" ;;' >> vifmimg
echo '        "epubpreview") previewepub "$@" ;;' >> vifmimg
echo '        "gifpreview") previewgif "$@" ;;' >> vifmimg
echo '        "pdfpreview") previewpdf "$@" ;;' >> vifmimg
echo '        "magickpreview") previewmagick "$@" ;;' >> vifmimg
echo '        "audiopreview") previewaudio "$@" ;;' >> vifmimg
echo '        "fontpreview") previewfont "$@" ;;' >> vifmimg
echo '        *) echo "Unknown command: '$@'" ;;' >> vifmimg
echo '    esac' >> vifmimg
echo '}' >> vifmimg
echo 'main "$@"' >> vifmimg

echo '#!/usr/bin/env bash' >> vifmrun
echo 'export FIFO_UEBERZUG="/tmp/vifm-ueberzug-${PPID}"' >> vifmrun
echo '' >> vifmrun
echo 'if [ ! -x $(command -v ueberzug >/dev/null 2>&1) ]; then' >> vifmrun
echo '	vifm' >> vifmrun
echo '	exit' >> vifmrun
echo 'fi' >> vifmrun
echo '' >> vifmrun
echo 'function cleanup {' >> vifmrun
echo '    rm "$FIFO_UEBERZUG" 2>/dev/null' >> vifmrun
echo '    pkill -P $$ 2>/dev/null' >> vifmrun
echo '}' >> vifmrun
echo 'pkill -P $$ 2>/dev/null' >> vifmrun
echo 'rm "$FIFO_UEBERZUG" 2>/dev/null' >> vifmrun
echo 'mkfifo "$FIFO_UEBERZUG" >/dev/null' >> vifmrun
echo 'trap cleanup EXIT 2>/dev/null' >> vifmrun
echo 'tail --follow "$FIFO_UEBERZUG" | ueberzug layer --silent --parser bash 2>&1 >/dev/null &' >> vifmrun
echo '' >> vifmrun
echo 'vifm "$@"' >> vifmrun
echo 'cleanup' >> vifmrun

cp vifmimg /home/crazyfarway/.config/vifm/scripts/
cp vifmrun /home/crazyfarway/.config/vifm/scripts/

chmod +x /home/crazyfarway/.config/vifm/scripts/
chmod +x /home/crazyfarway/.config/vifm/scripts/

echo '    fileviewer *.pdf' >> echo '/.config/vifm/vifmrc'
echo '        \ vifmimg pdfpreview %px %py %pw %ph %c' >> echo '/.config/vifm/vifmrc'
echo '        \ %pc' >> echo '/.config/vifm/vifmrc'
echo '        \ vifmimg clear' >> echo '/.config/vifm/vifmrc'
echo '' >> echo '/.config/vifm/vifmrc'
echo '    fileviewer *.epub' >> echo '/.config/vifm/vifmrc'
echo '        \ vifmimg epubpreview %px %py %pw %ph %c' >> echo '/.config/vifm/vifmrc'
echo '        \ %pc' >> echo '/.config/vifm/vifmrc'
echo '        \ vifmimg clear' >> echo '/.config/vifm/vifmrc'
echo '' >> echo '/.config/vifm/vifmrc'
echo '    fileviewer *.avi,*.mp4,*.wmv,*.dat,*.3gp,*.ogv,*.mkv,*.mpg,*.mpeg,*.vob,' >> echo '/.config/vifm/vifmrc'
echo '        \*.fl[icv],*.m2v,*.mov,*.webm,*.ts,*.mts,*.m4v,*.r[am],*.qt,*.divx,' >> echo '/.config/vifm/vifmrc'
echo '        \ vifmimg videopreview %px %py %pw %ph %c' >> echo '/.config/vifm/vifmrc'
echo '        \ %pc' >> echo '/.config/vifm/vifmrc'
echo '        \ vifmimg clear' >> echo '/.config/vifm/vifmrc'
echo '' >> echo '/.config/vifm/vifmrc'
echo '    fileviewer *.bmp,*.jpg,*.jpeg,*.png,*.xpm' >> echo '/.config/vifm/vifmrc'
echo '        \ vifmimg draw %px %py %pw %ph %c' >> echo '/.config/vifm/vifmrc'
echo '        \ %pc' >> echo '/.config/vifm/vifmrc'
echo '        \ vifmimg clear' >> echo '/.config/vifm/vifmrc'
echo '' >> echo '/.config/vifm/vifmrc'
echo '    fileviewer *.gif' >> echo '/.config/vifm/vifmrc'
echo '        \ vifmimg gifpreview %px %py %pw %ph %c' >> echo '/.config/vifm/vifmrc'
echo '        \ %pc' >> echo '/.config/vifm/vifmrc'
echo '        \ vifmimg clear' >> echo '/.config/vifm/vifmrc'
echo '' >> echo '/.config/vifm/vifmrc'
echo '    fileviewer *.ico' >> echo '/.config/vifm/vifmrc'
echo '        \ vifmimg magickpreview %px %py %pw %ph %c' >> echo '/.config/vifm/vifmrc'
echo '        \ %pc' >> echo '/.config/vifm/vifmrc'
echo '        \ vifmimg clear' >> echo '/.config/vifm/vifmrc'
echo '        ' >> echo '/.config/vifm/vifmrc'
echo '    fileviewer *.mp3' >> echo '/.config/vifm/vifmrc'
echo '        \ vifmimg audiopreview %px %py %pw %ph %c' >> echo '/.config/vifm/vifmrc'
echo '        \ %pc' >> echo '/.config/vifm/vifmrc'
echo '        \ vifmimg clear' >> echo '/.config/vifm/vifmrc'
echo '        ' >> echo '/.config/vifm/vifmrc'
echo '    fileviewer *.ttf *.otf' >> echo '/.config/vifm/vifmrc'
echo '        \ vifmimg fontpreview %px %py %pw %ph %c' >> echo '/.config/vifm/vifmrc'
echo '        \ %pc' >> echo '/.config/vifm/vifmrc'
echo '        \ vifmimg clear' >> echo '/.config/vifm/vifmrc'
