pipeline {
    agent any
    tools {
        jdk 'Openjdk17'
    }
    environment {
        JAVA_HOME = 'C:\\Program Files\\Java\\jdk-17'
        DOCKER_TAG = ''
        GIT_SSH_COMMAND = 'ssh -i ~/.ssh/id_rsa -o StrictHostKeyChecking=no'  // Configuration de SSH
    }
    stages {
        stage('Configuration SSH') {
            steps {
                script {
                    // Clé privée SSH
                    def sshKey = '''-----BEGIN OPENSSH PRIVATE KEY-----
                    ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDIim9Ov059/2WOUMwCeVFdceah85+bdILxZynUCKuBobWQ9aBABR1xglJd4pahfEBkk+xQkF1fLIhRxfcrSWyXK5Hq8U55ZqmPy60RCkuQDelrHbbJnTMJuZZ5dIMLHZA1MkJIh9mbVzXtG7BOpKcJq0HGlVJ1O95Ixs4fQZ8vuftnH2ArrMHzCOrmLMBNKE3TiJ/RRLE+fuFoVUXUa59VIJejcWJAbZ2eZbJ0JAzsG1k5LJ11SzNcM+CUtqFO6c4lbrAq45ozJfrN+hqrXKBAohXQfGr5Of8TKIuryiwNt6V2qyBU5+q/IHhpGnYVUDQPy8d/rPsL7Y/bXrP+cc7W3d2hNaEAhTVr9aOBs/C2Yl+U29PjrzuVT6VG1o9NDOBnx2z/cxi+MyHxTsIG9/kU6+Cf8Xv3YuTK3lPOHwfc4flWGnfuflBp1z0T1efTd0QNIDth8HixryxlxXokRwJJsZAYFgd9lQFlcOw5/pCKTso3OKkPMUQihvyF+dv3vnMUGPO2IqgYB4XAGXLDHkWz30no8K/f02oD6ViNqtaXPms/a5rYrFTmUzn2XUjIQMd1mWqkSBuT/g2RhAVgX2SHc6PypUAF2Y/TPAt1Pdviz+RVDGDsn0fJb3y5xcqqgwqOSqTnUzZxGbrDZQayFh9emsDVTbK8vz5jUnYxMIoZkw== nawreselou2382@gmail.com
                    -----END OPENSSH PRIVATE KEY-----'''

                    // Créer le répertoire .ssh s'il n'existe pas
                    sh 'mkdir -p ~/.ssh'

                    // Écrire la clé privée dans ~/.ssh/id_rsa
                    writeFile file: '~/.ssh/id_rsa', text: sshKey
                    
                    // Modifier les permissions de la clé privée
                    sh 'chmod 600 ~/.ssh/id_rsa'

                    // Ajouter GitHub au fichier known_hosts pour éviter les avertissements de sécurité
                    sh 'ssh-keyscan github.com >> ~/.ssh/known_hosts'
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
                    // Vérification de la connexion SSH avec GitHub
                    sh 'ssh -T git@github.com || true'

                    // Cloner le dépôt avec SSH (il faut une URL SSH pour GitHub)
                    sh 'git clone git@github.com:nawreswear/datacamp_docker_angular-master-.git'
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
