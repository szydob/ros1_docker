# Use the official ROS Noetic base image
FROM osrf/ros:noetic-desktop-full

SHELL ["/bin/bash", "-c"]

# Setup system dependencies
RUN apt update -y && apt upgrade -y && apt-get install -y \
    libx11-xcb1 \
    libgl1-mesa-glx \
    libxkbcommon-x11-0 \
    && rm -rf /var/lib/apt/lists/*

# Source ROS Noetic environment
RUN echo "source /opt/ros/noetic/setup.bash" >> ~/.bashrc

# Copy the start script into the container
COPY start.sh /home/start.sh
RUN chmod +x /home/start.sh

