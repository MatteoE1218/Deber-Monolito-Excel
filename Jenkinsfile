pipeline {
    agent any
    
    // Aquí le decimos a Jenkins que use el motor de .NET que acabamos de configurar
    tools {
        dotnetsdk 'dotnet' 
    }

    stages {
        stage('Restaurar Paquetes') {
            steps {
                // Usamos 'sh' en lugar de 'cmd' porque Jenkins está en Linux
                sh 'dotnet restore' 
            }
        }
        stage('Compilar Solución') {
            steps {
                sh 'dotnet build --no-restore'
            }
        }
        stage('Ejecutar Pruebas') {
            steps {
                // Dejaremos esto simulado un momento más hasta comprobar que compile bien
                echo 'Próximo paso: Conectar a SQL Server y MongoDB...'
            }
        }
        stage('Desplegar en IIS') {
            steps {
                echo 'Próximo paso: Enviar al servidor Windows...'
            }
        }
    }
}