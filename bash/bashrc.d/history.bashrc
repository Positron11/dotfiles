# append to the history file instead of overwriting it
shopt -s histappend

# large history
export HISTSIZE=1000000
export HISTFILESIZE=1000000

# history control
# - ignoredups: don't record the same command twice in a row
# - erasedups: remove older occurrences of duplicates
export HISTCONTROL="ignoredups:erasedups"

# ignore simple/safe commands from being saved
export HISTIGNORE="ls:ll:la:bg:fg:clear:history:pwd:exit"

# add timestamps to history
export HISTTIMEFORMAT='%F %T '

# write multiline commands as a single line
shopt -s cmdhist

# record each command immediately
PROMPT_COMMAND="history -a;$PROMPT_COMMAND"

