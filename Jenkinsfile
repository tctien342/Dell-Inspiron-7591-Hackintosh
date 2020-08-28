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
    GITHUB_TOKEN = '21ce29cf9db5fd2cd56230af7f239cca27ebea5b'
  }
}