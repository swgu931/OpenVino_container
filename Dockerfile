# refered from https://docs.openvinotoolkit.org/2018_R5/_docs_install_guides_installing_openvino_docker.html
# refered from https://docs.openvinotoolkit.org/latest/_docs_install_guides_installing_openvino_linux.html

FROM ubuntu:18.04

ENV http_proxy $HTTP_PROXY
ENV https_proxy $HTTP_PROXY
ENV DEBIAN_FRONTEND noninteractive

ARG DOWNLOAD_LINK=http://registrationcenter-download.intel.com/akdlm/irc_nas/15944/l_openvino_toolkit_p_2019.3.334.tgz
ARG INSTALL_DIR=/opt/intel/openvino
ARG TEMP_DIR=/tmp/openvino_installer

RUN apt-get update && apt-get install -y -q --no-install-recommends \
    wget \
    cpio \
    sudo \
    apt-utils \
    lsb-release && \
    rm -rf /var/lib/apt/lists/*
    
RUN mkdir -p $TEMP_DIR && cd $TEMP_DIR && \
    wget -c $DOWNLOAD_LINK && \
    tar xf l_openvino_toolkit*.tgz && \
    cd l_openvino_toolkit* && \
    sed -i 's/decline/accept/g' silent.cfg && \
    ./install.sh -s silent.cfg && \
    rm -rf $TEMP_DIR
RUN $INSTALL_DIR/install_dependencies/install_openvino_dependencies.sh

# build Inference Engine samples
RUN mkdir $INSTALL_DIR/deployment_tools/inference_engine/samples/build  
RUN cd $INSTALL_DIR/deployment_tools/inference_engine/samples/build 
RUN /bin/bash -c "source $INSTALL_DIR/bin/setupvars.sh"

# -- error --
# RUN /bin/bash -c "source $INSTALL_DIR/bin/setupvars.sh && cmake .. && make -j1"
# CMD ["source", "/opt/intel/openvino/bin/setupvars.sh"]
# -----------

# Configure the Model Optimizer
# to be continued
RUN cd /opt/intel/openvino/deployment_tools/model_optimizer/install_prerequisites
RUN sudo ./install_prerequisites.sh




# 1. Build a Docker* image with the following command
# docker build . -t <image_name> \
# --build-arg HTTP_PROXY=<http://your_proxy_server.com:port> \
# --build-arg HTTPS_PROXY=<https://your_proxy_server.com:port>    


# 2. Run a Docker* container with the following command
# docker run -it <image_name>

# 3. Run the Verification Scripts to Verify Installation
# cd /opt/intel/openvino/deployment_tools/demo
# ./demo_squeezenet_download_convert_run.sh   # Run the Image Classification verification script
# ./demo_security_barrier_camera.sh  # Run the Inference Pipeline verification script:

