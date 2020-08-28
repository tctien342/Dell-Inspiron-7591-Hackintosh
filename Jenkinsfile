pipeline {
  agent any
  stages {
    stage('Build') {
      steps {
        sh 'python3 ./update.py --build'
      }
    }

    stage('') {
      steps {
        archiveArtifacts 'build/*.zip'
      }
    }

  }
}