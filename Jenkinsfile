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
        stage ('Clone Stage') {
            steps {
                script {
                    // Clone the repository
                    git 'https://gitlab.com/jmlhmd/datacamp_docker_angular.git'
                    
                    // Set the DOCKER_TAG environment variable to the result of getVersion()
                    env.DOCKER_TAG = getVersion()
                }
            }
        }
    }
}

def getVersion() {
    // Get the short commit hash
    def version = sh(script: 'git rev-parse --short HEAD', returnStdout: true).trim()
    return version
}
