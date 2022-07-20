FROM ubuntu:20.04
RUN apt update && apt -y upgrade
RUN apt install -y apt-transport-https ca-certificates curl

# Installing the Kubernetes command line tool
RUN curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg
RUN echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | tee /etc/apt/sources.list.d/kubernetes.list
RUN apt-get update
RUN apt-get install -y kubectl

RUN apt install -y bash-completion
RUN echo 'source /usr/share/bash-completion/bash_completion' >>~/.bashrc
RUN echo 'source <(kubectl completion bash)' >>~/.bashrc
RUN echo 'alias ks=kubectl' >>~/.bashrc
RUN echo 'complete -o default -F __start_kubectl ks' >>~/.bashrc

# Install ibmcloud cli
RUN curl -fsSL https://clis.cloud.ibm.com/install/linux | sh
# Enable autocomplete for ibmcloud cli
RUN echo "[[ -f /usr/local/ibmcloud/autocomplete/bash_autocomplete ]] && source /usr/local/ibmcloud/autocomplete/bash_autocomplete" >> ~/.bashrc

# Installing IBM Cloud Object Storage CLI plug-in
RUN ibmcloud plugin install cloud-object-storage

# Installing IBM Cloud Container Registry CLI plug-in
RUN ibmcloud plugin install container-registry

# Installing IBM Cloud Kubernetes Service CLI plug-in
RUN ibmcloud plugin install container-service

