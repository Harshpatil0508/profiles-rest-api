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
                sh 'docker push Harshpatil0508/profiles-rest-api'
            }
        }
        stage('Deploy on AWS EC2') {
            steps {
                sshagent (credentials: ['ec2-ssh-credentials']) {
                    sh 'ssh -o StrictHostKeyChecking=no ec2-user@${EC2_HOST} "docker stop profiles-rest-api-container || true"'
                    sh 'ssh -o StrictHostKeyChecking=no ec2-user@${EC2_HOST} "docker rm profiles-rest-api-container || true"'
                    sh 'ssh -o StrictHostKeyChecking=no ec2-user@${EC2_HOST} "docker run -d --name profiles-rest-api-container Harshpatil0508/profiles-rest-api"'
                }
            }
        }
    }
    environment {
        EC2_HOST = 'your-ec2-host'
    }
}