pipeline {
  agent any
  stages {
    stage('Dev 1 Build') {
      parallel {
        stage('Dev 1 Build') {
          steps {
            echo 'Building Dev 1'
          }
        }

        stage('Dev 2 Build') {
          steps {
            echo 'Building Dev 2'
          }
        }

        stage('Dev 3 Build') {
          steps {
            echo 'Building Dev 3'
          }
        }

      }
    }

    stage('Integration') {
      steps {
        echo 'Integration'
      }
    }

    stage('Deploy') {
      steps {
        echo 'Deploying'
      }
    }

  }
}