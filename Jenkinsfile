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

       /* stage('Déploiement') {
            steps {
                sh "vagrant@192.168.182.200 \"sudo docker run -d --name aston_villa -p 50:50 nawreswear/aston_villa:${DOCKER_TAG}\""
            }
        }*/
   stage('Déploiement') {
    steps {
        // Créer le répertoire .ssh s'il n'existe pas
        sh 'mkdir -p /home/jenkins/.ssh/'

        // Vérification si le fichier clé existe à l'emplacement attendu
        sh 'ls -al /home/jenkins/.ssh/'

        // Copier la clé privée depuis un répertoire connu (ajustez le chemin si nécessaire)
        sh 'cp /home/jenkins/.ssh/id_rsa /home/jenkins/.ssh/'

        // Appliquer les bonnes permissions sur la clé privée
        sh 'chmod 600 /home/jenkins/.ssh/id_rsa'

        // Vérifier à nouveau que la clé est accessible
        sh 'ls -al /home/jenkins/.ssh/'

        // Exécuter la commande SSH pour déployer Docker
        sh """
            ssh -i /home/jenkins/.ssh/id_rsa -o StrictHostKeyChecking=no vagrant@192.168.182.200 sudo docker run -d --name aston_villa -p 50:50 nawreswear/aston_villa:f9b2c02
        """
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
