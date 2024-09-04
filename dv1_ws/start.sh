#!/bin/bash

cd /home/dv1_ws

# Install dependencies
apt-get update
apt-get install -y ros-noetic-ackermann-msgs

# Source ROS Noetic environment
source /opt/ros/noetic/setup.bash
catkin_make
cd ..
source /home/dv1_ws/devel/setup.bash

# Start the ROS master
roscore &
sleep 5

# Play rosbag
rosbag play /home/rosbag1/bag1.bag -l &

sleep 5
source /home/dv1_ws/devel/setup.bash
# Launch the ROS node
roslaunch patchworkpp demo.launch

