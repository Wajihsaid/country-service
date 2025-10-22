pipeline {
    agent any

    environment {
        MAVEN_HOME = "/usr/share/maven"
        JAVA_HOME = "/usr/lib/jvm/java-21-openjdk-amd64"
        DEPLOY_PATH = "/var/lib/tomcat10/webapps"
    }

    stages {
        stage('Checkout') {
            steps {
                echo "🔄 Récupération du code source..."
                git branch: 'main', url: 'https://github.com/Wajihsaid/country-service.git'
            }
        }

        stage('Build') {
            steps {
                echo "🧱 Compilation du projet..."
                sh "${MAVEN_HOME}/bin/mvn clean package -DskipTests"
            }
        }

        stage('Test') {
            steps {
                echo "🧪 Exécution des tests..."
                sh "${MAVEN_HOME}/bin/mvn test"
            }
        }

        stage('Deploy') {
            steps {
                echo "🚀 Déploiement sur Tomcat10..."
                
                // Arrêter Tomcat (ignore erreur si déjà arrêté)
                sh 'sudo systemctl stop tomcat10 || true'
                
                // Copier le .war généré dans le dossier webapps
                sh "cp target/*.war ${DEPLOY_PATH}/"
    
                
                // Redémarrer Tomcat
                sh 'sudo systemctl start tomcat10'
                
                echo "✅ Déploiement terminé."
            }
        }
    }

    post {
        success {
            echo "🎉 Pipeline terminé avec succès !"
        }
        failure {
            echo "❌ Le pipeline a échoué."
        }
    }
}
