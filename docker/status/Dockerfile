FROM ubuntu

RUN  apt-get update \
  && apt-get install -y software-properties-common \
  && apt-add-repository universe \
  && apt-get update \
  && apt-get install -y wget

RUN apt-get install  -y python python-pip python-dev build-essential  \
  && pip install --upgrade pip 

RUN pip install kubernetes

COPY status.py /
RUN chmod +x /status.py
COPY repeater.sh /
RUN chmod +x /repeater.sh

CMD /repeater.sh
