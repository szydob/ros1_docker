#!/bin/bash

# Source ROS Noetic environment
source /opt/ros/noetic/setup.bash
cd /home/dv_ws
catkin_make
cd ..
source /home/dv1_ws/devel/setup.bash

# Play rosbag
rosbag play /home/rosbag1/bag1.bag -l &

sleep 5
source /home/dv1_ws/devel/setup.bash
# Launch the ROS node
roslaunch patchworkpp demo.launch

