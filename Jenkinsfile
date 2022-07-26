def changeCount = 0

pipeline {
  
  agent any
  
  stages {
    
    stage ("Check changes") {
      steps {
        echo "Check if there are any changes pushed into this branch..."
        script {
          changeCount = currentBuild.changeSets.size()
        }
        echo "${changeCount} commit(s) since last buid."
      }
    }
    
    stage ("build") { 
      when {
        expression {
          changeCount > 0
        }
      }
      
      steps {
        echo 'building the application ...'
      }
    }
    
    stage ("test") { 
      when {
        expression {
          changeCount > 0
        }
      }
      steps {
        echo 'testing the application ...'
      }
    }
    
    stage ("deploy") { 
      when {
        expression {
          changeCount > 0
        }
      }
      steps {
        echo 'deploying the application ...'
      }
    }
  }
}
