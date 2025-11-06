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
                    withCredentials([usernamePassword(credentialsId: 'dockerhub-pwd', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {

                        // --- ÉTAPE DE DÉBOGAGE ---
                        // Affiche l'utilisateur pour vérifier qu'il est correct.
                        // Le mot de passe ne sera pas affiché dans la console pour des raisons de sécurité (il sera masqué par Jenkins).
                        sh 'echo "Débogage Jenkins: Utilisateur Docker = $DOCKER_USER"'
                        // -------------------------

                        script {
                            ansiblePlaybook(
                                playbook: 'playbookCICD.yml',
                                installation: 'myansible',
                                extras: "-e 'docker_registry_username=${env.DOCKER_USER}' -e 'docker_registry_password=${env.DOCKER_PASS}'"
                            )
                        }
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
