# Use the official ROS Noetic base image
FROM osrf/ros:noetic-desktop-full

SHELL ["/bin/bash", "-c"]

# Setup system dependencies
RUN apt update -y && apt upgrade -y && apt-get install -y \
    libx11-xcb1 \
    libgl1-mesa-glx \
    libxkbcommon-x11-0 \
    && rm -rf /var/lib/apt/lists/*

# Set up working directory and permissions
WORKDIR /home/dv1_ws
RUN mkdir -p src && chmod -R 777 /home/dv1_ws
RUN mkdir -p /home/rosbag1 && chmod -R 777 /home/rosbag1

# Source ROS Noetic environment
RUN echo "source /opt/ros/noetic/setup.bash" >> ~/.bashrc

# Copy start script into container
COPY dv1_ws/start.sh /home/dv1_ws/start.sh
RUN chmod +x /home/dv1_ws/start.sh

# Build workspace
RUN /bin/bash -c "source /opt/ros/noetic/setup.bash && cd /home/dv1_ws && catkin_make"

# Set the entrypoint
ENTRYPOINT ["/home/dv1_ws/start.sh"]

