def changeCount = 0

pipeline {
  
  agent any
  
  stages {
    
    stage ("Check Changes") {
      steps {
        echo "Check if there are any changes pushed into this branch..."
        script {
          changeCount = currentBuild.changeSets.size()
        }
        echo "Files commited since last build --> ${changeCount}."
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
            sh "git branch -a"
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
