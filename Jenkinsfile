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
        stage('Configuration SSH') {
            steps {
                script {
                    withCredentials([sshUserPrivateKey(credentialsId: 'my-ssh-key-id', keyFileVariable: 'SSH_KEY')]) {
                        // Créer le répertoire SSH si nécessaire
                        sh 'mkdir -p ~/.ssh'

                        // Vérification de la connexion SSH avec GitHub
                        sh "ssh -i ${SSH_KEY} -T git@github.com || true"

                        // Ajouter GitHub au fichier known_hosts
                        sh "ssh-keyscan github.com >> ~/.ssh/known_hosts"
                    }
                }
            }
        }

        stage('Configurer Git') {
            steps {
                script {
                    // Désactiver la vérification SSL si nécessaire
                    sh 'git config --global http.sslVerify false'
                }
            }
        }

        stage('Cloner le dépôt') {
            steps {
                script {
                    // Utiliser l'URL SSH pour GitHub
                    sh "git clone git@github.com:nawreswear/datacamp_docker_angular-master-.git"
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
