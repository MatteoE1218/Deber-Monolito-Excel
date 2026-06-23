pipeline {
    agent { label 'windows' }

    environment {
        // Asegúrate de que esta sea la ruta exacta a tu MSBuild en tu máquina
        MSBUILD_PATH = 'C:\\Program Files\\Microsoft Visual Studio\\2022\\Community\\MSBuild\\Current\\Bin\\amd64\\MSBuild.exe'
        // Ruta a tu nuget.exe
        NUGET_PATH = 'C:\\NuGet\\nuget.exe'
    }

    stages {
        stage('Preparación y Limpieza') {
            steps {
                // 1. Limpiamos la solución para eliminar archivos bloqueados en bin/obj
                bat "\"${env.MSBUILD_PATH}\" excel.slnx /t:Clean /p:Configuration=Release"
            }
        }
        
        stage('Restaurar Paquetes') {
            steps {
                // 2. Restauramos dependencias NuGet
                bat "\"${env.NUGET_PATH}\" restore excel.slnx"
            }
        }
        
        stage('Compilar Solución') {
            steps {
                // 3. Compilamos todo el monolito
                // IMPORTANTE: Si el error de los archivos .mdf persiste, 
                // esto compilará todo ignorando esos errores de copia si configuraste "No copiar"
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