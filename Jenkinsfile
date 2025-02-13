pipeline {
    agent any

    tools {
        jdk 'Openjdk17'
    }

    environment {
        JAVA_HOME = 'C:\\Program Files\\Java\\jdk-17'
        DOCKER_TAG = '' 
        SSH_KEY_PATH = '/home/jenkins/.ssh/id_rsa'
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
            //sh " fin push"
        }
    }
}
    stage('Configurer la clé SSH') {
    steps {
        script {
            sh '''
                #!/bin/bash -e
                echo "🔑 Configuration de la clé SSH"

                mkdir -p ~/.ssh
                chmod 700 ~/.ssh

                # Réécriture correcte de la clé privée
                echo "$SSH_PRIVATE_KEY" | tr -d '\r' > ~/.ssh/id_rsa
                chmod 600 ~/.ssh/id_rsa

                # Ajout de l'hôte distant aux clés connues
                ssh-keyscan -H 192.168.182.200 >> ~/.ssh/known_hosts
                chmod 644 ~/.ssh/known_hosts

                echo "✅ Clé SSH configurée avec succès."
            '''
        }
    }
}
stage('Déploiement') {
    steps {
        script {
            sh '''
                #!/bin/bash -e
                echo "🚀 Déploiement de l'application"

                # Vérification si la clé privée SSH est fournie et l'ajout
                if [ -z "$SSH_PRIVATE_KEY" ]; then
                    echo "❌ La clé privée SSH n'est pas fournie dans la variable d'environnement !"
                    exit 1
                fi

                # Sauvegarde de la clé privée dans un fichier et ajustement des permissions
                echo "$SSH_PRIVATE_KEY" | tr -d '\r' > ~/.ssh/id_rsa
                chmod 600 ~/.ssh/id_rsa
                echo "✅ Clé SSH ajoutée et permissions correctement configurées."

                # Création du dossier .ssh si nécessaire
                mkdir -p ~/.ssh

                # Générer la clé publique à partir de la clé privée
                ssh-keygen -y -f ~/.ssh/id_rsa > ~/.ssh/id_rsa.pub

                # Affichage de la clé publique pour s'assurer qu'elle est correcte
                echo "🔑 Clé publique générée :"
                cat ~/.ssh/id_rsa.pub

                # Ajouter la clé publique à la machine distante
                echo "🔑 Ajout de la clé publique au fichier authorized_keys sur la machine distante"
                ssh -o StrictHostKeyChecking=no -i ~/.ssh/id_rsa vagrant@192.168.182.200 << 'EOF'
                    #!/bin/bash -e

                    # Vérification et création du répertoire .ssh
                    mkdir -p ~/.ssh
                    chmod 700 ~/.ssh

                    # Ajout de la clé publique à authorized_keys
                    echo "$(cat ~/.ssh/id_rsa.pub)" >> ~/.ssh/authorized_keys

                    # Ajuster les permissions
                    chmod 600 ~/.ssh/authorized_keys
                    chmod 700 ~/.ssh
                    echo "✅ Clé publique ajoutée avec succès."
                EOF

                echo "✅ Hôte SSH ajouté à la liste des hôtes connus."

                # Connexion SSH à la machine distante avec débogage
                echo "🔑 Tentative de connexion SSH à vagrant@192.168.182.200"
                ssh -v -o StrictHostKeyChecking=no -i ~/.ssh/id_rsa vagrant@192.168.182.200 <<'EOF'
                #!/bin/bash -e

                # Vérification de l'installation de Docker
                echo "🔍 Vérification de Docker..."
                if ! command -v docker &> /dev/null; then
                    echo "❌ Docker n'est pas installé sur cette machine !"
                    exit 1
                fi
                echo "✅ Docker est installé."

                # Vérification du conteneur existant
                echo "🔍 Vérification du conteneur existant..."
                if docker ps -a --format '{{.Names}}' | grep -q "^aston_villa$"; then
                    echo "🛑 Arrêt et suppression du conteneur existant"
                    docker stop aston_villa || true
                    docker rm aston_villa || true
                else
                    echo "✅ Aucun conteneur existant à supprimer"
                fi

                # Démarrage du nouveau conteneur
                echo "🚀 Démarrage du nouveau conteneur..."
                docker run -d --name aston_villa -p 50:50 nawreswear/aston_villa:${DOCKER_TAG} || {
                    echo "❌ Erreur: Échec du lancement du conteneur"
                    exit 1
                }

                echo "✅ Déploiement terminé avec succès."
                EOF
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
