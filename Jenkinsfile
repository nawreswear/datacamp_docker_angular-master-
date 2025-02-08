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
        stage('Clone Stage') {
            steps {
                script {
                    // Vérifier si l'agent fonctionne dans un environnement Windows ou Unix
                    def isWindows = isUnix() ? false : true
                    
                    // Configurer Git pour éviter les problèmes de timeout
                    sh 'git config --global http.postBuffer 524288000' // Augmenter le buffer Git pour les dépôts volumineux
                    
                    // Cloner le dépôt avec une profondeur de 1 (shallow clone)
                    // Remarque : Si vous utilisez HTTPS, ajoutez l'option --depth
                    git url: 'https://github.com/nawreswear/datacamp_docker_angular-master-.git', branch: 'main', depth: 1
                    
                    // Définir la variable d'environnement DOCKER_TAG à partir du résultat de la fonction getVersion()
                    env.DOCKER_TAG = getVersion()
                }
            }
        }
    }
}

def getVersion() {
    // Obtenir le hash du commit court (en utilisant la commande shell appropriée pour l'environnement)
    def version = ''
    if (isUnix()) {
        // Environnement Unix/Linux
        version = sh(script: 'git rev-parse --short HEAD', returnStdout: true).trim()
    } else {
        // Environnement Windows
        version = bat(script: 'git rev-parse --short HEAD', returnStdout: true).trim()
    }
    return version
}
