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

  }
  environment {
    GITHUB_TOKEN = '160434c7d6d71e59bd3dddf6cedaaf7ff6b0b588 '
  }
}