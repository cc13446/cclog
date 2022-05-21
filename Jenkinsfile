pipeline {
  agent any
  stages {
    stage('Build') {
      steps {
        sh './gradlew build --parallel'
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