
# Configuring a Jenkins Permanent Agent

## **Ensure SSH Service is Running**

1. Check if the SSH service is running:
   ```sh
   sudo systemctl status ssh
   ```

2. If the SSH service is not running, start it:
   ```sh
   sudo systemctl start ssh
   ```

3. If SSH is not installed, execute the following commands:
   ```sh
   sudo apt update
   sudo apt install openssh-server
   sudo systemctl start ssh
   sudo systemctl enable ssh  # To start SSH on boot
   ```

---

## **Creating a Permanent Jenkins Agent**

### Step-by-Step Configuration

1. **Name**: Enter a name for your agent (e.g., `agent1`).
2. **Description**: Add a description for the agent.
3. **Number of Executors**: Define how many jobs the agent can run in parallel. This typically depends on the server's processing capability.
4. **Remote Root Directory**:
   - **Case 1: Agent on the Same Machine as Jenkins Master**:
     - Create a new user for the agent (recommended to keep isolation).
     - Use the path to the new user’s home directory as the remote root directory.
     - **Note**: It is advisable to keep agent-specific users separate from admin or regular users for security and isolation.

---

## **Setting Up the SSH Key Pair**

1. Log in as the Jenkins user in the terminal (if creating an agent on the same machine):
   ```sh
   su - jenkins
   ```

2. Generate an SSH key pair:
   ```sh
   ssh-keygen
   ```

3. **Standard Path for SSH Keys**: 
   By default, keys are stored in `/var/lib/jenkins/.ssh/id_ed25519`.

4. **On the Agent Machine**:
   - Copy the public SSH key from the master and paste it into the new agent’s `.ssh` directory:
     ```sh
     mkdir ~/.ssh
     ```
   - Create an `authorized_keys` file in the `.ssh` directory and paste the public key into it:
     ```sh
     nano ~/.ssh/authorized_keys
     ```

5. Copy the private SSH key from the master.

---

## **Node Configuration on Jenkins**

1. **Labels**: Assign labels to categorize agents into clusters or groups based on their purpose.

2. **Launch Method**: Choose "Launch agent via SSH" and provide the following details:
   - **SSH Username and Private Key**:
     - Paste the private key copied earlier.
   - **ID**: Provide an identifier for this configuration.
   - **Description**: Add a description.
   - **Username**: Enter the username of the agent machine (e.g., `agent1`).

3. **Host Key Verification Strategy**:
   - Select "Non-verifying Verification Strategy."

4. **Java Path**:
   - If the agent machine has multiple Java versions installed, find the path for Java using:
     ```sh
     sudo update-alternatives --config java
     ```
   - Copy the selected path and paste it into the **Java Path** field in Jenkins.

---

## **Final Step**
- Save the configuration and launch the agent!
