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

            // Login sécurisé à DockerHub avec les credentials Jenkins pour l'utilisateur jenkins
            sh 'echo "zoo23821014" | sudo -u jenkins docker login -u nawreswear --password-stdin'
            
            sh '''
                    echo "Vérification des groupes de l'utilisateur Jenkins"
                    groups jenkins

                    echo "Vérification des permissions sur le socket Docker"
                    ls -l /var/run/docker.sock

                    echo "Essai d'accès à Docker"
                    sudo -u jenkins docker info
                '''
          

            // Pousser l'image Docker
            sh "sudo -u jenkins docker push nawreswear/aston_villa:${DOCKER_TAG}"
        }
    }
}
stage('Vérification de la clé SSH') {
    steps {
        script {
            // Vérification de l'existence du fichier de la clé
            if (fileExists('/home/jenkins/.ssh/id_rsa')) {
                echo 'Clé SSH trouvée.'
            } else {
                echo 'La clé SSH est manquante.'
                currentBuild.result = 'FAILURE'  // Marquer l'étape comme échouée
                return  // Sortir de l'étape si la clé SSH est manquante
            }

            // Vérification des permissions de la clé
            sh '''
                ls -l /home/jenkins/.ssh/id_rsa
            '''
        }
    }
}
stage('Check SSH Key Existence and Permissions') {
    steps {
        script {
            // Vérifier que la clé existe et que Jenkins peut y accéder
            if (!fileExists('/home/jenkins/.ssh/id_rsa')) {
                echo "Erreur : La clé SSH '/home/jenkins/.ssh/id_rsa' est introuvable !"
                currentBuild.result = 'FAILURE'
                return
            }

            // Vérifier et ajuster les permissions uniquement si nécessaire
            sh '''
                ACTUAL_PERMISSIONS=$(stat -c %a /home/jenkins/.ssh/id_rsa)
                if [ "$ACTUAL_PERMISSIONS" != "600" ]; then
                    chmod 600 /home/jenkins/.ssh/id_rsa
                fi
            '''
        }
    }
}
stage('Deployment') {
    steps {
        script {
            sh '''
                # Vérifier la clé avant de tenter la connexion
                ssh -o StrictHostKeyChecking=no -i /home/jenkins/.ssh/id_rsa jenkins@192.168.182.200 "echo 'Connexion SSH réussie'"
                
                # Lancer le conteneur si la connexion fonctionne
                ssh -o StrictHostKeyChecking=no -i /home/jenkins/.ssh/id_rsa jenkins@192.168.182.200 \
                    "docker run -d --name aston_villa -p 50:50 nawreswear/aston_villa:8ad33ca"
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
