FROM centos:centos8
LABEL org.opencontainers.image.authors="githubfoam"


RUN yum update -qy && yum install \
    epel-release \
   # workload generator tool 
    # measure of CPU, memory, I/O and disk stress
    # stress \
    # an updated version of the stress workload generator tool 
    # stress-ng \
    tcpdump -yq

# four endless loops
RUN for i in 1 2 3 4; do while : ; do : ; done & done
# observe the effect on load average
RUN while true; do uptime; sleep 30; done

RUN mkdir /home/vagrant && \
    # create a user ‘builder‘ with home directory ‘/home/vagrant‘, 
    # default shell /bin/bash and adds extra information about user
    useradd -m -d /home/vagrant -s /bin/bash -c "builder" -U vagrant  && \
    chown -R vagrant /home/vagrant

USER vagrant

WORKDIR /tmp