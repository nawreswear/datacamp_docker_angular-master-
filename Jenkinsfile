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
 /*stage('Déploiement') {
    steps {
        // Créer le répertoire .ssh s'il n'existe pas
        sh 'mkdir -p /home/jenkins/.ssh/'

        // Définir le chemin absolu du fichier id_rsa à l'intérieur d'un bloc script
        script {
            def idRsaPath = '/home/jenkins/.ssh/id_rsa'  // Utilisez le bon chemin ici
            def sshDir = '/home/jenkins/.ssh/'

            // Vérification de l'existence du fichier id_rsa
            echo "Vérification de l'existence de la clé SSH à l'emplacement: ${idRsaPath}"

            if (fileExists(idRsaPath)) {
                echo "Le fichier id_rsa a été trouvé, copie dans ${sshDir}"
                sh "cp ${idRsaPath} ${sshDir}"
                // Modifier les permissions de la clé privée
                sh 'chmod 600 /home/jenkins/.ssh/id_rsa'
                // Vérifier que la clé est bien copiée et accessible
                sh 'ls -al /home/jenkins/.ssh/'
            } else {
                error "Le fichier id_rsa n'a pas été trouvé à l'emplacement ${idRsaPath}. Veuillez vérifier le chemin."
            }
        }

        // Exécuter la commande SSH pour le déploiement
        sh """
            ssh -i /home/jenkins/.ssh/id_rsa -o StrictHostKeyChecking=no vagrant@192.168.182.200 sudo docker run -d --name aston_villa -p 50:50 nawreswear/aston_villa:c988727
        """
    }
}*/
stage('Déploiement') {
            steps {
                sshagent(['12345']) {
                    sh '''
                        echo "Vérification de la clé SSH"
                        ssh -o StrictHostKeyChecking=no vagrant@192.168.182.200 'docker run -d --name aston_villa -p 50:50 nawreswear/aston_villa:8ad33ca'
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
