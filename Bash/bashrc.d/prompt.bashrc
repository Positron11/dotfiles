# source git
source /usr/share/git-core/contrib/completion/git-prompt.sh

# load prompt type
if [ -f ~/.prompt_style ]; then
	PROMPT_STYLE=$(<~/.prompt_style)
fi

# prompt function
function __custom_prompt {
	# get exit code
	EXIT_CODE="$?"
	
	# if running terminal in GUI
	if [ "${TERM}\]" != "linux" ]; then			
		# directory indicator
		local DIRECTORY="\[${BOLD}\]\[${BLUE}\][\[${RED}\]\w\[${BLUE}\]]\[${ENDSTYLE}\]"
	
		# directory badges
		local GIT=$([[ $(__git_ps1) ]] && echo " \[${BOLD}\]\[${YELLOW}\]($(__git_ps1 '%s'))\[${ENDSTYLE}\]")
		local VENV=$([[ $VIRTUAL_ENV != "" ]] && echo " \[${BOLD}\]\[${MAGENTA}\]($(basename ${VIRTUAL_ENV}))\[${ENDSTYLE}\]")
		
		# exit code dependent head colouring
		local HEAD="\[${BOLD}\]$([[ $EXIT_CODE != 0 ]] && echo "\[${RED}\]" || echo "\[${GREEN}\]"):\[${ENDSTYLE}\]"
		
		# export bash prompt
		export PS1="\n${DIRECTORY}${GIT}${VENV} ${HEAD} "
	fi
}

# set directory truncation
PROMPT_DIRTRIM=3

# set prompt command
PROMPT_COMMAND="__custom_prompt"
