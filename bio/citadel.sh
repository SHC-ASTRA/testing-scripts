printf "%0.s-" {1..18}
echo -e "\nstarting citadel tests"
printf "%0.s-" {1..18}

echo -e "\n\nclosing all distributors"
ros2 topic pub /bio/control/distributor astra_msgs/BioDistributor \
  "{distributor_id: [false, false, false]}" &
PID=$!
sleep 3
kill $PID

echo -e "\nopening all distributors"
ros2 topic pub /bio/control/distributor astra_msgs/BioDistributor \
  "{distributor_id: [true, true, true]}" &
PID=$!
sleep 3
kill $PID

# Test tubes
for i in {0..2}; do
  echo "opening tube $i to 5 milliliters"
  ros2 service call /bio/control/test_tube astra_msgs/BioTestTube \
    "{tube_id: $i, milliliters: 5.0}"
  sleep 3
done

# Vacuum action 
for i in {0..2}; do
  echo "opening valve $i, running vac for 1 sec at 20% duty cycle"
  ros2 action send_goal /bio/actions/vacuum astra_msgs/BioVacuum \
    "{valve_id: $i, fan_duty_cycle_percent: 20, fan_time_ms: 1000}"
  sleep 5
done

echo "done with citadel tests"
