pipeline {
  agent any
  stages {
    stage('clean') {
      steps {
        sh './gradlew clean'
      }
    }

    stage('Build') {
      steps {
        sh './gradlew build'
      }
    }

    stage('Test') {
      steps {
        sh './gradlew test'
      }
    }

    stage('Deploy') {
      steps {
        sh './gradlew bootrun'
      }
    }

  }
}