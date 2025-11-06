pipeline {
    agent any

    tools {
        // 'mymaven' doit correspondre au nom configuré dans les outils Jenkins
        maven 'M2_HOME'
    }

    stages {

        stage('Build Maven' ) {
            steps {
                // Construit le projet et crée le fichier JAR
                sh 'mvn clean install'
            }
        }

        stage('Deploy using Ansible Playbook') {
            steps {
                script {
                    // Exécute le playbook Ansible
                    // 'myansible' est le nom de l'outil configuré dans Jenkins
                    ansiblePlaybook(
                        playbook: 'playbookCICD.yml',
                        installation: 'myansible'
                    )
                }
            }
        }
    }

    post {
        always {
            // Nettoie l'espace de travail après l'exécution
            echo 'Pipeline finished. Cleaning up workspace...'
            cleanWs()
        }
        success {
            echo 'Ansible playbook executed successfully!'
        }
        failure {
            echo 'Ansible playbook execution failed!'
        }
    }
}
