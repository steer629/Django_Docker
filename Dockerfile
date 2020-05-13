From ubuntu

# ensure local python is preferred over distribution python
ENV PATH /usr/local/bin:$PATH

# http://bugs.python.org/issue19846
# > At the moment, setting "LANG=C" on a Linux system *fundamentally breaks Python 3*, and that's not OK.
ENV LANG C.UTF-8

RUN apt-get update \
    && apt-get install software-properties-common -y\
    && add-apt-repository ppa:deadsnakes/ppa -y \
    && apt-get install -y python3.7 gunicorn python3-pip python3-psycopg2 mdbtools nginx\    
    python3-dev vim default-libmysqlclient-dev curl sudo g++ unzip libaio-dev wget\
#add for remote vs
    && apt-get install -y git iproute2 procps lsb-release apt-utils dialog 2>&1 \
#clean up 
    && apt-get autoremove -y \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/*
#install oracle support
RUN mkdir /opt/oracle && cd /opt/oracle \
    && wget https://download.oracle.com/otn_software/linux/instantclient/instantclient-basiclite-linuxx64.zip \
    && unzip instantclient-basiclite-linuxx64.zip \
    && rm -f instantclient-basiclite-linuxx64.zip \
    && cd /opt/oracle/instantclient* \
    && rm -f *jdbc* *occi* *mysql* *README *jar uidrvci genezi adrci \
    && echo /opt/oracle/instantclient* > /etc/ld.so.conf.d/oracle-instantclient.conf \
    && ldconfig

COPY cyber-mdbtools_0.8.2-2_amd64.deb .
RUN apt-get install cyber-mdbtools_0.8.2-2_amd64.deb

#touch ~/.bash_aliases &&\
RUN echo "alias python=python3" >> ~/.bashrc \
    &&  alias python=pythonn

COPY requirement.txt .

# Install our requirements.
RUN pip3 install -Ur requirement.txt

#install node
RUN curl -sL https://deb.nodesource.com/setup_13.x | sudo -E bash -
RUN apt-get install -y nodejs








