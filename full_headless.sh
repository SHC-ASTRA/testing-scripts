#!/usr/bin/env bash

trap abort INT

function abort() {
    # kitten @ close-tab --match title:"Fake Serial|Anchor|Headless|Serial Viewer" #fix later
    kitten @ close-tab --match "not state:focused and state:parent_focused" #hacky workaround because youll probably be focusing the window if you kill it
    echo 
    exit 0
}

kitten @ launch --type=tab --tab-title "Fake Serial" socat -dd -v pty,rawer,crnl,link=/tmp/ttyACM9 pty,rawer,crnl,link=/tmp/ttyOUT
kitten @ launch --type=tab --tab-title "Serial Viewer" tio /tmp/ttyACM9

kitten @ launch --type=tab --cwd current --tab-title "Anchor" 
kitten @ launch --type=tab --cwd current --tab-title "Headless" 

kitty @ send-text --match-tab title:"Anchor|Headless" source install/setup.bash'\n'
kitty @ send-text --match-tab title:"Anchor|Headless" colcon build --symlink-install'\n'

kitty @ send-text --match-tab title:Anchor ros2 launch anchor_pkg rover.launch.py connector:=serial serial_override:=/tmp/ttyACM9'\n'
kitty @ send-text --match-tab title:Headless ros2 run headless_pkg headless_full'\n'

read -r -d '' _ </dev/tty #keep script open

