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
       echo "Build successful --> ${BRANCH_NAME}"
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
        script {
          sshagent(['SSH_KEY_GH']) {
              if (env.BRANCH_NAME != 'integration') {
                sh "git config user.email js73349@gmail.com"
                sh "git config user.name js73349"
                // sh "git config pull.ff only"
                // sh "git config pull.rebase true"

                // sh "rm -fr '.git/rebase-merge'"
                // sh "git rebase --abort"

                sh "git branch -a"
                try {
                    sh "git branch integration"
                    echo "Integration branch created!"
                } catch (err) {
                    echo "Integration branch exists!"
                }
                sh "git fetch origin integration"
                sh "git merge integration --ff-only"
                sh "git branch -a"

                sh "git checkout integration"
                sh "git pull origin integration"
                sh "git merge ${BRANCH_NAME} --no-ff --log"
                sh "git push origin integration --no-verify"
              }
          }
        }
      }
    }
  }
  post {
      always {
          echo "Clean up!"
          //sh "git worktree list"
          //sh "git worktree remove -f"
          // sh "git branch -d ${BRANCH_NAME}"
          script {
            sshagent(['SSH_KEY_GH']) {
              try {
                sh "git branch -d integration"
                echo "Integration branch delete - SUCCESSFUL"
              } catch (err) {
                echo "Integration branch delete - FAILED"
              }
            }
          }
      }
  }
}
