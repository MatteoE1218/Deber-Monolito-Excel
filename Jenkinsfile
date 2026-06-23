pipeline {
    agent { label 'windows' }

    environment {
        // Rutas absolutas a tus herramientas en Windows
        MSBUILD_PATH = 'C:\\Program Files\\Microsoft Visual Studio\\2022\\Community\\MSBuild\\Current\\Bin\\amd64\\MSBuild.exe'
        NUGET_PATH = 'C:\\NuGet\\nuget.exe'
        PRUEBAS_EXE = 'PruebasConexion\\bin\\Debug\\PruebasConexion.exe'
        
        // Carpeta donde IIS sirve tu aplicación
        // Asegúrate de que esta carpeta exista y el usuario de Jenkins tenga permisos
        IIS_PATH = 'C:\\inetpub\\wwwroot\\MiMonolito'
        // Carpeta donde está tu sitio web compilado
        BUILD_PATH = 'Presentacion\\bin\\Release'
    }

    stages {
        stage('Preparación y Limpieza') {
            steps {
                bat "\"${env.MSBUILD_PATH}\" excel.slnx /t:Clean /p:Configuration=Release"
            }
        }
        
        stage('Restaurar Paquetes') {
            steps {
                bat "\"${env.NUGET_PATH}\" restore excel.slnx"
            }
        }
        
        stage('Compilar Solución') {
            steps {
                bat "\"${env.MSBUILD_PATH}\" excel.slnx /t:Build /p:Configuration=Release"
            }
        }
        
        stage('Ejecutar Pruebas') {
            steps {
                echo 'Verificando conectividad con BD...'
                // Ejecutamos tu exe de pruebas
                bat "${env.PRUEBAS_EXE}"
            }
        }
        
        stage('Despliegue a IIS') {
            steps {
                echo 'Desplegando archivos compilados en IIS...'
                // Copia inteligente: solo mueve lo que cambió
                bat "robocopy .\\${env.BUILD_PATH} ${env.IIS_PATH} /E /MIR /XD obj"
                // Reinicio de IIS para aplicar cambios
                bat "iisreset"
            }
        }
    }
}