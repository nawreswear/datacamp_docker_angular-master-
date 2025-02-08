pipeline {
    agent any
    tools {
        jdk 'Openjdk17'
    }
    environment {
        JAVA_HOME = 'C:\\Program Files\\Java\\jdk-17'
        DOCKER_TAG = ''
        GIT_SSH_COMMAND = 'ssh -i ~/.ssh/id_rsa -o StrictHostKeyChecking=no'  // Utiliser la clé privée SSH
    }
    stages {
        stage('Setup SSH Key') {
            steps {
                script {
                    def sshKey = '''-----BEGIN OPENSSH PRIVATE KEY-----
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDIim9Ov059/2WOUMwCeVFdceah85+bdILxZynUCKuBobWQ9aBABR1xglJd4pahfEBkk+xQkF1fLIhRxfcrSWyXK5Hq8U55ZqmPy60RCkuQDelrHbbJnTMJuZZ5dIMLHZA1MkJIh9mbVzXtG7BOpKcJq0HGlVJ1O95Ixs4fQZ8vuftnH2ArrMHzCOrmLMBNKE3TiJ/RRLE+fuFoVUXUa59VIJejcWJAbZ2eZbJ0JAzsG1k5LJ11SzNcM+CUtqFO6c4lbrAq45ozJfrN+hqrXKBAohXQfGr5Of8TKIuryiwNt6V2qyBU5+q/IHhpGnYVUDQPy8d/rPsL7Y/bXrP+cc7W3d2hNaEAhTVr9aOBs/C2Yl+U29PjrzuVT6VG1o9NDOBnx2z/cxi+MyHxTsIG9/kU6+Cf8Xv3YuTK3lPOHwfc4flWGnfuflBp1z0T1efTd0QNIDth8HixryxlxXokRwJJsZAYFgd9lQFlcOw5/pCKTso3OKkPMUQihvyF+dv3vnMUGPO2IqgYB4XAGXLDHkWz30no8K/f02oD6ViNqtaXPms/a5rYrFTmUzn2XUjIQMd1mWqkSBuT/g2RhAVgX2SHc6PypUAF2Y/TPAt1Pdviz+RVDGDsn0fJb3y5xcqqgwqOSqTnUzZxGbrDZQayFh9emsDVTbK8vz5jUnYxMIoZkw== nawreselou2382@gmail.com
-----END OPENSSH PRIVATE KEY-----'''

                    // Écrire la clé privée dans ~/.ssh/id_rsa
                    writeFile file: "${env.HOME}/.ssh/id_rsa", text: sshKey
                    sh "chmod 600 ${env.HOME}/.ssh/id_rsa"
                }
            }
        }
        stage('Configure Git') {
            steps {
                script {
                    sh 'git config --global http.postBuffer 524288000'
                    sh 'git config --global http.maxRequestBuffer 524288000'
                    sh 'git config --global http.sslBackend openssl'
                }
            }
        }
        stage('Clone Stage') {
            steps {
                script {
                    git url: 'https://github.com/nawreswear/datacamp_docker_angular-master-.git', branch: 'main', depth: 1
                }
            }
        }
    }
}

def getVersion() {
    def version = ''
    if (isUnix()) {
        version = sh(script: 'git rev-parse --short HEAD', returnStdout: true).trim()
    } else {
        version = bat(script: 'git rev-parse --short HEAD', returnStdout: true).trim()
    }
    return version
}
