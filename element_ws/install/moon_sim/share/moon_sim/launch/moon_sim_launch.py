
import os
from ament_index_python.packages import get_package_share_directory

from launch import LaunchDescription
from launch.actions import ExecuteProcess
from launch.substitutions import LaunchConfiguration


def generate_launch_description():
    use_sim_time = LaunchConfiguration('use_sim_time', default='true')
    robot_name = 'x1'
    world_file_name = 'simple_world.world'
    
    world = os.path.join(get_package_share_directory(robot_name), 
                         'worlds', world_file_name)
    
    
    spawn_args = '{name: \"roo-ver\", xml: \"' + xml + '\"}'
    
    return LaunchDescription([
        ExecuteProcess(
            cmd=['ign', 'gazebo', world, '-s', 'libgazebo_ros_factory.so'],
            output='screen'),
        
        ExecuteProcess(
            cmd=['ros2', 'param', 'set', '/gazebo', 
                 'use_sim_time', use_sim_time],
            output='screen'),
        
        # ExecuteProcess(
        #     cmd=['ros2', 'service', 'call', '/spawn_entity',
        #          'gazebo_msgs/SpawnEntity', spawn_args],
        #     output='screen'),
  ])