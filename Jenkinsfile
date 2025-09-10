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
        stage('Deploy to EC2') {
            steps {
                sshagent (credentials: ['ec2-ssh-credentials']) {
                    sh "ssh -o StrictHostKeyChecking=no ec2-user@15.206.166.81 'docker stop profiles-rest-api-container; docker rm profiles-rest-api-container; docker run -d --name profiles-rest-api-container Harshpatil0508/profiles-rest-api'"
                }
            }
        }
    }
}