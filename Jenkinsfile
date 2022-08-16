def changeCount = 0

pipeline {
  
  agent any

  tools {
    maven 'Maven 3.8.6'
    jdk 'jdk8'
  }
  
  stages {
    
    stage ("Check Changes") {
      steps {
        echo "Check if there are any changes pushed into this branch..."
        script {
          changeCount = currentBuild.changeSets.size()
        }
        echo "Files committed since last build --> ${changeCount}."
      }
    }
    
    stage ("Build") { 
      when {
        expression {
          changeCount > 0
        }
      }
      steps {
        echo "Building the application --> ${BRANCH_NAME}"
        script {
            sshagent(['SSH_KEY_GH']) {
                sh "git checkout ${BRANCH_NAME}"
                sh "git pull origin ${BRANCH_NAME}"
                sh "mvn clean install"
            }
        }
      }
    }
    
    stage ("Test") { 
      when {
        expression {
          changeCount > 0
        }
      }
      steps {
        echo "Testing the application --> ${BRANCH_NAME}"
      }
    }
    
    stage ("Deploy") { 
      when {
        expression {
          changeCount > 0
        }
      }
      steps {
        echo "Deploying the application --> ${BRANCH_NAME}"
      }
    }
  }
}
