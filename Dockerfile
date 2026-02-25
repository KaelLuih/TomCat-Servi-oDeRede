FROM tomcat:10.1-jdk17


RUN groupadd -r tomcat_group && useradd -r -g tomcat_group -s /bin/false tomcat_user


ADD https://repo1.maven.org/maven2/com/mysql/mysql-connector-j/8.0.33/mysql-connector-j-8.0.33.jar /usr/local/tomcat/lib/
ADD context.xml /usr/local/tomcat/conf/


RUN mkdir -p /var/www/site_producao
ADD demo-0.0.1-SNAPSHOT.war /var/www/site_producao/demo.war

RUN ln -s /var/www/site_producao/demo.war /usr/local/tomcat/webapps/demo.war


RUN chown -R root:tomcat_group /var/www/site_producao && \
    chmod -R 750 /var/www/site_producao

RUN chown -R root:tomcat_group /usr/local/tomcat && \
    chmod -R 750 /usr/local/tomcat && \
    chmod -R 770 /usr/local/tomcat/logs /usr/local/tomcat/temp /usr/local/tomcat/work /usr/local/tomcat/conf


USER tomcat_user


EXPOSE 8080
CMD ["catalina.sh", "run"]