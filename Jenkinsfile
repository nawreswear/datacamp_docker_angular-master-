pipeline {
    agent any

    tools {
        jdk 'Openjdk17'
    }

    environment {
        JAVA_HOME = 'C:\\Program Files\\Java\\jdk-17'
        DOCKER_TAG = '' 
    }

    stages {
        stage('Cloner le dépôt') {
            steps {
                script {
                    git url: 'https://github.com/nawreswear/datacamp_docker_angular-master-.git', branch: 'main'
                }
            }
        }

        stage('Déterminer la version du commit') {
            steps {
                script {
                    DOCKER_TAG = getVersion()
                    echo "Tag Docker : ${DOCKER_TAG}"
                }
            }
        }

        stage('Docker Build') {
            steps {
                script {
                    sh "docker build -t nawreswear/aston_villa:${DOCKER_TAG} ."
                }
            }
        }

        stage('DockerHub Push') {
            steps {
                    script {
                        // Connexion DockerHub avec mot de passe en ligne de commande
                        sh 'echo "zoo23821014" | docker login -u nawreswear --password-stdin'
                        sh "docker push nawreswear/aston_villa:${DOCKER_TAG}"
                    }
                }
            }

        stage('Déploiement') {
            steps {
                sh "ssh vagrant@192.168.182.200 \"sudo docker run -d --name aston_villa -p 50:50 nawreswear/aston_villa:${DOCKER_TAG}\""
            }
        }
    }
}

// Fonction pour récupérer la version du commit
def getVersion() {
    def version = ''
    if (isUnix()) {
        version = sh(script: 'git rev-parse --short HEAD', returnStdout: true).trim()
    } else {
        version = bat(script: 'git rev-parse --short HEAD', returnStdout: true).trim()
    }
    return version
}
