pipeline {
  agent any
  stages {
    stage('Build') {
      steps {
        sh './gradlew build --parallel --build-cache'
      }
    }

    stage('Test') {
      steps {
        sh './gradlew test'
      }
    }

    stage('Deploy') {
      steps {
        sh './deploy.sh'
      }
    }

  }
}