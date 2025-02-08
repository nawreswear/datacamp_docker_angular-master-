pipeline {
 agent any
 tools{ jdk 'Openjdk17' }
 environment { 
JAVA_HOME = 'C:\Program Files\Java\jdk-17'
DOCKER_TAG = getVersion()
 }
 stages {
 
    stage ('Clone Stage') {
        steps {
        git 'https://gitlab.com/jmlhmd/datacamp_docker_angular.git'
        }
    }
 }
}
def getVersion(){
 def version = sh returnStdout: true, script: 'git rev-parse --short HEAD'
 return version
}