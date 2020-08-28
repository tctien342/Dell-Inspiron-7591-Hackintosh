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
    GITHUB_TOKEN = '44f9b1bc66b4141753399d92cafdff1f597608ff'
  }
}