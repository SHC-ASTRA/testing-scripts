#!/usr/bin/env bash
printf "%0.s-" {1..18}
echo -e "\nstarting citadel tests"
printf "%0.s-" {1..18}

echo -e "\n\nclosing all distributors"
ros2 topic pub -1 /bio/citadel/control astra_msgs/msg/CitadelControl \
  "{distributor_id: [false, false, false], move_scythe: 0.0, vibration_motor: false}"

echo -e "\nopening all distributors"
ros2 topic pub -1 /bio/citadel/control astra_msgs/msg/CitadelControl \
  "{distributor_id: [true, true, true], move_scythe: 0.0, vibration_motor: false}"

# Test tubes
for i in {0..2}; do
  echo "opening tube $i to 5 milliliters"
  ros2 service call /bio/test_tube astra_msgs/srv/BioTestTube \
    "{tube_id: $i, milliliters: 5.0}"
  sleep 3
done

# Scythe
echo -e "\nmoving scythe up"
ros2 topic pub -t 3 /bio/citadel/control astra_msgs/msg/CitadelControl \
  "{distributor_id: [false, false, false], move_scythe: 1.0, vibration_motor: false}"

echo -e "\nmoving scythe down"
ros2 topic pub -t 3 /bio/citadel/control astra_msgs/msg/CitadelControl \
  "{distributor_id: [false, false, false], move_scythe: -1.0, vibration_motor: false}"

echo -e "\nstopping scythe"
ros2 topic pub -1 /bio/citadel/control astra_msgs/msg/CitadelControl \
  "{distributor_id: [false, false, false], move_scythe: 0.0, vibration_motor: false}"

# Vacuum action
for i in {0..2}; do
  echo "opening valve $i, running vac for 1 sec at 20% duty cycle"
  ros2 action send_goal /bio/vacuum astra_msgs/action/BioVacuum \
    "{valve_id: $i, fan_duty_cycle_percent: 20, fan_time_ms: 1000}"
  sleep 5
done

echo "done with citadel tests"
