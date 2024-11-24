
# Jenkins Installation Script Documentation

This script automates the installation of Jenkins on various operating systems. It also handles prerequisites like Java installation and verifies the Jenkins service status post-installation.

---

## **Features**
- Installs **Java (OpenJDK 11)** as a prerequisite.
- Installs Jenkins for supported operating systems:
  - Ubuntu/Debian
  - CentOS/RHEL
  - macOS
  - Windows
- Verifies Jenkins service status after installation.
- Provides error handling for unsupported operating systems and missing arguments.

---

## **Usage**

Run the script with the following arguments:

```bash
./install_jenkins.sh <Jenkins_Version> <OS_Type>
```

### **Arguments**
1. `<Jenkins_Version>`: The version of Jenkins to install (e.g., `2.361.1`).
2. `<OS_Type>`: The type of operating system. Supported values:
   - `ubuntu`
   - `debian`
   - `centos`
   - `rhel`
   - `macos`
   - `windows`

---

## **How the Script Works**

### **1. Error Handling**
- Ensures that both arguments (`Jenkins Version` and `OS Type`) are provided.
- Displays descriptive error messages if required inputs are missing or if an unsupported OS is specified.

### **2. Java Installation**
- Installs **OpenJDK 11** based on the specified OS:
  - **Ubuntu/Debian**: Uses `apt` package manager.
  - **CentOS/RHEL**: Uses `yum` package manager.
  - **macOS**: Uses Homebrew.
  - **Windows**: Prompts the user to manually install Java.

### **3. Jenkins Installation**
- Adds Jenkins repository and installs Jenkins:
  - **Ubuntu/Debian**:
    - Installs required dependencies (`curl`, `gnupg`).
    - Adds Jenkins GPG key and repository.
    - Installs Jenkins using `apt` and starts the service.
  - **CentOS/RHEL**:
    - Installs `wget` and Jenkins repository.
    - Imports Jenkins GPG key and installs Jenkins using `yum`.
    - Enables and starts the Jenkins service.
  - **macOS**:
    - Installs Jenkins via Homebrew.
    - Provides instructions to start the Jenkins service.
  - **Windows**:
    - Downloads Jenkins MSI file.
    - Prompts user to complete the installation manually.

### **4. Display Jenkins Status**
- Displays the Jenkins service status for Linux-based systems.
- For macOS, provides a command to list services using Homebrew.
- For Windows, advises verifying Jenkins through the Windows Services Manager.

---

## **Post-Installation Notes**
1. For Linux-based systems:
   - Access Jenkins at `http://<your-server-ip>:8080`.
2. For macOS:
   - Start Jenkins using: `brew services start jenkins-lts`.
3. For Windows:
   - Run the downloaded Jenkins MSI file to complete the installation.

---

## **Error Handling**
The script will terminate with an error message in the following cases:
- Missing required arguments (Jenkins version or OS type).
- Unsupported operating system.
- Failed installation of Java or Jenkins.
