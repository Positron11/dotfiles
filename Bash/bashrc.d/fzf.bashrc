# set ctrl+r (command history) options
export FZF_CTRL_R_OPTS="
	--style full"

# set ctrl+t (file fuzzy finder) options
export FZF_CTRL_T_OPTS="
	--style full 
	--walker-skip .git,node_modules,target
	--preview 'bat -n --color=always {}'
	--bind 'ctrl-/:change-preview-window(down|hidden|)'"

# initialize fzf
eval "$(fzf --bash)"
