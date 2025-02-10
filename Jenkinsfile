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
                    sh "sudo docker build -t nawreswear/aston_villa:${DOCKER_TAG} ."
                }
            }
        }

  stage('DockerHub Push') {
    steps {
        script {
            // Vérifier que DOCKER_TAG est défini
            if (!DOCKER_TAG) {
                error("DOCKER_TAG is not defined")
            }

            // Login sécurisé à DockerHub avec les credentials Jenkins         
            sh 'echo "zoo23821014" | docker login -u nawreswear --password-stdin'
            
            // Vérification de l'authentification
            sh 'docker info | grep "Server Version"'

            // Vérification de l'utilisateur courant (doit être 'jenkins')
            sh '''
                echo "Utilisateur courant : $(whoami)"
                echo "Répertoire personnel : $HOME"
            '''
            
            // Vérification de l'image avant de pousser
            sh 'docker images nawreswear/aston_villa'
            
            // Créer le répertoire .ssh dans /home/jenkins si nécessaire
            sh '''
                sudo -u jenkins mkdir -p /home/jenkins/.ssh/
                sudo -u jenkins chmod 700 /home/jenkins/.ssh/
                sudo -u jenkins ls -al /home/jenkins/.ssh/
            '''
            
            // Vérification des permissions de l'utilisateur Jenkins
            sh '''
                sudo -u jenkins echo "Utilisateur Jenkins courant : $(whoami)"
                sudo -u jenkins echo "Répertoire personnel Jenkins : $HOME"
            '''

            // Pousser l'image Docker
            sh "sudo -u jenkins docker push nawreswear/aston_villa:${DOCKER_TAG}"

            // Vérification du push
            echo "🔍 Vérification du push pour l'image: nawreswear/aston_villa:${DOCKER_TAG}"
            sh "sudo -u jenkins docker manifest inspect nawreswear/aston_villa:${DOCKER_TAG}"
        }
    }
}

/*stage('Déploiement') {
    steps {
        script {
            // Créez le répertoire .ssh s'il n'existe pas
            sh 'mkdir -p /home/jenkins/.ssh/'

            // Copiez la clé privée SSH directement dans le répertoire .ssh
            // Remplacez <PATH_TO_PRIVATE_KEY> par le chemin réel de votre clé privée
            sh ''' 
                echo "Copie de la clé SSH..."
                cp /home/vagrant/.ssh/id_rsa /home/jenkins/.ssh/id_rsa
                chmod 600 /home/jenkins/.ssh/id_rsa
                ls -al /home/jenkins/.ssh/
            '''

            // Exécutez la commande SSH
            sh '''
                echo "Déploiement avec SSH..."
                ssh -o StrictHostKeyChecking=no -i /home/jenkins/.ssh/id_rsa vagrant@192.168.182.200 'docker run -d --name aston_villa -p 50:50 nawreswear/aston_villa:8ad33ca'
            '''
        }
    }
}*/
stage('Déploiement') {
    steps {
        script {
            // Vérification du répertoire .ssh
            sh '''
                echo "Vérification de la clé SSH"
                ls -al /home/jenkins/.ssh/
                echo "après Vérification de la clé SSH"
                
                # Utilisation de la clé SSH pour se connecter à la machine distante
                ssh -o StrictHostKeyChecking=no -i /home/jenkins/.ssh/id_rsa vagrant@192.168.182.200 'docker run -d --name aston_villa -p 50:50 nawreswear/aston_villa:8ad33ca'
            '''
        }
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
