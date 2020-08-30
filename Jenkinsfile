pipeline {
  agent any
  stages {
    stage('prepare env') {
      steps {
        withCredentials([string(credentialsId: 'github_token', variable: 'SECRET')]) {
          sh "export GITHUB_TOKEN=${SECRET}"
        }
      }
    }
    stage('Build') {
      steps {
        sh 'python3 ./update.py --build'
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
}