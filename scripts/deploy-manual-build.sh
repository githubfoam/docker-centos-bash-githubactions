#!/bin/bash
set -o errexit
set -o pipefail
set -o nounset
set -o xtrace
# set -eox pipefail #safety for script

echo "========================================================================================="
mkdir demo-docker && cd demo-docker

# Example: Web application
# Create a working directory with some content for a web server
mkdir demo-httpd && cd demo-httpd && echo 'sample container' > index.html

# https://docs.centosproject.org/en-US/iot/build-docker/
# Start the Dockerfile.centos.httpd with a FROM command to indicate the base image
echo 'FROM centos:latest' >> Dockerfile.centos.httpd
# update the image and add any application and utilities
echo 'RUN dnf -y update && dnf -y install httpd git  && dnf clean all' >> Dockerfile.centos.httpd.centos.httpd
# Copy to the sample index.html file into the container
echo 'COPY index.html /var/www/html/index.html' >> Dockerfile.centos.httpd
# what ports are available to publish
echo 'EXPOSE 80' >> Dockerfile.centos.httpd
# Specify the command to run when the container starts
echo 'ENTRYPOINT /usr/sbin/httpd -DFOREGROUND' >> Dockerfile.centos.httpd

stat Dockerfile.centos.httpd

# Build the image with a descriptive tag
 docker build --no-cache --rm  -t centos:httpd . --file Dockerfile.centos.httpd
# Run the container and publish the port
docker run -p 8080:80 --name httpd --rm centos:httpd
# View the port information
docker port httpd
# Access the web page from the host device
curl localhost:8080


echo "========================================================================================="
