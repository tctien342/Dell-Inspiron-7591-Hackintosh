pipeline {
  agent any
  stages {
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