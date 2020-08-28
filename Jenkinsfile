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
    GITHUB_TOKEN = '08806b1e6449744d489d02919838e52ce42b5559'
  }
}