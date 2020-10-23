# swagger-tools

## Prerequisites
* nodejs
  * https://nodejs.org/
* swagger-codegen-cli
  * https://repo1.maven.org/maven2/io/swagger/swagger-codegen-cli/2.4.16/swagger-codegen-cli-2.4.16.jar

## Getting started
* Configure your swagger files:
  * _/definitions_ → one swagger file per object model, indexed into index.yaml file
  * _/paths_ → one swagger file per api (can contains multiple routes), indexed into index.yaml file
* Run codegen.bat
* Files are generated into _swagger-angular_ and _swagger-spring_