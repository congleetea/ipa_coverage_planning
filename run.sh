#!/usr/bin/env bash
#   Copyright (C) 2024 All rights reserved.
#   FileName      ：run.sh
#   Author        ：congleetea
#   Email         ：congleetea@163.com
#   Date          ：2024年03月19日
#   Description   ：

CONTAINER_NAME=ros_noetic_builder
PROJECT=ipa_coverage_planning
if [[ -n $(docker ps -q -f "name=$CONTAINER_NAME") ]];then
	echo "exec...."
	docker exec -it $CONTAINER_NAME bash
else
	echo "run...."
	docker run -ti --rm  --network host --env="DISPLAY" --name $CONTAINER_NAME \
		-v /home/$USER/.Xauthority:/home/ubt/.Xauthority:rw \
		-v $HOME/.ros/catkin_ws/build:/home/ubt/catkin_ws/build \
		-v $HOME/.ros/catkin_ws/devel:/home/ubt/catkin_ws/devel \
		-v $PWD:/home/ubt/catkin_ws/src/$PROJECT \
		--rm myros:noetic /bin/bash
fi
