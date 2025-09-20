# open
alias open='xdg-open'

# safer move and copy
alias mv='mv -i'
alias cp='cp -i'

# sort files by size, display human readable format
alias lt='ls --human-readable --size -1 -S --classify'

# move all files in subdirectories to current directory
alias expose='find . -type f | while IFS= read -r file ; do mv -i < /dev/tty "$file" . ; done'

# sanitize filenames
alias sanitize='find . -type f | while IFS= read -r file ; do mv "$file" "${file%/*}/$(echo ${file##*/} | tr "[:upper:]" "[:lower:]" | tr " " "_")" ; done'

# seeded password generator
genpass () {    
	CLIENT=$1

	PASSWORD=""
    
    echo -e -n "${GRAY}>${ENDSTYLE} ${BOLD}Master key:${ENDSTYLE} "
    
	# asterisk display asterisks in place of password chars
    while IFS= read -r -s -n 1 char; do
        # break on newline
        if [[ $char == $'\0' || $char == $'\n' ]]; then
            break

        # handle backspaces
        elif [[ $char == $'\177' ]]; then
            if [[ -n $PASSWORD ]]; then
                PASSWORD="${PASSWORD%?}" # remove last char
                echo -ne "\b \b" # erase asterisk
            fi
        
        else
            PASSWORD+="$char"
            echo -n '*'
        fi
    done
    
    echo -e "\n${GREEN}>${ENDSTYLE} Passkey for \"${CLIENT:-"-"}\" copied to clipboard"
	
	echo "${PASSWORD}${CLIENT}" | sha256sum - | cut -d" " -f1 | xxd -r -p | base64 | tr -d -c [:alnum:] | xclip -selection c
}
