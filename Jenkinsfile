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
            def sshKeyPath = '/home/jenkins/.ssh/id_rsa'
            if (!fileExists(sshKeyPath)) {
                echo "Error: SSH key file '${sshKeyPath}' not found!"
                currentBuild.result = 'FAILURE'
                return
            }
            // Check permissions - no sudo needed here, Jenkins user should have correct permissions already
            def permissions = sh(script: "stat -c '%a' ${sshKeyPath}", returnStdout: true).trim()
            if (permissions != '600') {
                echo "Error: Incorrect permissions on '${sshKeyPath}'. Expected 600, found ${permissions}"
                currentBuild.result = 'FAILURE'
                return
            }
        }
    }
}

stage('Docker Access Check') {
    steps {
        script {
            // Use a dedicated user with sudo access for Docker commands
            def dockerCheckResult = sh(script: "sudo -u docker_user docker info > /dev/null 2>&1", returnStatus: true)
            if (dockerCheckResult != 0) {
                echo "Error: User 'docker_user' cannot access Docker."
                currentBuild.result = 'FAILURE'
                return
            }
        }
    }
}


stage('Deployment') {
    steps {
        script {
            // No sudo needed if jenkins is in the docker group
            def deploymentResult = sh(script: """
                ssh -o StrictHostKeyChecking=no -i /home/jenkins/.ssh/id_rsa jenkins@192.168.182.200 'docker run -d --name aston_villa -p 50:50 nawreswear/aston_villa:8ad33ca'
            """, returnStatus: true)

            if (deploymentResult != 0) {
                echo "Error during deployment: ${deploymentResult}"
                currentBuild.result = 'FAILURE'
                return
            }
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
