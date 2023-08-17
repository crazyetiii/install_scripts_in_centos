#!/bin/bash
# 执行结束后需要重启终端连接。使用是xxx.sh [arg]

# This script adds a custom directory to PATH for executing scripts from any location.

# Define the directory containing your scripts (default: current directory)
script_directory="${1:-$(pwd)}"


# Check if the directory exists
if [ -d "$script_directory" ]; then
    # Get the current user's home directory
    home_directory=$(eval echo ~$USER)

    # Add the script directory to PATH in the user's profile
    echo "export PATH=\$PATH:$script_directory" >> "$home_directory/.bashrc"
    echo "Added $script_directory to PATH."

    # Reload the user's profile
    source "$home_directory/.bashrc"
else
    echo "Error: Directory not found."
fi

# 验证当前的PATH
echo $PATH