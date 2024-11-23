# **Building a Java App and Triggering Pipeline Using Different Methods**

## **Objective:**
- Build Java app and trigger pipeline using different methods
    - Polling
    - Trigger when there is a code commit
    - Ensure that if the pipeline runs for more than a minute, it should fail
    - Publish artifacts
    - Use the concept of parameters to execute different branches

## **Required Plugins:**
- **Pipeline: Stage View Plugin** Version 2.34
- **Git plugin** Version 5.6.0
- **GitHub plugin** Version 1.40.0
- **JUnit Plugin** Version 1309.v0078b_fecd6ed
- **Maven Integration plugin** Version 3.24

## **Set-up Instructions:**
1. **Manage Jenkins > Tools > Maven Installations > Add Maven:**
    - **Name:** `mv`
    - **Version:** 3.9.9 (Install from Apache)

## **Steps to Implement:**

### **Step 1: Find a Simple Java-based Project on GitHub**
- Fork and push the project to your repository.

### **Step 2: Create a Pipeline to Build the Project**

### **Step 3: Check "This project is parameterized" option**
- We need to be flexible in building this project on different branches.

### **Step 4: Check "GitHub hook trigger for GIT SCM polling"**

### **Step 5: Pipeline Script from SCM**
- **SCM:** Git
- **Repositories:** `git@github.com:officialarun/Devops-Project.git` (SSH URL)
- **Credentials:** Create an SSH key pair to connect GitHub to Jenkins.

### **Step 6: Choose Branches to Build**
- Select the default branch, e.g., `main` or `master`.

### **Step 7: Provide Jenkinsfile Path to Build Your Project**
- Example path: `jenkins/Jenkinsfile`

### **Step 8: Configure ngrok**
- **Purpose:** ngrok allows you to expose your localhost and make it accessible publicly.

### **Step 9: Prerequisite:**
- Step 8 is required if Jenkins is not running on AWS or similar.

### **Step 10: Configure Webhook in GitHub:**
1. **Go to GitHub Repo > Settings > Webhooks > Add Webhook**
2. **Payload URL:** 
    - `https://c07c-103-76-137-130.ngrok-free.app/github-webhook/`
    - (Note: `https://c07c-103-76-137-130.ngrok-free.app` is the publicly accessible URL provided by ngrok)
3. **Content Type:** `application/x-www-form-urlencoded`
4. **SSL Verification:** Disable
5. **Which events would you like to trigger this webhook?** Select "Send me everything"
6. **Note:** If your payload fails to deliver, go to edit and manually resend it once or twice. It will start working.

---

## **Pipeline Steps in Jenkinsfile:**

### **Step 1: Project Parameters**
Since the project is parameterized, the URL for the repo and the branch name cannot be passed directly.

### **Step 2: Create Parameters**
```groovy
parameters {
    string(name: 'BRANCH_NAME', defaultValue: 'master', description: 'Enter the branch name to build')
}

### Use Branch Parameters:
steps {
    git branch: "${params.BRANCH_NAME}", url: 'git@github.com:officialarun/Devops-Project.git'
}

### Also set timeout:
timeout(time: 1, unit: 'MINUTES') {
    // your steps here
}

