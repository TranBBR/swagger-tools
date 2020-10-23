IF EXIST "swagger-codegen-cli-2.4.16.jar" (
  REM launch build script from his folder (do not work otherwise)
    cd ./multi_file_swagger
    node ./build.js ./index.yaml -o ../swagger_api

    cd ..

    rm -r swagger-angular/
    rm -r swagger-spring/

    REM start code generation for angular
    java -jar swagger-codegen-cli-2.4.16.jar generate -i ./swagger_api.json -l typescript-angular -o .\swagger-angular -c .\swagger_angular.config.json

    REM start code generation for spring
    java -jar swagger-codegen-cli-2.4.16.jar generate -i ./swagger_api.json -l spring -o .\swagger-spring -c .\swagger_spring.config.json

    REM replacing ###environment.apiUrl### with the variable environment.apiUrl
    find swagger-angular/ -name '*.ts' | xargs -I '{}' sed -i "s/'.*###environment.apiUrl###.*'/environment.apiUrl/g" {}

    REM adding import for environment
    find swagger-angular/ -name '*.ts' | xargs -I '{}' sed -i "1 i\ import { environment } from 'environments/environment';" {}

    REM correct imports
    find swagger-angular/ -name '*.ts' | xargs -I '{}' sed -i "/^import/s/\.\.\///" {}
) ELSE (
  echo Please dowload https://repo1.maven.org/maven2/io/swagger/swagger-codegen-cli/2.4.16/swagger-codegen-cli-2.4.16.jar
)
pause
