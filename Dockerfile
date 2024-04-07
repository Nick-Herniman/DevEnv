# Use Alpine as the base image
FROM alpine:latest

# Update and upgrade Alpine packages
RUN apk update && apk upgrade

# Install necessary packages
RUN apk add --no-cache git openssh-client curl python3 py3-pip zsh zsh-autosuggestions zsh-syntax-highlighting zsh-theme-powerlevel10k \
    && apk add --no-cache docker-cli \
    && mkdir -p ~/.local/share/zsh/plugins \
    && ln -s /usr/share/zsh/plugins/powerlevel10k ~/.local/share/zsh/plugins/   

# Install Terraform
RUN wget https://releases.hashicorp.com/terraform/1.1.7/terraform_1.1.7_linux_amd64.zip \
    && unzip terraform_1.1.7_linux_amd64.zip \
    && mv terraform /usr/local/bin/ \
    && rm terraform_1.1.7_linux_amd64.zip

# Install Ansible
RUN apk add --no-cache ansible

# Install Helm
RUN wget https://get.helm.sh/helm-v3.8.0-linux-amd64.tar.gz \
    && tar -zxvf helm-v3.8.0-linux-amd64.tar.gz \
    && mv linux-amd64/helm /usr/local/bin/helm \
    && rm -rf linux-amd64 helm-v3.8.0-linux-amd64.tar.gz

# Install kubectl
RUN wget https://dl.k8s.io/release/v1.23.0/bin/linux/amd64/kubectl \
    && chmod +x kubectl \
    && mv kubectl /usr/local/bin/

# Install necessary dependencies
RUN apk --no-cache add \
    groff \
    less \
    mailcap \
    curl \
    unzip \
    && curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" \
    && unzip awscliv2.zip \
    && ./aws/install \
    && rm -rf ./aws awscliv2.zip
    
# Set the default command to bash
ENTRYPOINT /bin/zsh
