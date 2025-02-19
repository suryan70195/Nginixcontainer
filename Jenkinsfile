pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'kubersurya/nodejs'  
        DOCKER_TAG = 'latest' 
    }
    stages {
         stage('Clean Workspace') {
            steps {
                script {
                    deleteDir()
                    echo "Workspace cleaned"
                }
            }
        }
        stage('Checkout') {
            steps {
                git branch: 'main', credentialsId: 'suryachandu', url: 'https://github.com/suryan70195/Nginixcontainer.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    // Build the Docker image
                    sh "docker build -t ${DOCKER_IMAGE}:${DOCKER_TAG} ."
                }
            }
        }

        stage('Run Docker Container') {
            steps {
                script {
                    // Run the Docker container
                    sh "docker run -d -p 8080:80 --name nginx-container ${DOCKER_IMAGE}:${DOCKER_TAG}"
                }
            }
        }

        stage('Verify Container') {
            steps {
                script {
                    sh "docker ps"
                }
            }
        }

        stage('Clean Up') {
            steps {
                script {
                    sh "docker stop nginx-container"
                    sh "docker rm nginx-container"
                }
            }
        }
    }

    post {
        success {
            echo "Docker image built and container started successfully!"
        }
        failure {
            echo "There was an error during the build or container setup."
        }
    }
}

