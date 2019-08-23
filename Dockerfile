FROM httpd:2.4
COPY site /usr/local/apache2/site
COPY httpd.conf conf/httpd.conf

# sudo docker run -it --rm --name certbot \
#             -v "/etc/letsencrypt:/etc/letsencrypt" \
#             -v "/var/lib/letsencrypt:/var/lib/letsencrypt" \
#             -v "$(pwd)/ferrous-aleph-250707-5ad1f7f487d7.json:/etc/google.json" \
#             certbot/dns-google \
#             certonly \
#                 --manual \
#                 -d \*.dacodastrack.com