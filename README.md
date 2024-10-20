# Docker ROS1 Noetic Setup Guide

## Overview
This setup guide provides step-by-step instructions for running **ROS1 Noetic** in a Docker container, specifically designed for replaying ROS bags in a containerized ROS workspace.

## Prerequisites
Ensure you have the following software installed on your machine:
- [Docker](https://docs.docker.com/get-started/)
- [Docker Compose](https://docs.docker.com/compose/install/)

## Setup Instructions

### Step 1: Create the ROS1 Workspace Directory
Create the workspace directory structure on your machine:
```bash
mkdir -p ~/dv_ws_ros1/src
```

### Step 2: Clone Your ROS Workspace Repository
Clone your ROS workspace into the `src` directory:
```bash
git clone <your-repo-url> ~/dv_ws_ros1/src
```

### Step 3: Set Up the ROS Bag Directory
Create a directory for your ROS bag files and add your ROS bags:
```bash
mkdir ~/rosbag1
cp path/to/your/bag1.bag ~/rosbag1/
```

### Step 4: Update the Start Script
Ensure the `start.sh` script references your ROS bag files correctly.

1. Open the `start.sh` file:
   ```bash
   nano ros1_docker/start.sh
   ```
2. Update the line referencing the ROS bag file to:
   ```bash
   rosbag play /home/rosbag1/bag1.bag -l &
   ```

If you would like to launch different nodes, modify the **"Launch the ROS node"** section in the `start.sh` file. The container will automatically execute the `start.sh` script to set up the ROS environment and replay the specified ROS bag. Adjust `start.sh` as needed to fit your requirements.

### Step 5: Build and Run the Docker Container
To build and start the Docker container, use the following commands:

1. If you are building the image for the first time or after making changes:
   ```bash
   docker compose up --build
   ```
2. If the image is already built and you only need to start the container:
   ```bash
   docker compose up
   ```

## Troubleshooting

- **ROS Bag Playback Issues**:
  - Verify that your `start.sh` script correctly points to the bag file location: `/home/rosbag1/bag1.bag`.
  - Confirm that the bag files are present in the `~/rosbag1` directory.

- **Problems Running `docker-compose up --build`**:
  - If you encounter build or run errors, clean up unused Docker containers with:
    ```bash
    docker container prune
    ```
  - Then, rebuild and run the container:
    ```bash
    docker compose up --build
    ```

- **RViz Not Launching**:
  - Try accessing the Docker shell and starting RViz manually:
    ```bash
    docker exec -it ros_container bash
    rviz
    ```

## Additional Tips

- **Accessing the Docker Shell**:
  - To interact with the running container's shell, open a new terminal window and run:
    ```bash
    xhost +local:docker  # Grants Docker access to your X11 server for GUI applications
    docker exec -it ros_container bash  # Access the container's shell
    ```
  - Once inside the container, you can run commands like `rviz`. To exit the container shell, simply type:
    ```bash
    exit
    ```

- **Cleaning Up Unused Docker Images**:
  - To list existing images, run:
    ```bash
    docker images
    ```
  - To remove unused images:
    ```bash
    docker rmi <image-id>
    ```