# display sysinfo at startup if running specific apps
if [[ $(ps -o comm= -p $(ps -o ppid= -p $$)) =~ (ptyxis-agent) ]]; then
	macchina -U
fi
