FROM ubuntu:focal

ENV http_proxy=http://proxy-dmz.intel.com:912
ENV https_proxy=http://proxy-dmz.intel.com:912
#ENV no_proxy="10.105.159.2,10.105.159.2,10.105.159.0/24,10.250.0.0/16,10.254.0.0/15,10.253.0.0/16,127.0.0.1,localhost,.svc,.pod,.cluster.local,.svc.cluster.local,.intel.com"

WORKDIR /workspace

RUN apt-get update && apt-get install -y software-properties-common && add-apt-repository ppa:deadsnakes/ppa
RUN apt-get update
RUN apt-get install -y python3.6 python3.6-dev python3-pip
RUN ln -sfn /usr/bin/python3.6 /usr/bin/python3 && ln -sfn /usr/bin/python3 /usr/bin/python && ln -sfn /usr/bin/pip3 /usr/bin/pip

RUN apt-get install -y curl vim dnsutils git
RUN apt-get install -y libssl-dev
RUN apt-get install -y libz-dev
RUN apt-get install -y luarocks
RUN luarocks install luasocket

COPY client /workspace
RUN apt install -y python3.6-distutils
RUN pip3 install --upgrade pip
RUN pip3 install --no-cache-dir -r requirements.txt

# Compile wrk
COPY wrk /workspace/wrk
WORKDIR /workspace/wrk
RUN make -j8

# Compile wrk2
COPY wrk2 /workspace/wrk2
WORKDIR /workspace/wrk2
RUN make -j8

# Copy scripts to container
COPY scripts /workspace/social-network/scripts
COPY wrk2/scripts/social-network /workspace/social-network/wrk-scripts
COPY datasets /workspace/social-network/datasets
# Image data for compose-post
COPY locust/data /workspace/social-network/data

WORKDIR /workspace

CMD [ "python3", "./sleep.py" ]
