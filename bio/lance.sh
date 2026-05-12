#!/usr/bin/env bash
printf "%0.s-" {1..18}
echo -e "\nstarting lance tests"
printf "%0.s-" {1..18}

# moving faerie
echo -e "\n\nmoving faerie up"
ros2 topic pub -t 3 /bio/faerie/control astra_msgs/msg/FaerieControl \
  "{move_faerie: 1.0, drill_speed: 0.0, drill_laser: false}"

echo -e "\nmoving faerie down"
ros2 topic pub -t 3 /bio/faerie/control astra_msgs/msg/FaerieControl \
  "{move_faerie: -1.0, drill_speed: 0.0, drill_laser: false}"

echo -e "\nstopping faerie"
ros2 topic pub -1 /bio/faerie/control astra_msgs/msg/FaerieControl \
  "{move_faerie: 0.0, drill_speed: 0.0, drill_laser: false}"

# drill
echo -e "\nstarting drill"
ros2 topic pub -1 /bio/faerie/control astra_msgs/msg/FaerieControl \
  "{move_faerie: 0.0, drill_speed: 1.0, drill_laser: false}" 

echo -e "\nstopping drill"
ros2 topic pub -1 /bio/faerie/control astra_msgs/msg/FaerieControl \
  "{move_faerie: 0.0, drill_speed: 0.0, drill_laser: false}" 

# laser
echo -e "\nlaser on"
ros2 topic pub -1 /bio/faerie/control astra_msgs/msg/FaerieControl \
  "{move_faerie: 0.0, drill_speed: 0.0, drill_laser: true}"

echo -e "\nlaser off"
ros2 topic pub -1 /bio/faerie/control astra_msgs/msg/FaerieControl \
  "{move_faerie: 0.0, drill_speed: 0.0, drill_laser: false}"

echo "done with lance tests"
