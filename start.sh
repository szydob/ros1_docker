#!/bin/bash

# Navigate to the ROS workspace
cd /home/dv_ws_ros1

# Install dependencies using rosdep
apt-get update
apt-get install -y python3-rosdep
rosdep init
rosdep update
rosdep install --from-paths src --ignore-src -r -y

# Install specific ROS package
apt-get install -y ros-noetic-ackermann-msgs

# Source ROS Noetic environment
source /opt/ros/noetic/setup.bash
catkin_make
cd ..
source /home/dv_ws_ros1/devel/setup.bash

# Start the ROS master in the background
roscore &

# Allow some time for roscore to start
sleep 5

# Play rosbag
rosbag play /home/rosbag1/bag1.bag -l &

#Launch rviz
rviz -l &

# Allow some time for the rosbag to start
sleep 5
source /home/dv_ws_ros1/devel/setup.bash

# Launch the ROS node
roslaunch patchworkpp demo.launch 

wait
