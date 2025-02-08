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
           
                            git "git@gitlab.com:jmlhmd/datacamp_docker_angular.git"
                     
                    }
                }
            }
        }
}


// Cette fonction est utilisée pour récupérer la version du commit
def getVersion() {
    def version = ''
    if (isUnix()) {
        version = sh(script: 'git rev-parse --short HEAD', returnStdout: true).trim()
    } else {
        version = bat(script: 'git rev-parse --short HEAD', returnStdout: true).trim()
    }
    return version
}
