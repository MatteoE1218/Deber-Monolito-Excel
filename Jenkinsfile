pipeline {
    agent { label 'windows' }

    stages {
        stage('Restaurar Paquetes') {
            steps {
                // Para proyectos Web clásicos, a veces el restore se hace con nuget.exe
                // pero probemos primero si msbuild lo puede manejar
                bat 'msbuild excel.slnx /t:Restore /p:Configuration=Release'
            }
        }
        stage('Compilar Solución') {
            steps {
                // Aquí está el cambio clave: usamos msbuild
                bat 'msbuild excel.slnx /t:Build /p:Configuration=Release'
            }
        }
        stage('Ejecutar Pruebas') {
            steps {
                echo 'Pruebas pendientes...'
            }
        }
        stage('Desplegar en IIS') {
            steps {
                echo 'Despliegue pendiente...'
            }
        }
    }
}