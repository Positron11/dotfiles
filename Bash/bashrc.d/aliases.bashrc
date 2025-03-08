# safer move and copy
alias mv='mv -i'
alias cp='cp -i'

# sort files by size, display human readable format
alias lt='ls --human-readable --size -1 -S --classify'

# move all files in subdirectories to current directory
alias expose='find . -type f | while IFS= read -r file ; do mv -i < /dev/tty "$file" . ; done'

# sanitize filenames
alias sanitize='find . -type f | while IFS= read -r file ; do mv "$file" "${file%/*}/$(echo ${file##*/} | tr "[:upper:]" "[:lower:]" | tr " " "_")" ; done'
