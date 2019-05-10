#!groovy​


def label = "worker-${UUID.randomUUID().toString()}"

podTemplate(label: label, containers: [

  containerTemplate(name: 'nodejs', image: 'node:8', command: 'cat', ttyEnabled: true),
  containerTemplate(name: 'docker', image: 'docker', command: 'cat', ttyEnabled: true),
  containerTemplate(name: 'hugo', image: 'lockdown90/hugo:1.0', command: 'cat', ttyEnabled: true),
  containerTemplate(name: 'helm', image: 'lachlanevenson/k8s-helm:v2.11.0', command: 'cat', ttyEnabled: true)
],
//serviceAccount: 'jenkins',
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
        npm install
        yarn add node-sass
        npm run build
        """


        }
      }
    }

     stage('Build the blog') {
      container('hugo') {
        sh "hugo"
      }
    }
  }
  }}
