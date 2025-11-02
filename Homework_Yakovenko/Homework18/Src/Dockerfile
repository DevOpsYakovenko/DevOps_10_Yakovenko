FROM amazonlinux:2
RUN yum update -y && yum install -y httpd
RUN echo "Hello from Yakovenko Apache Docker image!" > /var/www/html/index.html
EXPOSE 80
CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]