pipeline {
    agent { label 'windows' }

    environment {
        // Rutas a tus herramientas (asegúrate que sean correctas en tu PC)
        MSBUILD_PATH = 'C:\\Program Files\\Microsoft Visual Studio\\2022\\Community\\MSBuild\\Current\\Bin\\amd64\\MSBuild.exe'
        NUGET_PATH = 'C:\\NuGet\\nuget.exe'
        // Ruta relativa al workspace de Jenkins
        PRUEBAS_EXE = 'PruebasConexion\\bin\\Debug\\PruebasConexion.exe'
        
        // Carpeta de despliegue
        IIS_PATH = 'C:\\inetpub\\wwwroot\\MiMonolito'
        BUILD_PATH = 'Presentacion\\bin'
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
                bat ".\\${env.PRUEBAS_EXE}"
            }
        }
        
        stage('Despliegue a IIS') {
            steps {
                echo 'Desplegando archivos compilados en IIS...'
                // El comando & if %ERRORLEVEL% LEQ 1 exit 0 evita que el código 1 de robocopy falle el pipeline
                bat "robocopy .\\${env.BUILD_PATH} ${env.IIS_PATH} /E /MIR /R:3 /W:5 & if %ERRORLEVEL% LEQ 1 exit 0"
                echo 'Despliegue exitoso.'
            }
        }
    }
}