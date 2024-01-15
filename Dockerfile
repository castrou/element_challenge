FROM osrf/ros:humble-desktop-full

# Minimal setup
RUN apt-get update \
 && apt-get install -y locales lsb-release wget gnupg
ARG DEBIAN_FRONTEND=noninteractive
RUN dpkg-reconfigure locales

ENV XDG_RUNTIME_DIR=/tmp

# User Setup
RUN useradd -ms /bin/bash element && usermod -aG sudo element
RUN echo 'element:robotics' | chpasswd

# Gazebo Setup
RUN wget https://packages.osrfoundation.org/gazebo.gpg -O /usr/share/keyrings/pkgs-osrf-archive-keyring.gpg
RUN echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/pkgs-osrf-archive-keyring.gpg] http://packages.osrfoundation.org/gazebo/ubuntu-stable $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/gazebo-stable.list > /dev/null
RUN apt-get update
RUN apt-get install -y ignition-fortress ros-humble-gazebo-ros-pkgs libgl1-mesa-dri

# Environment Setup
USER element
WORKDIR /home/element/

RUN echo "source /usr/share/gazebo/setup.sh" >> /home/element/.bashrc
COPY ./gazebo/ /home/element/.gazebo/
ENV IGN_VERSION=fortress
ENV IGN_GAZEBO_RESOURCE_PATH=${IGN_GAZEBO_RESOURCE_PATH}:/home/element/.gazebo/models
ENV GAZEBO_MODEL_PATH=${GAZEBO_MODEL_PATH}:/home/element/.gazebo/models
ENV IGN_GAZEBO_RESOURCE_PATH=${IGN_GAZEBO_RESOURCE_PATH}:/home/element/.gazebo/worlds
ENV GAZEBO_RESOURCE_PATH=${GAZEBO_MODEL_PATH}:/home/element/.gazebo/worlds