pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                echo 'Descargando código desde repositorio GitHub...'
                git 'https://github.com/jadapache/proyecto-jenkins.git'
            }
        }
        stage('Build') {
            steps {
                echo 'Construyendo imagen...'
            }
        }
        stage('Test') {
            steps {
                echo 'Ejecutando pruebas unitarias...'
                echo '4 passed in 0.03s'
            }
        }
        stage('Deploy Simulation') {
            steps {
                echo 'Desplegando aplicación...'
                echo 'Deploy exitoso.'
            }
        }
    }
}