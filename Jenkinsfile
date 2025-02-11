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

            // Vérification du push
            //echo "🔍 Vérification du push pour l'image: nawreswear/aston_villa:${DOCKER_TAG}"
            sh "sudo -u jenkins docker manifest inspect nawreswear/aston_villa:${DOCKER_TAG}"
            echo "push fait sucessufly: nawreswear/aston_villa:${DOCKER_TAG}"
        }
    }
}

stage('Déploiement') {
    steps {
        script {
            sh '''
                # Vérifier que la clé SSH existe et a les bonnes permissions
                sudo -u jenkins bash -c "if [ -f /home/jenkins/.ssh/id_rsa ]; then echo '-----BEGIN OPENSSH PRIVATE KEY----- b3BlbnNzaC1rZXktdjEAAAAABG5vbmUAAAAEbm9uZQAAAAAAAAABAAABFwAAAAdzc2gtcn NhAAAAAwEAAQAAAQEA0oPmmiXUODkONpxZeF8ttIvblK72jVHO6KHusnl+V+EU4pMvHiIy 6o9YGtWJ6gt/QQS7BbG77wzQFlO1ny1uJK0u2lQGrjS8Bv/JvKS717HjV8+7HU2dcg5n7w rV5AFaJfxp6MpXbiFgpBBeEgkJXkzTupOogPVYKgZnR3P8tamNADNNk0IYqnoLz409G7rm nnNNtnvAycRnFZb12Nncy8/QAZyeGGqmKFVDufFr3Hs9foCQYTswVgp+5KR8ctslxCvs/d9 v7tQBqJZwij62bJqCSw9jJAjP5FenGs3x5vv2D3R7LbDoaNu1T403Yu29gvphoHQgWvwxK e7dNIjy+GQAAA9AtMKqgLTCqoAAAAAdzc2gtcnNhAAABAQDSg+aaJdQ4OQ42nFl4Xy20i9 nuUrvaNUc7ooe6yeX5X4RTiky8eIjLqj1ga1YnqC39BBLsFsbvvDNAWU7WfLW4krS7aVAau NLwG/8m8pLvXseNXz7sdTZ1yDmfvCtXkAVol/GnoylduIWCkEF4SCQleTNO6k6iA9VgqBm dHc/y1qY0AM02TQhiqegvPjT0buuac022e8DJxGcVlvXY2dzLz9ABnJ4YaqYoVUO58Wvce z1+gJBhOzBWCn7kpHxy2yXEK+z932/u1AGolnCKPrZsmoJLD2MkCM/kV6cazfHm+/YPdHs tsOho27VPjTdi7b2C+mGgdCBa/DEp7t00iPL4ZAAAAAwEAAQAAAQBgichojEyD8/ZGqPCG uO8WysRJrOq35/pAyHHUOs7rsfaH6QNEiF5dHptCwwZZ5CfZQzgY5mbOu0t50a2Kb6UBAM JpsPrXTKulcgurjMfvpE4jaMngKEW5lk2nW4q24r/ah6Rx8sihYoEU+8SH9MjtC8JU3334 lYp2yzT1mYUcMO3fKvqdCylLdn8/cUwvoReso+YL/n+9suktFXbVsXVqwPjNy7TQKnecSH Mfmldv03B+P8GYkTovGBX/tIGB4Derdxba3KPrzviA68azlJ+dTf0+BuwaMvAONvEtz2Bh xgRxJX+4JqHEpTxNYBQBMqmnhQ1BAnMnt9oGFUT2pwhZAAAAgQDdodO3BfsDUZ6huAVOcM 9XetmlY8dvhde3DYtl3USoaha8W9P+CMjv2WFGp92pgQq9W2Da9vKcDqDeagENANGMxN5S KDw7Pvw13U1YcvtApNdnIXin1fKDCIXzGnQYn6fBGvbwkvAquo/q/mlP8HVdr+zjr4zxy4 TyMwx+Yg6/mAAAAIEA6vVLuok6+xStkuSfPwp3m8U37Kn5w+d5i0FlhCKHNTgGXzRyYvaA Badxf+avqHkrTqcjYdoRpqerwDwKZobIlO3saTwCJKk58JU+P7P3Jcx4KQ9VMNKFMp4mmx OgCHKFCYQYTPLbNCYYQIizk+LOproIpO0T+HiPg/RUiWQrYIsAAACBAOVeOG3ZcWrWjej7 JK5h1Q7tyr0cpuA79AUOzfjDXyicpZaT/u6acwM0aOrlWeIgU6L5Tqu4dNWl1RxhOmKN9Z GeJnrnedXiO+JjKvgBYpR6Qc8WE+whUAB3MRMng5ki2SfICE88eyUjoat/S3/u574SIhy2 Ay07ROZNMmP3eqxrAAAAFGplbmtpbnNAdWJ1bnR1LWZvY2FsAQIDBAUG -----END OPENSSH PRIVATE KEY-----'; else echo 'La clé SSH est manquante.'; exit 1; fi"
                
                # Tester si l'utilisateur jenkins peut exécuter Docker
                sudo -u jenkins bash -c 'docker info > /dev/null 2>&1'
                if [ $? -ne 0 ]; then
                    echo "L'utilisateur jenkins ne peut pas accéder à Docker."; exit 1;
                fi

                # Utilisation de la clé SSH pour se connecter à la machine distante et exécuter Docker
                sudo -u jenkins ssh -o StrictHostKeyChecking=no -i /home/jenkins/.ssh/id_rsa vagrant@192.168.182.200 'docker run -d --name aston_villa -p 50:50 nawreswear/aston_villa:8ad33ca'
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
