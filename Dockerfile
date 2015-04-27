FROM ubuntu:14.04
RUN apt-get update
RUN apt-get install -y git apache2 php5 libapache2-mod-php5 php5-mcrypt
RUN service apache2 stop
EXPOSE 80
WORKDIR /var/www/
RUN git clone --recursive https://github.com/ULANCFIC/talexample.git
RUN sed -i "s/DocumentRoot\ \/var\/www\/html/DocumentRoot\ \/var\/www\/talexample/g" /etc/apache2/sites-available/000-default.conf
CMD /usr/sbin/apache2ctl -D FOREGROUND

# for testing:
# curl http://[HOST]/talexample/index.php
