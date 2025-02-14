pipeline {
    agent any

    tools {
        jdk 'Openjdk17'
    }

    environment {
        JAVA_HOME = 'C:\\Program Files\\Java\\jdk-17'
        DOCKER_TAG = '' 
        SSH_KEY_PATH = '/home/jenkins/.ssh/id_rsa' 
        SSH_PUBLIC_KEY='ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC2n4UBd6kbm2n4kurgS3YcaSVUi06JmEeVEVU+Qutad5VAZa98/EY35X76zlAxvBSApUMWSKYsW8dchEs0vTZkisvuyiecFsvjMaE3A0+4tFZIHRPvTiotHP0swOhzR32DbVpV4R8ud9HjbfyE3humccX/XWG07/qMfbeMkaVME07A5bVyVUN3ea+ql1nHod2iGtIX2Qm/zMEsgCQ0Nlm3nXLSV4MEsD9ntaO95rIDF84xRVn4k4Ef/fn92J/ryYegeS9hq2O4LNiwk54jbo4mUhHC/tlSbKN0ym9Ek5QKDSjG7eUVzrjjJQXx7hYVTUHwYfRz1RjQ99kjHayD9dawXbIUQ/gqURFrzbVpBYpBFZCq27xRt2uIK7NDr47aEf+qHj4NPn079oEcoOdmf8da9XqWOreW20RYF6TjP2GZlGZrFo0Kd1g1OobJPKt7DDi47He06g+ZZB5oLIC62BeI07MHUedYwRxPZZaA39XRqNQSkfs8BgWV1eKpPEUHQiAhqxo6lS8evbz66cYvOamtzvBQHSClZg2iHRAK5pHT4wOmPjK5dj8fpPDmqP/kEf5wEPiptnATo7ShczHel/C410o/XCKbA8nBAXMnlGf+EnVY+n5mjmDoO98ylqJd8kkAXZ2FTQyvS9/ZD4f6vuEC+NuBPjE26N1YD7KZn6naSQ== vagrant@ubuntu-focal'
        SSH_PRIVATE_KEY = '''-----BEGIN OPENSSH PRIVATE KEY-----
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
-----END OPENSSH PRIVATE KEY-----'''
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
            // Appel de la fonction pour obtenir la version du commit
            DOCKER_TAG = getVersion() 
            
            // Affichage du tag Docker
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

stage('Configurer la clé SSH') {
    steps {
        script {
            sh '''
                #!/bin/bash -e
                echo "🔑 Configuration de la clé SSH"

                # Création du dossier .ssh s'il n'existe pas
                mkdir -p ~/.ssh
                chmod 700 ~/.ssh  # La permission 700 permet uniquement à l'utilisateur d'y accéder

                # Sauvegarde de la clé privée SSH
                echo "-----BEGIN OPENSSH PRIVATE KEY-----
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
-----END OPENSSH PRIVATE KEY-----" > ~/.ssh/id_rsa
                chmod 600 ~/.ssh/id_rsa  # Permission sécurisée pour la clé privée

                # Vérification de la clé privée (génération de la clé publique à partir de la clé privée)
                if ! ssh-keygen -y -f ~/.ssh/id_rsa > ~/.ssh/id_rsa.pub; then
                    echo "❌ La clé privée est invalide ou corrompue !" >&2
                    exit 1
                fi

                # Ajout de la clé publique au serveur distant
                echo "🔑 Ajout de la clé publique au serveur distant..."
                if ! ssh-copy-id -i ~/.ssh/id_rsa.pub vagrant@192.168.182.200; then
                    echo "❌ Impossible d'ajouter la clé publique sur le serveur distant !" >&2
                    exit 1
                fi

                # Ajout de l'hôte distant aux known_hosts
                echo "🔍 Ajout de l'hôte distant aux known_hosts..."
                ssh-keyscan -H 192.168.182.200 >> ~/.ssh/known_hosts

                # Vérification et correction des permissions des fichiers .ssh
                chmod 700 ~/.ssh
                chmod 600 ~/.ssh/id_rsa
                chmod 644 ~/.ssh/id_rsa.pub  # Permission de lecture publique pour la clé publique
                chmod 644 ~/.ssh/known_hosts  # Permission de lecture pour known_hosts

                # Test de connexion SSH avec débogage
                echo "🔍 Test de la connexion SSH..."
                if ! ssh -vvv -o StrictHostKeyChecking=no -o IdentitiesOnly=yes -o PreferredAuthentications=publickey -i ~/.ssh/id_rsa vagrant@192.168.182.200 "echo '✅ Connexion SSH réussie'"; then
                    echo "❌ La connexion SSH a échoué !" >&2
                    exit 1
                fi

                # Vérification que la variable DOCKER_TAG est définie
                if [ -z "$DOCKER_TAG" ]; then
                    echo "❌ La variable DOCKER_TAG n'est pas définie !" >&2
                    exit 1
                fi

                # Lancement du conteneur Docker sur l'hôte distant
                echo "DOCKER_TAG: ${DOCKER_TAG}"
                if ! ssh -o StrictHostKeyChecking=no -o IdentitiesOnly=yes -i ~/.ssh/id_rsa vagrant@192.168.182.200 "sudo docker run nawreswear/aston_villa:${DOCKER_TAG}"; then
                    echo "Échec de l'exécution de docker run"
                    exit 1
                fi
                # Run Docker container on the remote host
                #ssh -i ~/.ssh/id_rsa -o StrictHostKeyChecking=no vagrant@192.168.182.200 "sudo docker run nawreswear/aston_villa:${DOCKER_TAG}"

            '''
             // Launch Docker container on remote host
                    sh "ssh -i ~/.ssh/id_rsa -o StrictHostKeyChecking=no vagrant@192.168.182.200 \"sudo docker run nawreswear/aston_villa:${DOCKER_TAG}\""
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
