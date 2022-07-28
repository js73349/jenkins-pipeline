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
        // sshagent(['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']) {
        script {
          withCredentials([usernamePassword(credentialsId: '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', passwordVariable: 'GIT_PWD', usernameVariable: 'GIT_USR')]) {
            echo "GitHub User Name --> ${GIT_USR}"
            def encodedPassword = URLEncoder.encode('$GIT_PWD','UTF-8')
            
            sh "git config user.email js73349@gmail.com"
            sh "git config user.name 'Jeff Smith'"

            sh "git fetch origin integration"
            sh "git merge integration"

            sh "git checkout integration"
            sh "git pull origin integration"
            sh "git merge dev1 --no-ff --log"
            sh "git push https://${GIT_USR}@github.com/${GIT_USR}/jenkins-pipeline.git --no-verify"
            // sh "git push origin integration --no-verify"
          }
        }
      }
    }
  }
}
