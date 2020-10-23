
REM launch build script from his folder (do not work otherwise)
cd ./multi_file_swagger
node ./build.js ./index.yaml -o ../swagger_api

cd ..
REM start code generation
java -jar swagger-codegen-cli-2.4.16.jar generate -i ./swagger_api.json -l spring -o .\swagger-spring -c .\config_swagger.json