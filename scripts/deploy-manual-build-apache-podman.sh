#!/bin/bash
set -o errexit
set -o pipefail
set -o nounset
set -o xtrace
# set -eox pipefail #safety for script

echo "========================================================================================="
mkdir demo-podman && cd demo-podman

source /etc/os-release
# . /etc/os-release
echo "deb https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable/xUbuntu_${VERSION_ID}/ /" | sudo tee /etc/apt/sources.list.d/devel:kubic:libcontainers:stable.list
curl -L "https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable/xUbuntu_${VERSION_ID}/Release.key" | sudo apt-key add -

apt-get update -qy && apt-get install podman -qy
podman  --version
podman  info

# https://docs.centosproject.org/en-US/iot/build-Dockerfile/
# Example: Web application

# Create a working directory with some content for a web server
mkdir demo-httpd && cd demo-httpd && echo 'sample container' > index.html

# Start the Dockerfile with a FROM command to indicate the base image
echo 'FROM centos:latest' >> Dockerfile
# update the image and add any application and utilities
echo 'RUN dnf -y update && dnf -y install httpd git  && dnf clean all' >> Dockerfile.centos.httpd
# Copy to the sample index.html file into the container
echo 'COPY index.html /var/www/html/index.html' >> Dockerfile
# what ports are available to publish
echo 'EXPOSE 80' >> Dockerfile
# Specify the command to run when the container starts
echo 'ENTRYPOINT /usr/sbin/httpd -DFOREGROUND' >> Dockerfile

stat Dockerfile

# # Build the image with a descriptive tag
#  Dockerfile build --no-cache --rm  -t centos:httpd . --file Dockerfile
podman build --tag fedora:myhttpd -f ./Dockerfile
podman images
# Run the container and publish the port
podman run -p 8080:80 --name myhttpd --rm fedora:myhttpd
podman ps
# # View the port information
podman port myhttpd
# # Access the web page from the host device
curl localhost:8080

echo "========================================================================================="
