pipeline {
    agent any

    environment {
        AWS_ACCOUNT_ID = '123456789012'          // replace with your AWS account ID
        AWS_REGION = 'ap-south-1'               // replace with your region
        ECR_REPO_NAME = 'my-app'                // replace with your ECR repo name
        IMAGE_TAG = "${env.BUILD_NUMBER}"
        SSH_USER = 'ubuntu'
        SSH_HOST = 'YOUR_SERVER_IP'
        APP_DIR = '/path/to/docker-compose/project'
    }

    stages {
        stage('Checkout') {
            steps {
                echo "Checking out code..."
                checkout scm
            }
        }

        stage('Build Docker Image') {
            steps {
                echo "Building Docker image..."
                sh "docker build -t ${ECR_REPO_NAME}:${IMAGE_TAG} ."
            }
        }

        stage('Login to AWS ECR') {
            steps {
                echo "Logging into ECR..."
                sh """
                    aws ecr get-login-password --region ${AWS_REGION} | \
                    docker login --username AWS --password-stdin ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com
                """
            }
        }

        stage('Push to ECR') {
            steps {
                echo "Tagging and pushing image..."
                sh """
                    docker tag ${ECR_REPO_NAME}:${IMAGE_TAG} ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/${ECR_REPO_NAME}:${IMAGE_TAG}
                    docker push ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/${ECR_REPO_NAME}:${IMAGE_TAG}
                """
            }
        }

        stage('Update Docker Compose & Deploy') {
            steps {
                echo "Updating docker-compose.yml with new image tag and deploying..."
                sh """
                    ssh -o StrictHostKeyChecking=no ${SSH_USER}@${SSH_HOST} '
                        cd ${APP_DIR} &&
                        # Backup existing docker-compose.yml
                        cp docker-compose.yml docker-compose.yml.bak &&
                        # Replace image tag in docker-compose.yml
                        sed -i "s|image: ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/${ECR_REPO_NAME}:.*|image: ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/${ECR_REPO_NAME}:${IMAGE_TAG}|g" docker-compose.yml &&
                        # Pull new image and deploy
                        docker-compose pull &&
                        docker-compose up -d
                    '
                """
            }
        }
    }

    post {
        always {
            echo "Cleaning up local Docker images..."
            sh "docker rmi ${ECR_REPO_NAME}:${IMAGE_TAG} || true"
        }
    }
}
