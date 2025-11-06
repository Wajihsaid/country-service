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
                                    // Définir les identifiants directement dans le script
                                    def dockerUser = "wajihsaid"
                                    // REMPLACEZ CECI PAR VOTRE VRAI MOT DE PASSE OU JETON D'ACCÈS
                                    def dockerPass = "2722148801"

                                    // --- ÉTAPE DE DÉBOGAGE ---
                                    // Affiche l'utilisateur pour vérifier qu'il est correct.
                                    sh "echo 'Débogage Jenkins: Utilisateur Docker = ${dockerUser}'"
                                    // -------------------------

                                    ansiblePlaybook(
                                        playbook: 'playbookCICD.yml',
                                        installation: 'myansible',
                                        // Passer les identifiants au playbook comme variables supplémentaires
                                        extras: "-e 'docker_registry_username=${dockerUser}' -e 'docker_registry_password=${dockerPass}'"
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
