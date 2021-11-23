FROM gitpod/workspace-postgres

RUN sudo apt-get update && sudo apt-get install -y protobuf-compiler libidn11-dev