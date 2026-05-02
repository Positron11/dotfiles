_fmt_duration() {
	local duration=$1
	
	local -i ms=$(( ${duration%.*} * 1000 + 10#${duration#*.} / 1000 ))
	local -i secs=${duration%.*}
   
	if   (( ms < 1000 )); then printf '%dms' "$ms"
	elif (( secs < 60 )); then printf '%.1fs' "$duration"
	
	else 
		mins=$(( secs / 60 ))
		rem=$(( secs % 60 ))
		
		printf '%dm%ds' "$mins" "$rem"
	fi
}

preexec_timer() {
	[[ "$BASH_COMMAND" == "$PROMPT_COMMAND" ]] && return
	_cmd_start=$EPOCHREALTIME
}

prompt_command() {
	local ret=$?
	local status="${RED}${BOLD}${ret}${ENDSTYLE}"
	
	(( ret == 0 )) && status="${GREEN}${BOLD}OK${ENDSTYLE}"
	
	local ts=$(date +%H:%M:%S)

	if [[ -n "$_cmd_start" ]]; then
		_cmd_time=$(awk "BEGIN{print $EPOCHREALTIME - $_cmd_start}")
		unset _cmd_start
	fi
	
	local venv=""

	[[ -n "$VIRTUAL_ENV" ]] && venv="${VIRTUAL_ENV##*/}: "
	
	local branch=$(git branch --show-current 2>/dev/null)
	local git=""
	
	[[ -n "$branch" ]] && git=" (${branch})"

	PS1="
┌ ${status} ${DIM}${ts} - $(_fmt_duration ${_cmd_time:-0})${ENDSTYLE}
│ ${venv}${UNDERLINE}\w${ENDSTYLE}${git}
│
╰─>>> "
}

# pre-execution hook for timer start
trap 'preexec_timer' DEBUG

# newline between prompt and output
PS0='\n'

PROMPT_COMMAND=prompt_command
