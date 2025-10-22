pipeline {
    agent any

    environment {
        MAVEN_HOME = "/usr/share/maven"
        JAVA_HOME = "/usr/lib/jvm/java-21-openjdk-amd64"
        DEPLOY_PATH = "/var/lib/tomcat10/webapps"  // Tomcat10 webapps
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/Wajihsaid/country-service.git'
            }
        }

        stage('Build') {
            steps {
                echo "🧱 Compilation du projet..."
                // Ici on demande Maven de produire un WAR
                sh "${MAVEN_HOME}/bin/mvn clean package -DskipTests -Pwar"
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
                // Arrêter Tomcat
                sh "sudo systemctl stop tomcat10"
                // Copier le WAR dans webapps
                sh "cp target/*.war ${DEPLOY_PATH}/"
                // Démarrer Tomcat
                sh "sudo systemctl start tomcat10"
            }
        }
    }

    post {
        success {
            echo "✅ Déploiement réussi !"
        }
        failure {
            echo "❌ Le pipeline a échoué."
        }
    }
}
