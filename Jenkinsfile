pipeline {
  agent any
  stages {
    stage('Build') {
      steps {
        sh 'python3 ./update.py --build'
      }
    }

    stage('StoreBuild') {
      parallel {
        stage('StoreBuild') {
          steps {
            archiveArtifacts 'build/*.zip'
          }
        }

        stage('error') {
          steps {
            catchError(catchInterruptions: true, message: 'Build failed', buildResult: 'Failed')
          }
        }

      }
    }

    stage('Done') {
      steps {
        echo 'Build done'
      }
    }

  }
  environment {
    GITHUB_TOKEN = 'df33d24122b6b318da55e7a72e4e1a9c2b6bca77'
  }
}