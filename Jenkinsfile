pipeline {
    agent any

    environment {
        MAVEN_HOME = "/usr/share/maven"
        JAVA_HOME = "/usr/lib/jvm/java-17-openjdk-amd64"
        DEPLOY_PATH = "/var/lib/tomcat9/webapps"
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/<TON_USER>/country-service.git'
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
                echo "🚀 Déploiement sur Tomcat..."
                sh """
                    sudo systemctl stop tomcat9
                    sudo cp target/*.war ${DEPLOY_PATH}/country-service.war
                    sudo systemctl start tomcat9
                """
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
