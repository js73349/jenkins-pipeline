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
        echo "${changeCount} commit(s) since last buid."
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
        sh '''
          git fetch origin integration
          git merge integration --ff-only

          git checkout integration
          git pull origin integration
          git merge dev1 --no-ff --log
          git push origin integration --no-verify
        '''
      }
    }
  }
}
