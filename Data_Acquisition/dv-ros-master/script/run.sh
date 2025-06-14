# Start roscore
gnome-terminal --tab -e 'bash -c "roscore; exec bash"'
sleep 1s

# -------- DAVIS346 cameras --------
gnome-terminal --tab -e 'bash -c "roslaunch dv_ros_visualization right_davis346.launch; exec bash"'
gnome-terminal --tab -e 'bash -c "roslaunch dv_ros_visualization left_davis346.launch; exec bash"'

# -------- DVXplorer cameras --------
gnome-terminal --tab -e 'bash -c "roslaunch dv_ros_visualization right_dvxplorer.launch; exec bash"'
gnome-terminal --tab -e 'bash -c "roslaunch dv_ros_visualization left_dvxplorer.launch; exec bash"'

# -------- Infra-red camera (optional) --------
# gnome-terminal --tab -e 'bash -c "roslaunch hikrobot_infrared_camera infrared_camera.launch; exec bash"'

# -------- Visualisation GUI --------
gnome-terminal --tab -e 'bash -c "roslaunch dv_ros_visualization rqt_visualization.launch; exec bash"'

# -------- Record to rosbag (optional) --------
# roslaunch dv_ros_visualization event_record.launch 

# -------- Synchronise with onboard computer (PTP) --------
# sudo ptpd -g -i eno1 -C

# Additional utilities (uncomment as needed)
# gnome-terminal --tab -e 'bash -c "roslaunch dv_ros_visualization event_visualization.launch; exec bash"'
# gnome-terminal --tab -e 'bash -c "rostopic echo /DAVIS346_left/image/header; exec bash"'
# gnome-terminal --window -e 'bash -c "rosbag play -r 1.0 --pause ~/road_data_bag_2023-06-02-11-50-28.bag; exec bash"'
# gnome-terminal --window -e 'bash -c "rostopic echo /DAVIS346_right/image/header; exec bash"'

# Delay before starting recording script
sleep 6s

# Start recording (optional)
# gnome-terminal --window -e 'bash -c "roslaunch dv_ros_visualization event_record.launch; exec bash"'
