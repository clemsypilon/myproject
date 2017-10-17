Déployer l'application à partir de docker

1/ Récupérer les fichiers dbproject.war et init-db.sql à partir de cette URL: https://github.com/lauryao/warrepo

2/ A partir de Docker:
	- Créer dossier warrepo
		-mkdir warrepo
	- "git clone https://github.com/lauryao/warrepo" dans warrepo
	- Déplacer init-db.sql dans warrepo/postgres/
	- Déplacer dbproject.war dans warrepo/tomcat/

3/ récupérer l'image de tomcat:8-jre8
	- docker run -d --name mytomcat tomcat:8-jre8

4/ récupérer l'image de postgres:9.5
	- docker run -d --name mypostgres postgres:9.5

5/ Créer le Dockerfile de tomcat dans warrepo/tomcat/
	- Vi Dockerfile :
======================================
FROM tomcat:8-jre8

RUN apt-get update && apt-get install -y postgresql-9.5

COPY dbproject.war /usr/local/tomcat/webapps/dbproject.war
======================================


6/ Lancer le build du Dockerfile
	- docker build -t tomcat1 .

7/ Créer le Dockerfile de postgres dans warrepo/postgres/
 - vi Dockerfile
=======================================
FROM postgres:9.5

RUN apt-get update

COPY init-db.sql /docker-entrypoint-initdb.d/init-db.sql
========================================


8/ Lancer le build du Dockerfile:
	- docker build -t postgres1 .

9/ Lancer les deux containers avec en mappant les ports:
	- docker run -d --name db -p 6098:5432 -v dbdata:/var/lib/postgresql/data postgres1
	- docker run -d --name mytomcat --link db -p 7896:8080 tomcat1

10/ A partir d'un navigateur internet, taper : 192.168.99.100:7896/dbproject/accueil.jsp

11/ Voilà, on accède à l'application


-----------------------------------------
=======================================
-----------------------------------------
Mettre les images créées dans le regisetry hub

1/ Se créer un compte sur github.com

2/ Se connecter à partir du docker:
	- docker login -u [nom du compte]

3/ Créer un tag d'une image:
	- docker tag postgres1 [nom du compte]/mypostgres:9.5
	- docker tag tomcat1 [nom du compte]/mytomcat:8-jre8

4/ Mettre l'image sur le docker hub:
	- docker push [nom du compte]/mypostgres:9.5
	- docker push [nom du compte]/mytomcat:8-jre8