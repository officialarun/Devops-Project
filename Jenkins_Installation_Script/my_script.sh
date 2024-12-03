#!/bin/bash


error_exit() {
    echo "$1" 
    exit 1
}


if [ -z "$1" ]; then
    error_exit "Error: Please provide the Jenkins version as an argument (e.g., 2.361.1)."
fi

if [ -z "$2" ]; then
    error_exit "Error: Please provide the OS type (e.g., ubuntu, centos, macos, windows)."
fi

JENKINS_VERSION=$1
OS_TYPE=$2


install_java() {
    echo "Installing Java..."
    if [ "$OS_TYPE" == "ubuntu" ] || [ "$OS_TYPE" == "debian" ]; then
        sudo apt update && sudo apt install -y openjdk-11-jdk || error_exit "Error: Failed to install Java on Ubuntu/Debian."
    elif [ "$OS_TYPE" == "centos" ] || [ "$OS_TYPE" == "rhel" ]; then
        sudo yum install -y java-11-openjdk-devel || error_exit "Error: Failed to install Java on CentOS/RHEL."
    elif [ "$OS_TYPE" == "macos" ]; then
        brew install openjdk@11 || error_exit "Error: Failed to install Java on macOS. Please ensure Homebrew is installed."
    elif [ "$OS_TYPE" == "windows" ]; then
        echo "Please manually install Java for Windows from https://www.oracle.com/java/technologies/javase-jdk11-downloads.html"
    else
        error_exit "Error: Unsupported OS type. Please provide either 'ubuntu', 'centos', 'macos', or 'windows'."
    fi
}


install_jenkins() {
    echo "Installing Jenkins version $JENKINS_VERSION..."
    if [ "$OS_TYPE" == "ubuntu" ] || [ "$OS_TYPE" == "debian" ]; then
        sudo apt update && sudo apt install -y curl gnupg || error_exit "Error: Failed to install dependencies on Ubuntu/Debian."
        curl -fsSL https://pkg.jenkins.io/debian/jenkins.io.key | sudo tee /usr/share/keyrings/jenkins-keyring.asc > /dev/null || error_exit "Error: Failed to add Jenkins key."
        echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian binary/" | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null
        sudo apt update && sudo apt install -y jenkins || error_exit "Error: Failed to install Jenkins on Ubuntu/Debian."
        sudo systemctl enable jenkins && sudo systemctl start jenkins
    elif [ "$OS_TYPE" == "centos" ] || [ "$OS_TYPE" == "rhel" ]; then
        sudo yum install -y wget || error_exit "Error: Failed to install wget on CentOS/RHEL."
        sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo || error_exit "Error: Failed to add Jenkins repository."
        sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key || error_exit "Error: Failed to add Jenkins key."
        sudo yum install -y jenkins || error_exit "Error: Failed to install Jenkins on CentOS/RHEL."
        sudo systemctl enable jenkins && sudo systemctl start jenkins
    elif [ "$OS_TYPE" == "macos" ]; then
        brew install jenkins-lts || error_exit "Error: Failed to install Jenkins on macOS."
        echo "To start Jenkins, use: 'brew services start jenkins-lts'"
    elif [ "$OS_TYPE" == "windows" ]; then
        echo "Downloading Jenkins for Windows..."
        curl -O https://get.jenkins.io/war-stable/$JENKINS_VERSION/jenkins.msi || error_exit "Error: Failed to download Jenkins MSI file."
        echo "Please run the downloaded 'jenkins.msi' to complete the installation."
    else
        error_exit "Error: Unsupported OS type. Please provide either 'ubuntu', 'centos', 'macos', or 'windows'."
    fi
}

jenkins_status() {
    echo "Checking Jenkins status..."
    if [ "$OS_TYPE" == "ubuntu" ] || [ "$OS_TYPE" == "debian" ] || [ "$OS_TYPE" == "centos" ] || [ "$OS_TYPE" == "rhel" ]; then
         sudo systemctl status jenkins --no-pager
    elif [ "$OS_TYPE" == "macos" ]; then
        echo "To check Jenkins status, use: 'brew services list'"
    else
        echo "For Windows, verify Jenkins installation via the Windows Services Manager."
    fi
}

echo "Starting Jenkins installation process..."

install_java
install_jenkins
jenkins_status

if [ "$OS_TYPE" == "ubuntu" ] || [ "$OS_TYPE" == "debian" ] || [ "$OS_TYPE" == "centos" ] || [ "$OS_TYPE" == "rhel" ]; then
    echo "Jenkins installation completed successfully."
    echo "Visit http://<your-server-ip>:8080 to access Jenkins."
elif [ "$OS_TYPE" == "macos" ]; then
    echo "Jenkins installed on macOS. Start it with 'brew services start jenkins-lts'."
elif [ "$OS_TYPE" == "windows" ]; then
    echo "Run 'jenkins.msi' to complete the installation on Windows."
fi

