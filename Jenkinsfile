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
           
                            git "https://github.com/nawreswear/datacamp_docker_angular-master-.git"
                     
                    }
                }
           stage ('Docker Build') {
                steps {
                sh 'docker build -t nawreswear/aston_villa:${DOCKER_TAG}.'
                }
            } 
            stage ('DockerHub Push') {
                steps {
                sh 'sudo docker login -u nawreswear -p zoo23821014'
                sh 'sudo docker push nawreswear/aston_villa:${DOCKER_TAG}'
                }
            } 
            stage ('Deploy') {
                steps{
                sshagent(credentials: ['Vagrant_ssh']) {
                sh "ssh vagrant@Ip_Recette"

                sh "ssh vagrant@Ip_Recette ‘sudo docker run “nawreswear/aston_villa:${DOCKER_TAG}"’”
                } 
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
