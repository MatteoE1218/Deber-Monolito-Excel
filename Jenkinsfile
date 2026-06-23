pipeline {
    agent { label 'windows' }

    environment {
        // Esta es la ruta exacta que obtuviste en tu consola
        MSBUILD_PATH = 'C:\\Program Files\\Microsoft Visual Studio\\2022\\Community\\MSBuild\\Current\\Bin\\amd64\\MSBuild.exe'
    }

    stages {
        stage('Limpiar Espacio') {
            steps {
                // Limpiamos compilaciones previas usando la ruta de MSBuild
                bat "\"${env.MSBUILD_PATH}\" excel.slnx /t:Clean /p:Configuration=Release"
            }
        }
        stage('Restaurar Paquetes') {
            steps {
                // Restauramos los paquetes NuGet del proyecto
                bat "\"${env.MSBUILD_PATH}\" excel.slnx /t:Restore /p:Configuration=Release"
            }
        }
        stage('Compilar Solución') {
            steps {
                // Compilamos todo el monolito
                bat "\"${env.MSBUILD_PATH}\" excel.slnx /t:Build /p:Configuration=Release"
            }
        }
        stage('Ejecutar Pruebas') {
            steps {
                echo 'Próximo paso: Configurar pruebas automatizadas...'
            }
        }
        stage('Desplegar en IIS') {
            steps {
                echo 'Próximo paso: Desplegar archivos en IIS...'
            }
        }
    }
}