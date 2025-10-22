pipeline {
    agent any

    environment {
        MAVEN_HOME = "/usr/share/maven"
        JAVA_HOME = "/usr/lib/jvm/java-21-openjdk-amd64"
        DEPLOY_PATH = "/opt/country-service"  // chemin où tu veux exécuter le jar
        JAR_NAME = "country-service-1.0-SNAPSHOT.jar"  // nom exact du jar généré
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
                echo "🚀 Déploiement du jar..."
                // Créer le dossier de déploiement si inexistant
                sh "mkdir -p ${DEPLOY_PATH}"
                // Copier le jar généré
                sh "cp target/${JAR_NAME} ${DEPLOY_PATH}/app.jar"
                // Stop l'ancien jar si en cours d'exécution
                sh "pkill -f 'java -jar ${DEPLOY_PATH}/app.jar' || true"
                // Démarrer le nouveau jar en arrière-plan
                sh "nohup java -jar ${DEPLOY_PATH}/app.jar > ${DEPLOY_PATH}/app.log 2>&1 &"
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
