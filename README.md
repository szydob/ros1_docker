# Docker ROS1 Noetic for Running ROS Bags

## About the Setup
This Docker environment is designed to run **ROS1 Noetic** specifically for replaying ROS bags in a containerized ROS workspace.

## Prerequisites
- Docker installed on your machine
- Docker Compose installed

## How to Set Up and Run

### Step 1: Create the ROS1 Workspace Directory
Start by creating a directory called `ros1_ws` on your host machine:

```bash
mkdir ros1_ws
```

### Step 2: Add the Necessary Files
- Clone your `driverless-software` repository into the `dv1_ws/src` directory:

    ```bash
    git clone <driverless-software-repo-url> ros1_ws/dv1_ws/src
    ```

- Place your ROS bag files (e.g., `bag1.bag`) into a directory named `rosbag1` inside `ros1_ws`:

    ```bash
    mkdir ros1_ws/rosbag1
    cp /path/to/your/rosbag.bag ros1_ws/rosbag1
    ```

### Step 3: Edit the Start Script
You will need to edit the `start.sh` script located in `ros1_ws/dv1_ws` to match your specific ROS bag file names and paths.

- Open the `start.sh` file for editing:

    ```bash
    nano ros1_ws/dv1_ws/start.sh
    ```

- Modify the script to correctly reference your ROS bags. For example, if your bag file is named `bag1.bag`, ensure the script points to it correctly:

    ```bash
    rosbag play /home/rosbag1/bag1.bag -l &
    ```

### Step 4: Run the Docker Container
To start the Docker container using Docker Compose:

- If you haven't built the Docker image yet, or if you have made changes and want to rebuild it, use:

    ```bash
    docker compose up --build
    ```

- If the image is already built and you just want to start the container:

    ```bash
    docker compose up
    ```

### Step 5: Access the Running Container
The container will automatically execute the start script, which sources the ROS environment and plays the specified ROS bag.

## Troubleshooting
- **ROS bags not found or playback errors**: Ensure that your `start.sh` script is correctly referencing the ROS bag files and that the paths are accurate.

