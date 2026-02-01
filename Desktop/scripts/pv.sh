#!/usr/bin/env dash

FILE_PATH="/home/chaos/$1"

if [ -d "$1" ]; then
	tree --du -C -L 2 "$FILE_PATH"
# elif ! [ -f "$1" ]; then
#     echo $1 | read -A tokens
#     for token in $tokens; do
#         if [ -f $token ]; then
#             $bat --style=numbers --color=always --line-range :222 $token
#         fi
    # done
else
	FILE_MIME=$(file --mime "$FILE_PATH")
    filename=$(basename -- "$FILE_PATH")
    FILE_EXT="${filename##*.}"

    case $FILE_EXT in
        # This is copyed from my ~/.config/ranger/scope.sh
        # Archive
        7z|a|ace|alz|arc|arj|bz|bz2|cab|cpio|deb|gz|jar|lha|lz|lzh|lzma|lzo|\
        rpm|rz|t7z|tar|tbz|tbz2|tgz|tlz|txz|tZ|tzo|war|xpi|xz|Z|zip|rar)
            7z l -- "${FILE_PATH}" && exit 0
            exit 1;;

        # PDF
        # pdf)
        #     # Preview as text conversion
        #     pdftotext -l 10 -nopgbrk -q -- "${FILE_PATH}" - | fmt -w ${PV_WIDTH} && exit 0
        #     mutool draw -F txt -i -- "${FILE_PATH}" 1-10 | fmt -w ${PV_WIDTH} && exit 0
        #     exiftool "${FILE_PATH}" && exit 0
        #     exit 1;;


        # OpenDocument
        # odt|ods|odp|sxw)
        #     # Preview as text conversion
        #     odt2txt "${FILE_PATH}" && exit 0
        #     exit 1;;

        doc)
            # Preview as text conversion
            ccat --color=always "${FILE_PATH}" && exit 0
            exit 1;;
        docx)
            # Preview as text conversion
            docx2txt "${FILE_PATH}" - && exit 0
            exit 1;;

        # HTML
        htm|html|xhtml)
            # Preview as text conversion
            ccat --color=always "${FILE_PATH}" && exit 0
            ;; # Continue with next handler on failure

        [jJ][pP][gG]|\
		[jJ][pP][eE][gG]|\
		[gG][iI][fF]|\
		[bB][mM][pP]|\
		webp|svg|\
		[pP][nN][gG]|\
        [tT][iI][fF]|\
		[tT][iI][fF][fF])
            # chafa --width $[$COLUMNS - 20] --braille --color "${FILE_PATH}" && exit 0
            # img2sixel -h 300 -q low "${FILE_PATH}" && exit 0
            
            dim=${FZF_PREVIEW_COLUMNS}x${FZF_PREVIEW_LINES}
            chafa -f sixel -s "$dim" "${FILE_PATH}" && exit 0
            exit 1;;

        *)
            # if [[ $FILE_MIME == *binary ]] ; then
            #     echo "$FILE_MIME" 
            #     hexyl -n 4kB "$FILE_PATH" && exit 0
            # else
                # bat -p --color=always "${FILE_PATH}" && exit 0
                ccat --bg="light" --color=always "${FILE_PATH}" && exit 0
            # fi
            exit 1;;
    esac

fi
