Here's a sample Jenkinsfile for the given requirements:

```groovy
pipeline {
    agent any

    stages {
        stage('Clone Repository') {
            steps {
                git 'https://github.com/Harshpatil0508/profiles-rest-api.git'
            }
        }
        stage('Build Docker Image') {
            steps {
                sh 'docker build -t Harshpatil0508/profiles-rest-api .'
            }
        }
        stage('Push Docker Image') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'docker-hub-credentials', passwordVariable: 'DOCKER_PASSWORD', usernameVariable: 'DOCKER_USERNAME')]) {
                    sh 'docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWORD'
                    sh 'docker push Harshpatil0508/profiles-rest-api'
                }
            }
        }
        stage('Deploy to EC2') {
            steps {
                sshagent (credentials: ['ec2-ssh-credentials']) {
                    sh "ssh -o StrictHostKeyChecking=no ec2-user@13.127.153.213 'docker stop profiles-rest-api-container || true'"
                    sh "ssh -o StrictHostKeyChecking=no ec2-user@13.127.153.213 'docker rm profiles-rest-api-container || true'"
                    sh "ssh -o StrictHostKeyChecking=no ec2-user@13.127.153.213 'docker run -d --name profiles-rest-api-container Harshpatil0508/profiles-rest-api'"
                }
            }
        }
    }
    post {
        success {
            echo 'Deployment successful'
        }
        failure {
            echo 'Deployment failed'
        }
    }
}
```

**Prerequisites:**

1. You need to have the Docker and SSH plugins installed in your Jenkins instance.
2. You need to have a credentials item of type "Username with password" for your Docker Hub credentials, and another credentials item of type "SSH Username with private key" for your EC2 instance.
3. Replace `'docker-hub-credentials'` and `'ec2-ssh-credentials'` with the actual IDs of your credentials items.
4. Make sure that the EC2 instance has Docker installed and running.
5. The `ec2-user` should have the necessary permissions to run Docker commands.

**Note:** This is a basic example and you may need to modify it according to your specific requirements. Also, make sure to handle the