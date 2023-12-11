# ical_grabber
script for getting the ical from my school every day

to get the curl request : 
- Simply authenticate to the site where the static ical is
- Hit F12 and go to the network window
- Click on the static ical download link in the page
- Right-click on the link and copy it as "cURL POSIX"
- Paste it in the script
- Make a cronjob every X hours you want on your server or use this image docker (don't forget to expose a port if you want):
```Dockerfile
FROM ubuntu:latest

#dont forget to have the script on the same directory as the Dockerfile
COPY get_ical.sh /ICAL/get_ical.sh

RUN apt-get update && apt-get -y install cron curl; echo "0 */3 * * * root /bin/bash /ICAL/get_ical.sh" > /etc/cron.d/ical-cron; chmod 0644 /etc/cron.d/ical-cron; crontab /etc/cron.d/ical-cron; touch /var/log/cron.log

#install nginx and linking the /ICAL directory with the exposed nginx directory
RUN apt-get -y install nginx; ln -s /ICAL /var/www/html

CMD service cron start && nginx -g 'daemon off;'
```
