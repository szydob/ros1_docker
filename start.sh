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
roscore &  # Starts roscore, the main communication hub for ROS nodes

# Allow some time for roscore to start
sleep 5

# Play rosbag in loop mode in the background
rosbag play /home/rosbag1/bag1.bag -l &  # -l flag loops the playback of the bag file

# Allow some time for the rosbag to start
sleep 5

# Source the workspace again to ensure environment variables are set
source /home/dv_ws_ros1/devel/setup.bash

# Launch rviz in the background to visualize data
rviz &  # Starts RViz for data visualization

# Launch the ROS node
roslaunch patchworkpp demo.launch  # Replace with your specific ROS node launch command

# Wait for all background processes to finish
wait
