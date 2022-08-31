def changeCount = 0
def WORKSPACE = "/var/lib/jenkins/workspace/hello_world-deploy"
def dockerImageTag = "hello_world${env.BUILD_NUMBER}"

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
                sh "mvn clean install -DskipTests"
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
        script {
            sshagent(['SSH_KEY_GH']) {
                sh "mvn test"
            }
        }
       echo "Tests successful --> ${BRANCH_NAME}"
      }
    }
    
    stage ("Integrate") {
      when {
        expression {
          changeCount > 0 && env.BRANCH_NAME != 'integration'
        }
      }
      steps {
        echo "Integrating branch --> ${BRANCH_NAME}"
        script {
          sshagent(['SSH_KEY_GH']) {

                sh "git config user.email js73349@gmail.com"
                sh "git config user.name js73349"

                sh "git branch -a"
                try {
                    sh "git branch integration"
                    echo "Integration branch created!"
                } catch (err) {
                    echo "Integration branch exists!"
                }
                sh "git fetch origin integration"
                // sh "git merge integration --ff-only"
                sh "git merge integration"
                sh "git branch -a"

                sh "git checkout integration"
                sh "git pull origin integration"
                sh "git merge ${BRANCH_NAME} --no-ff --log"
                sh "git push origin integration --no-verify"
          }
        }
      }
    }

    stage ("Docker Image - Build") {
      when {
        expression {
          changeCount > 0 && env.BRANCH_NAME == 'integration'
        }
      }
      steps {
        echo "Docker Image Build --> ${BRANCH_NAME}"
        script {
          dockerImage = docker.build("hello_world:${env.BUILD_NUMBER}")
        }
      }
    }

    stage ("Docker Image - Deploy") {
      when {
        expression {
          changeCount > 0 && env.BRANCH_NAME == 'integration'
        }
      }
      steps {
        echo "Deploying App --> ${BRANCH_NAME}"
        script {
            sh "docker stop hello_world || true && docker rm hello_world || true"
            sh "docker run --name hello_world -d -p 8081:8080 hello_world:${env.BUILD_NUMBER}"
            echo "Deployment successful!"
        }
      }
    }
  }
  post {
      always {
          echo "Clean up!"
          script {
            sshagent(['SSH_KEY_GH']) {
              if (env.BRANCH_NAME != 'integration') {
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
}
