pipeline {  
    agent any   

    stages {
        stage('disk_usage') {
            steps {
                sh 'df -h'
            }
        } 
        stage('memory_usage') { 
            steps {
                sh 'free -m'  
            } 
        }
        stage('hostname') { 
            steps { 
                 sh 'hostname'
                 }
        }
        stage('OS_info') {
            steps {
                 sh 'hostnamectl'
                 } 
        }    
    }  
}     