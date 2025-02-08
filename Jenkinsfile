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
                    // Check if the agent is running on Windows or Unix-based environment
                    def isWindows = isUnix() ? false : true
                    
                    // Configure Git settings to avoid timeouts and increase buffer size (for Unix environments)
                    if (!isWindows) {
                        sh 'git config --global http.postBuffer 524288000'
                    }
                    
                    // Clone the repository using shallow clone (depth: 1)
                    git url: 'git@github.com:nawreswear/datacamp_docker_angular-master-.git', branch: 'main', depth: 1
                    
                    // Set the DOCKER_TAG environment variable to the result of getVersion()
                    env.DOCKER_TAG = getVersion()
                }
            }
        }
    }
}

def getVersion() {
    // Get the short commit hash (using the correct shell command for the environment)
    def version = ''
    if (isUnix()) {
        version = sh(script: 'git rev-parse --short HEAD', returnStdout: true).trim()
    } else {
        version = bat(script: 'git rev-parse --short HEAD', returnStdout: true).trim()
    }
    return version
}
