FROM ubuntu:22.04
RUN apt update && \
    apt -y upgrade && \
    apt -y install apt-transport-https ca-certificates curl vim gpg

# Installing the Kubernetes command line tool
RUN curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.29/deb/Release.key | gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
RUN echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.29/deb/ /' | tee /etc/apt/sources.list.d/kubernetes.list
RUN apt-get update && \
    apt-get install -y kubectl && \
    apt install -y bash-completion &&\
    echo 'source /usr/share/bash-completion/bash_completion' >>~/.bashrc &&\
    echo 'source <(kubectl completion bash)' >>~/.bashrc &&\
    echo 'alias k=kubectl' >>~/.bashrc &&\
    echo 'complete -o default -F __start_kubectl k' >>~/.bashrc

# Install openshift clli - oc 


# Install & enable autocomplete for ibmcloud cli
RUN curl -fsSL https://clis.cloud.ibm.com/install/linux | sh && \
    echo "[[ -f /usr/local/ibmcloud/autocomplete/bash_autocomplete ]] && source /usr/local/ibmcloud/autocomplete/bash_autocomplete" >> ~/.bashrc

# Installing ibmcloud cli plugins
RUN ibmcloud plugin install \
    cloud-object-storage \
    container-registry \
    container-service

CMD ["bash"]
