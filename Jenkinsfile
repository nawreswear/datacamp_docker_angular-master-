pipeline {
    agent any
    tools {
        jdk 'Openjdk17'
    }
    environment {
        JAVA_HOME = 'C:\\Program Files\\Java\\jdk-17'
        DOCKER_TAG = ''
        GIT_SSH_COMMAND = 'ssh -i ~/.ssh/id_rsa -o StrictHostKeyChecking=no'  // Configuration de SSH
    }
    stages {
        stage('Cloner le dépôt') {
            steps {
                script {
                    // Test de la connexion SSH avec GitLab
                    sh 'ssh -o StrictHostKeyChecking=no -T git@gitlab.com || true' // Vérification de la connexion SSH à GitLab

                    // Utilisation de SSH pour cloner le dépôt GitLab
                    sh 'git clone --depth=5 -b master git@gitlab.com:jmlhmd/datacamp_docker_angular.git'
                }
            }
        }
    }
}

def getVersion() {
    def version = ''
    if (isUnix()) {
        version = sh(script: 'git rev-parse --short HEAD', returnStdout: true).trim()
    } else {
        version = bat(script: 'git rev-parse --short HEAD', returnStdout: true).trim()
    }
    return version
}
