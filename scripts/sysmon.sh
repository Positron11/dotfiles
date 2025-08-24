#!/bin/bash

# get ids of all existing ptyxis windows
mapfile -t old_ids < <(gdbus call --session --dest org.gnome.Shell \
    --object-path /org/gnome/Shell/Extensions/Windows \
    --method org.gnome.Shell.Extensions.Windows.List \
    | head -c -4 | tail -c +3 | jq -c '.[] | select (.wm_class == "org.gnome.Ptyxis") | .id')

# open new ptyxis with btop profile
ptyxis --new-window --tab-with-profile 2a99a9e25efb1ca322ce793f67a8cff3 &

# limit no. of tries to avoid inf. loop
limit=1000
i=0

# keep checking until new window appears	
while [ $i -lt $limit ]; do    
    # get the new list of ptyxis window ids
	mapfile -t new_ids < <(gdbus call --session --dest org.gnome.Shell \
        --object-path /org/gnome/Shell/Extensions/Windows \
        --method org.gnome.Shell.Extensions.Windows.List \
        | head -c -4 | tail -c +3 | jq -c '.[] | select (.wm_class == "org.gnome.Ptyxis") | .id')

    [[ ${#old_ids[@]} -eq ${#new_ids[@]} ]] || break
    
    let "i++"
    sleep 0.1
done

id=0
found=false

# find the new ptyxis window
for i in "${new_ids[@]}"; do
	# compare each id in new list with each in old, mark as found if matches
    for j in "${old_ids[@]}"; do
        [[ "$i" == "$j" ]] && found=true
    done
    
    # if not found, this is the id we're looking for
    [[ "$found" == false ]] && { id=$i; break; }
	
	# reset found counter
	found=false
done

# set dimensions
SCREEN=(1920 1080)
WINDOW=(1200 800)

# compute top left corner coordinates
COORDINATES=($(( (SCREEN[0] - WINDOW[0]) / 2 )) $(( (SCREEN[1] - WINDOW[1]) / 2 + 12 )))

# maximize the found window
gdbus call --session --dest org.gnome.Shell \
    --object-path /org/gnome/Shell/Extensions/Windows \
    --method org.gnome.Shell.Extensions.Windows.Maximize $id
