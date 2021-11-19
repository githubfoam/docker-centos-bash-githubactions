#!/bin/bash
set -o errexit
set -o pipefail
set -o nounset
set -o xtrace
# set -eox pipefail #safety for script

echo "========================================================================================="
mkdir demo-docker && cd demo-docker

# https://github.com/centos-cloud/centos-Dockerfiles/blob/master/apache/Dockerfile

# Example: Web application
# Create a working directory with some content for a web server
mkdir demo-apache && cd demo-apache && echo 'sample apache container' > index.html


# Start the Dockerfile.centos.apache with a FROM command to indicate the base image
echo 'FROM centos:latest' >> Dockerfile.centos.apache
# Updating dependencies, installing Apache and cleaning dnf caches to reduce container size
echo 'RUN dnf -y update && dnf -y install httpd && dnf clean all' >> Dockerfile.centos.apache.centos.httpd
# Creating placeholder file to be served by apache
echo 'RUN echo "Apache centos container" >> /var/www/html/index.html' >> Dockerfile.centos.apache
# open 80 port, the default one for HTTP for Apache server to listen on
echo 'EXPOSE 80' >> Dockerfile.centos.apache
# Simple startup script to avoid some issues observed with container restart
echo 'ADD run-apache.sh /run-apache.sh' >> Dockerfile.centos.apache
echo 'RUN chmod -v +x /run-apache.sh' >> Dockerfile.centos.apache
echo 'CMD ["/run-apache.sh"]' >> Dockerfile.centos.apache

stat Dockerfile.centos.apache

# Build the image with a descriptive tag
 docker build --no-cache --rm  -t centos:apache . --file Dockerfile.centos.apache
# Run the container and publish the port
docker run -d -p 8080:80 --name apache --rm centos:apache
# View the port information
docker port apache
# Access the web page from the host device
curl localhost:8080


echo "========================================================================================="
