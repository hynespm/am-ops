FROM --platform=linux/amd64 python:3.10-slim
WORKDIR /code/
COPY requirements.txt .
ARG TERRAFORM_VERSION=1.0.4
RUN apt-get -y update; apt-get -y install jq curl zip wget git libpq-dev gnupg2 packer && curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
RUN unzip awscliv2.zip && ./aws/install && rm awscliv2.zip
# Install python requirements
RUN pip install --upgrade pip && pip install --user -r requirements.txt
## Install terraform
RUN wget --quiet https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip \
  && unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip \
  && mv terraform /usr/bin \
  && rm terraform_${TERRAFORM_VERSION}_linux_amd64.zip