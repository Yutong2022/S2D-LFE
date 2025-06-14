# DV ROS FOR LFE CAPTURE SYSTEM

ROS drivers and sample nodes for lfes capturing and the DV software infrastructure.

---

## Table of Contents
- [DV ROS FOR LFE CAPTURE SYSTEM](#dv-ros-for-lfe-capture-system)
  - [Table of Contents](#table-of-contents)
  - [Overview](#overview)
  - [Installation on Ubuntu](#installation-on-ubuntu)
    - [Ubuntu 18.04](#ubuntu1804)
    - [Ubuntu 20.04](#ubuntu2004)
    - [Additional ROS dependencies (example for ROS Noetic on Ubuntu 20.04)](#additional-ros-dependencies-example-for-rosnoetic-on-ubuntu2004)
    - [Building the project](#building-the-project)
  - [Verifying the Build](#verifying-the-build)
  - [Compatibility](#compatibility)
  - [Repository Structure](#repository-structure)
  - [Custom Workspace Configuration](#custom-workspace-configuration)
  - [License](#license)

---

## Overview
DV ROS provides a unified ROS interface for **iniVation** DAVIS / DVS / DVXplorer cameras. The package delivers:

* Drivers capable of live streaming or playing back *aedat4* files.
* Core message definitions compatible with the well‑known `rpg_dvs_ros` types.
* Utility nodes for accumulation, visualisation, feature tracking and file conversion.

---

## Installation on Ubuntu
> **Note** — All commands must be run on the host machine (not inside a container) with sudo privileges.

### Ubuntu 18.04
```bash
sudo add-apt-repository ppa:ubuntu-toolchain-r/test
sudo add-apt-repository ppa:inivation-ppa/inivation-bionic
sudo apt update
sudo apt install dv-processing dv-runtime-dev gcc-10 g++-10
```

### Ubuntu 20.04
```bash
sudo add-apt-repository ppa:inivation-ppa/inivation
sudo apt update
sudo apt install dv-processing dv-runtime-dev gcc-10 g++-10
```

### Additional ROS dependencies (example for ROS Noetic on Ubuntu 20.04)
```bash
sudo apt install python3-catkin python3-catkin-tools \
                 ros-noetic-catkin ros-noetic-camera-info-manager
```

### Building the project
Assuming you are inside your *catkin* workspace root:

```bash
cd src
# Clone the repository
git clone https://gitlab.com/inivation/dv/dv-ros.git
cd ..
# Build with GCC 10
catkin build --cmake-args -DCMAKE_C_COMPILER=gcc-10 -DCMAKE_CXX_COMPILER=g++-10
```

---

## Verifying the Build
After compiling, source the workspace and launch the visualisation node to confirm that events are being streamed correctly:

```bash
source devel/setup.bash
roslaunch dv_ros_visualization event_visualization.launch
```
You should see a live preview of events coming from the connected **iniVation** camera.

---

## Compatibility
The event message definitions (`Event`, `EventArray`) are wire‑compatible with the [**rpg_dvs_ros**](https://github.com/uzh-rpg/rpg_dvs_ros) ecosystem.   
`dv_ros_capture` acts as a unified replacement for the legacy `davis_ros_driver`, `dvs_ros_driver` and `dvxplorer_ros_driver` nodes.

---

## Repository Structure
| Package | Purpose |
|---------|---------|
| **dv_ros_msgs**            | Core ROS message definitions for event cameras |
| **dv_ros_messaging**       | C++ headers enabling **dv‑processing** in ROS nodes |
| **dv_ros_capture**         | Driver node for live cameras and *aedat4* playback |
| **dv_ros_accumulation**    | Event‑stream‑to‑frame accumulation utilities |
| **dv_ros_aedat4**          | Conversion between *aedat4* files and ROS bags |
| **dv_ros_runtime_modules** | DV runtime modules adapted for ROS |
| **dv_ros_visualization**   | Lightweight event visualiser |
| **dv_ros_tracker**         | Lucas–Kanade feature trackers for event & image streams |

---

## Custom Workspace Configuration
Below is an example setup used internally.  Feel free to adapt it to your own directory layout.

1. **Create a dedicated workspace**

```bash
mkdir -p ~/catkin_dvs_ws/src
cd ~/catkin_dvs_ws
```

2. **Clone DV ROS** (see *Building the project* section above) and build once.

3. **Append the following lines to `~/.bashrc`** so that the environment is loaded automatically and convenient aliases are available:

```bash
# DV ROS workspace
source "$HOME/catkin_dvs_ws/devel/setup.bash"

# Re‑build selected DV ROS packages in Release mode using GCC 10
alias dvsbuild='cd ~/catkin_dvs_ws && \
  catkin build dv_ros_accumulation dv_ros_capture dv_ros_imu_bias \
               dv_ros_messaging dv_ros_runtime_modules \
               dv_ros_tracker dv_ros_visualization \
               -DCMAKE_BUILD_TYPE=Release \
               --cmake-args -DCMAKE_C_COMPILER=gcc-10 -DCMAKE_CXX_COMPILER=g++-10'

# Run helper script for demonstration / testing
alias dvsrun='cd ~/catkin_dvs_ws/src/Event_based_VO-VIO-SLAM/driver_code/dv-ros-master/script && sh run.sh'
```

After re‑opening your terminal, use `dvsbuild` anytime you wish to re‑compile the selected DV ROS packages, and `dvsrun` to launch the custom demo script.

---

## License
This project is distributed under the Apache 2.0 license unless noted otherwise.  See the `LICENSE` file for full details.

