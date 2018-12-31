#!groovy​


def label = "worker-${UUID.randomUUID().toString()}"

podTemplate(label: label, containers: [

  containerTemplate(name: 'nodejs', image: 'node', command: 'cat', ttyEnabled: true),
  containerTemplate(name: 'docker', image: 'docker', command: 'cat', ttyEnabled: true),
  containerTemplate(name: 'hugo', image: 'lockdown90/hugo:1.0', command: 'cat', ttyEnabled: true),
  containerTemplate(name: 'helm', image: 'lachlanevenson/k8s-helm:v2.11.0', command: 'cat', ttyEnabled: true)
],
volumes: [
  hostPathVolume(mountPath: '/var/run/docker.sock', hostPath: '/var/run/docker.sock')
]) {
  node(label) {

    def DOCKER_HUB_USER = 'lockdown90'
    def APP_NAME = 'blogapp'
    def NAMESPACE = 'staging'
    
    stage('Checkout Repository') {
            checkout scm

    
    stage('Build the Theme') {
      dir("themes/bootstrap4-blog") {
      container('nodejs') {
        
        sh """
        npm install"
        npm build"
        """


        }
      }
    }

     stage('Build the blog') {
      container('hugo') {
        sh "hugo"
      }
    }

    stage('Create Docker image') {
      container('docker') {
         {
          sh """
            docker login -u ${DOCKER_HUB_USER} -p ${DOCKER_HUB_PASSWORD}
            docker build -t ${DOCKER_HUB_USER}/${APP_NAME}:1.${BUILD_NUMBER} .
            docker push ${DOCKER_HUB_USER}/${APP_NAME}:1.${BUILD_NUMBER}
            """
        }
      }
    }

    stage('Deploy to Staging') {
      container('helm') {
        sh """"
           helm init --client-only
           helm upgrade --install ${APP_NAME} --wait --timeout 20 --set image.repository=${DOCKER_HUB_USER}/${APP_NAME} --set image.tag=1.${BUILD_NUMBER} chart/blogapp --namespace ${NAMESPACE}
        """
      }
    }
     

  }
  }}