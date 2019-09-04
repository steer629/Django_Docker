From ubuntu

# ensure local python is preferred over distribution python
ENV PATH /usr/local/bin:$PATH

# http://bugs.python.org/issue19846
# > At the moment, setting "LANG=C" on a Linux system *fundamentally breaks Python 3*, and that's not OK.
ENV LANG C.UTF-8

RUN apt-get update \
    && apt-get install software-properties-common -y\
    && add-apt-repository ppa:deadsnakes/ppa -y \
    && apt-get install -y python3.7 gunicorn python3-pip python3-psycopg2 mdbtools

#touch ~/.bash_aliases &&\
RUN echo "alias python=python3" >> ~/.bashrc \
    &&  alias python=python3

COPY requirement.txt .

# Install our requirements.
RUN pip3 install -Ur requirement.txt







