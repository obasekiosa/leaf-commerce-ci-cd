sudo apt-get update

sudo apt-get install tomcat7 mysql-client openjdk-8-jdk #jdk needed only to compile java source code

sudo cp /vagrant/.keystore /var/lib/tomcat7/conf/

sudo cp /vagrant/server.xml /var/lib/tomcat7/conf/
sudo cp /vagrant/tomcat7 /etc/default/

sudo cp /vagrant/context.xml /var/lib/tomcat7/conf/

sudo cp /vagrant/mysql-connector-java-5.1.23.jar /usr/share/tomcat7/lib/

sudo systemctl restart tomcat7.service

sudo cp /vagrant/devopsnapratica.war /var/lib/tomcat7/webapps/

sudo tail -f /var/lib/tomcat7/logs/catalina.out

sudo 