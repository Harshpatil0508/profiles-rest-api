pipeline {
    agent any

    stages {
        stage('Clone Repository') {
            steps {
                git 'https://github.com/your-username/your-repo-name.git'
            }
        }
        stage('Build Docker Image') {
            steps {
                sh 'docker build -t your-docker-username/your-image-name .'
            }
        }
        stage('Push Docker Image') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub-credentials', passwordVariable: 'DOCKER_HUB_PASSWORD', usernameVariable: 'DOCKER_HUB_USERNAME')]) {
                    sh 'docker login -u $DOCKER_HUB_USERNAME -p $DOCKER_HUB_PASSWORD'
                    sh 'docker tag your-docker-username/your-image-name:latest your-docker-username/your-image-name:latest'
                    sh 'docker push your-docker-username/your-image-name:latest'
                }
            }
        }
        stage('Deploy to AWS EC2') {
            steps {
                withCredentials([sshUserPrivateKey(credentialsId: 'ec2-ssh-credentials', keyFileVariable: 'SSH_PRIVATE_KEY')]) {
                    sshagent(credentials: ['ec2-ssh-credentials']) {
                        sh 'ssh -o StrictHostKeyChecking=no ec2-user@your-ec2-instance-ip "docker pull your-docker-username/your-image-name:latest"'
                        sh 'ssh -o StrictHostKeyChecking=no ec2-user@your-ec2-instance-ip "docker stop your-container-name || true"'
                        sh 'ssh -o StrictHostKeyChecking=no ec2-user@your-ec2-instance-ip "docker rm your-container-name || true"'
                        sh 'ssh -o StrictHostKeyChecking=no ec2-user@your-ec2-instance-ip "docker run -d --name your-container-name -p 8000:8000 your-docker-username/your-image-name:latest"'
                    }
                }
            }
        }
    }
    post {
        success {
            echo 'CI/CD pipeline executed successfully'
        }
        failure {
            echo 'CI/CD pipeline execution failed'
        }
    }
}