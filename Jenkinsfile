pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'your-docker-repo/nginx-app'  // Replace with your Docker repo
        DOCKER_TAG = 'latest'  // You can use dynamic tags like 'v1.0'
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm  // Checkout the source code from the repository
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
                    // Verify that the container is running (optional)
                    sh "docker ps"
                }
            }
        }

        stage('Clean Up') {
            steps {
                script {
                    // Clean up by stopping and removing the container
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

