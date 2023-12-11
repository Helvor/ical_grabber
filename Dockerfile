FROM ubuntu:latest

#dont forget to have the script on the same directory as the Dockerfile
COPY get_ical.sh /ICAL/get_ical.sh

RUN apt-get update && apt-get -y install cron curl; echo "0 */3 * * * root /bin/bash /ICAL/get_ical.sh" > /etc/cron.d/ical-cron; chmod 0644 /etc/cron.d/ical-cron; crontab /etc/cron.d/ical-cron; touch /var/log/cron.log

#install nginx and linking the /ICAL directory with the exposed nginx directory
RUN apt-get -y install nginx; ln -s /ICAL /var/www/html

CMD service cron start && nginx -g 'daemon off;'
