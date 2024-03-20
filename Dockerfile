From osrf/ros:noetic-desktop-full
LABEL description="This image is base ros image for our ownself."

RUN apt update && apt-get install -y --no-install-recommends \
    python3-pip \
    vim net-tools \
    python3-osrf-pycommon \
    python3-catkin-tools \
    unzip libtool git \
	  libprotobuf-dev protobuf-compiler \
	  libbullet-dev \
	  libsdl1.2-dev  \
	  libsdl-image1.2-dev \
	  libtar-dev \
	  language-pack-zh-hans \
	  fontconfig \
	  gdb xterm libcgal-dev

RUN apt update && apt install -y --no-install-recommends \
	ros-${ROS_DISTRO}-libg2o \
	ros-${ROS_DISTRO}-robot-upstart \
	ros-${ROS_DISTRO}-diagnostic-updater \
	ros-${ROS_DISTRO}-tf2-sensor-msgs \
	ros-${ROS_DISTRO}-map-server \
	ros-${ROS_DISTRO}-map-msgs \
	ros-${ROS_DISTRO}-costmap-converter \
	software-properties-common \
	inetutils-ping libgeographic-dev \
	ros-${ROS_DISTRO}-geographic-msgs

RUN apt update && apt install -y --no-install-recommends \
	ros-${ROS_DISTRO}-libdlib \
	ros-${ROS_DISTRO}-opengm \
	ros-${ROS_DISTRO}-cob-map-accessibility-analysis \
	ros-${ROS_DISTRO}-navigation libcoinutils-dev coinor-libcoinutils-dev

RUN apt update && apt install -y --no-install-recommends \
	coinor-libclp-dev coinor-libcbc-dev coinor-libcgl-dev
RUN rm -rf /var/lib/apt/lists/*

RUN useradd -ms /bin/bash ubt \
	&& cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
	&& echo 'Asia/Shanghai' > /etc/timezone \
	&& echo "ubt:ubtubt" | chpasswd \
	&& echo 'ubt    ALL=(ALL)   ALL' >> /etc/sudoers \
	&& ln -n /usr/bin/python3 /usr/bin/python \
	&& pip3 install trimesh \
	&& locale-gen zh_CN.UTF-8 \
	&& echo "export LC_ALL=zh_CN.UTF-8">> /etc/profile \
	&& rm -rf /var/lib/apt/lists/*
WORKDIR /home/ubt
USER ubt
RUN mkdir -p catkin_ws/src && echo "source /opt/ros/noetic/setup.bash" >> .bashrc \
	&& echo "if [ -f ~/catkin_ws/devel/setup.bash ];then" >> .bashrc \
	&& echo "  source ~/catkin_ws/devel/setup.bash" >> .bashrc \
	&& echo "fi" >> .bashrc
