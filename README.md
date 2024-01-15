# Element Robotics Challenge

This repository contains code that attempts to solve the problem set out by Element Robotics
consisting of a simple simulation of a rover using Nav2, ROS 2.0 - Humble, and Docker.

## Setup Process
The docker container can be built by running the `docker_setup.sh` script.  
  
Once the container has been built, it can be run using the `run_docker.sh` script.


## Issues
A lot of time was lost trying to get the Gazebo `moon.world` working, which resulted in running out the clock. This arose from a lack of familiarity with Gazebo, in particular Fortress, which uses Ignition. As such, the majority of functionality is lacking, with only a simple Dockerfile as an outcome.   

1) Whilst GUI applications are launched from within the docker, the following error appears:
```bash
QStandardPaths: runtime directory '/tmp' is not owned by UID 1000, but a directory permissions 0777 owned by UID 0 GID 0
MESA: error: Failed to query drm device.
libGL error: glx: failed to create dri3 screen
libGL error: failed to load driver: iris
```
It's unknown what the cause of this problem is, or how problematic it is in general.

2) `ign gazebo moon.world` is much slower through the docker, and does not correctly load the texture, often crashing once the landscape appears. It's possible that this arises from (2) but has not been confirmed.
