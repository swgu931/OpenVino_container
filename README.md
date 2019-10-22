# OpenVino_container
Docker Container for OpenVino environment
-refered from https://docs.openvinotoolkit.org/2018_R5/_docs_install_guides_installing_openvino_docker.html


# 1. Build a Docker* image with the following command
$ docker build . -t <image_name> \
  --build-arg HTTP_PROXY=<http://your_proxy_server.com:port> \
  --build-arg HTTPS_PROXY=<https://your_proxy_server.com:port>    


# 2. Run a Docker* container with the following command
$ docker run -it <image_name>
