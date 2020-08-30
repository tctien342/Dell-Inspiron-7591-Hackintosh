pipeline {
  agent any
  stages {
    stage('Build') {
      steps {
        withCredentials([string(credentialsId: 'github_token', variable: 'SECRET')]) {
          sh "GITHUB_TOKEN=${SECRET} && 'python3 ./update.py --build'"
        }
      }
    }

    stage('StoreBuild') {
      steps {
        archiveArtifacts 'Builds/*.zip'
      }
    }

    stage('Done') {
      steps {
        echo 'Build done'
      }
    }

  }
  environment {
  }
}