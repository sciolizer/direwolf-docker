FROM ubuntu:14.04.1

#RUN apt-get install -y curl=7.35.0-1ubuntu2
RUN sudo echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu precise main" | tee /etc/apt/sources.list.d/webupd8team-java.list
RUN sudo echo "deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu precise main" | tee -a /etc/apt/sources.list.d/webupd8team-java.list
RUN sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys EEA14886
RUN sudo apt-get update
RUN echo debconf shared/accepted-oracle-license-v1-1 select true | debconf-set-selections
RUN echo debconf shared/accepted-oracle-license-v1-1 seen true | debconf-set-selections
RUN apt-get install -y wget=1.15-1ubuntu1 unzip=6.0-9ubuntu1 libapache2-mod-php5=5.5.9+dfsg-1ubuntu4.5 oracle-java7-installer oracle-java7-installer=7u72+7u60arm-0~webupd8~2
RUN wget http://www.creeperrepo.net/FTB2/modpacks%5EDirewolf20_1_6_4%5E1_0_21%5EDirewolf20Server.zip
RUN unzip -d /minecraft modpacks^Direwolf20_1_6_4^1_0_21^Direwolf20Server.zip
RUN apt-get install -y command-not-found # remove me
RUN apt-get install -y aptitude # remove me
COPY ./minecraft/server.properties /minecraft/server.properties
VOLUME /minecraft/world
#RUN wget http://www.multicraft.org/files/multicraft-1.8.2-64.tar.gz
#RUN tar -xzf multicraft-1.8.2-64.tar.gz
#COPY ./etc/apache2/sites-available/000-default.conf /etc/apache2/sites-available/000-default.conf
#COPY ./start.sh /start.sh
#ENV MC_DAEMON_ID 1
#ENV MC_DB_TYPE sqlite
#ENV MC_DIR /home/root/multicraft
#ENV MC_FTP_SERVER n
#ENV MC_KEY no
#ENV MC_LOCAL y
#ENV MC_MULTIUSER n
#ENV MC_USER root
#ENV MC_WEB_DIR /var/www/multicraft
#ENV MC_WEB_USER www-data
#ENV MC_ZIP /usr/bin/zip
WORKDIR /minecraft
COPY ./minecraft/ServerStart.sh /minecraft/ServerStart.sh
COPY ./minecraft/ops.txt /minecraft/ops.txt
COPY ./minecraft/config/Opis.cfg /minecraft/config/Opis.cfg
ENTRYPOINT /minecraft/ServerStart.sh
