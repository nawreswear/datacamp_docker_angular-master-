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

            sh "sudo -u jenkins docker manifest inspect nawreswear/aston_villa:${DOCKER_TAG}"
            echo "push fait sucessufly: nawreswear/aston_villa:${DOCKER_TAG}"

             sh '''
                # Vérifier la connexion à Docker Hub
                echo "Connexion à Docker Hub"
                echo "$DOCKER_PASSWORD" | sudo -u jenkins docker login -u nawreswear --password-stdin
                if [ $? -ne 0 ]; then
                    echo "La connexion à Docker Hub a échoué."; exit 1;
                fi
            '''
        }
    }
}
stage('Déploiement') {
    steps {
        script {
            sh '''
                # Vérifier que la clé SSH existe et a les bonnes permissions
                if [ -f /home/jenkins/.ssh/id_rsa ]; then
                    echo 'Clé SSH trouvée.'
                else
                    echo 'La clé SSH est manquante.'
                    exit 1
                fi

                # Vérifier les permissions de la clé SSH
                ls -l /home/jenkins/.ssh/id_rsa
                sudo chmod 600 /home/jenkins/.ssh/id_rsa
                sudo chown jenkins:jenkins /home/jenkins/.ssh/id_rsa

                # Tester si l'utilisateur jenkins peut exécuter Docker
                sudo -u jenkins docker info > /dev/null 2>&1
                if [ $? -ne 0 ]; then
                    echo "L'utilisateur jenkins ne peut pas accéder à Docker."; exit 1;
                fi

                # Utilisation de la clé SSH pour se connecter à la machine distante et exécuter Docker
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
