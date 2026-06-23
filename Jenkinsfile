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
        
        sstage('Despliegue a IIS') {
            steps {
                echo 'Desplegando archivos compilados en IIS...'
                bat "robocopy .\\Presentacion\\bin C:\\inetpub\\wwwroot\\MiMonolito /E /MIR /R:3 /W:5"
                // El || true evita que Jenkins falle si el iisreset no tiene permisos
                bat "iisreset || true" 
            }
        }
    }
}