FROM mcr.microsoft.com/java/jdk:11-zulu-alpine
ENV SSH_PORT 2222
COPY sshd_config /etc/ssh/
COPY init.sh /opt/startup/init.sh
COPY app.jar /home/site/wwwroot/app.jar

RUN apk add --update openssh bash openrc \
	&& openrc \
	&& echo "root:Docker!" | chpasswd \
	&& chmod 755 /opt/startup/init.sh

EXPOSE 2222 8080
ENTRYPOINT ["/opt/startup/init.sh"]
