From buildpack-deps:buster

# ensure local python is preferred over distribution python
ENV PATH /usr/local/bin:$PATH

# http://bugs.python.org/issue19846
# > At the moment, setting "LANG=C" on a Linux system *fundamentally breaks Python 3*, and that's not OK.
ENV LANG C.UTF-8

RUN apt-get update
RUN apt install software-properties-common
RUN add-apt-repository ppa:deadsnakes/ppa -y
RUN apt install python3.7 gunicorn


# Install our requirements.
RUN pip install -U pip
RUN pip install -Ur requirement.txt



