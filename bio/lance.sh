#!/usr/bin/env bash
printf "%0.s-" {1..18}
echo -e "\nstarting lance tests"
printf "%0.s-" {1..18}

# moving faerie
echo -e "\n\nmoving faerie up"
ros2 topic pub /bio/control/faerie astra_msgs/FaerieControl \
 "{move_faerie: 1.0}"
PID=$!
sleep 3
kill $PID

echo -e "\nmoving faerie down"
ros2 topic pub /bio/control/faerie astra_msgs/FaerieControl \
 "{move_faerie: -1.0}"
PID=$!
sleep 3
kill $PID

# vibrating faerie
echo -e "\nvibrating motor"
ros2 topic pub /bio/control/faerie astra_msgs/FaerieControl \
 "{vibration_motor: true}"
PID=$!
sleep 3
kill $PID

echo -e "\nstopping vibration"
ros2 topic pub /bio/control/faerie astra_msgs/FaerieControl \
 "{vibration_motor: false}"
PID=$!
sleep 1
kill $PID

# starting drill (scabbard)
echo -e "\nstarting drill"
ros2 topic pub /bio/control/faerie astra_msgs/FaerieControl \
 "{drill_speed: 1.0}"
PID=$!
sleep 3
kill $PID

echo -e "\nstopping drill"
ros2 topic pub /bio/control/faerie astra_msgs/FaerieControl \
 "{drill_speed: 0.0}"
PID=$!
sleep 1
kill $PID

# moving scythe
echo -e "\nmoving scythe up"
ros2 topic pub /bio/control/scythe astra_msgs/ScytheControl \
 "{move_scythe: 1.0}"
PID=$!
sleep 3
kill $PID

echo -e "\nmoving scythe down"
ros2 topic pub /bio/control/scythe astra_msgs/ScytheControl \
 "{move_scythe: -1.0}"
PID=$!
sleep 3
kill $PID

echo "done with lance tests"
