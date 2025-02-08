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
                    // Configure Git settings to avoid timeouts and increase buffer size
                    sh 'git config --global http.postBuffer 524288000'
                    
                    // Clone the repository using shallow clone (depth: 1) if applicable
                    git url: 'git@github.com:nawreswear/datacamp_docker_angular-master-.git', branch: 'main', depth: 1
                    
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
