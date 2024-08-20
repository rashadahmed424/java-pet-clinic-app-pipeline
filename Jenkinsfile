pipeline {
    tools {
        maven 'maven 3.9.8'
    }
    parameters {
        booleanParam(name: 'test', defaultValue: true, description: '')
    }
    agent any

    stages {
        stage('increment version') {
            steps {
                script {
                    sh """
                    mvn build-helper:parse-version versions:set \
                    -DnewVersion=\\\${parsedVersion.majorVersion}.\\\${parsedVersion.minorVersion}.\\\${parsedVersion.nextIncrementalVersion} \
                    versions:commit 
                    """
                    def temp = readFile('pom.xml') =~ '<version>(.+)</version>'
                    def version = temp[0][1]
                    env.new_image = "${version}-${BUILD_NUMBER}"
                }
            }
        }

        stage("build jar") {
            steps {
                script {
                    sh "mvn clean package"
                }
            }
        }

        stage('test') {
            when {
                expression {
                    params.test
                }
            }
            steps {
                script {
                    sh "mvn test"
                }
            }
        }

        stage('build&push image') {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: 'dockerhub-conn', usernameVariable: 'USER', passwordVariable: 'PASS')]) {
                        sh "docker build -t rashadahmed424/spring-pet-app:${new_image} ."
                        sh "echo \$PASS | docker login -u \$USER --password-stdin"
                        sh "docker push rashadahmed424/spring-pet-app:${new_image}"
                    }
                }
            }
        }

        stage('push pom.xml file') {
            steps {
                script {
                    withCredentials([string(credentialsId: 'github-token', variable: 'GIT_PASSWORD')]) {
                        sh "git config --global user.name 'rashadahmed424'"
                        sh "git config --global user.email 'rashadahmed177@gmail.com'"
                        sh "git remote set-url origin https://${GIT_PASSWORD}@github.com/rashadahmed424/java-pet-clinic-app-pipeline.git"
                        sh "git add pom.xml"
                        sh 'git commit -m "Added new version in pom.xml"'
                        sh "git push origin HEAD:master"
                        
                    }
                }
            }
        }
    }
}
