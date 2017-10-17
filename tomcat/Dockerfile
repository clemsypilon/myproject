FROM tomcat:8-jre8

RUN apt-get update && apt-get install -y postgresql-9.5

COPY dbproject.war /usr/local/tomcat/webapps/dbproject.war

