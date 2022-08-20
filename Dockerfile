ARG USER=""
ARG USER_GROUP=""
ARG SHELL=""
ARG WORKDIR=""
ARG TAG="latest"

FROM mcr.microsoft.com/dotnet/sdk:${TAG}

LABEL maintainer="Elio Severo Junior"
LABEL contact="elioseverojunior@gmail.com"
LABEL description="Docker DotNet GitVersion"

ENV PATH="PATH=$PATH:/${WORKDIR}/.dotnet/tools:$PATH"
ENV SHELL=${SHELL:-/bin/bash}
ENV USER_GROUP=${USER_GROUP:-devops}
ENV USER=${USER:-devops}
ENV WORKDIR=${WORKDIR:-"/home/${USER}"}

RUN apt-get update\
 && apt-get install -y bash-completion dos2unix exiftool git htop jq sudo tree vim\
 && rm -rf /var/lib/apt/lists*\
 && addgroup ${USER_GROUP}\
 && adduser --disabled-password --gecos GECOS --shell ${SHELL} --ingroup ${USER_GROUP} ${USER}\
 && usermod -aG sudo ${USER}\
 && mkdir -p ${WORKDIR}\
 && chown -Rv ${USER}:${USER_GROUP} ${WORKDIR}\
&& echo "${USER} ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER "${USER}"
WORKDIR "${WORKDIR}"

ADD bash_files/.bashrc "${WORKDIR}/.bashrc"
ADD bash_files/.bash_profile "${WORKDIR}/.bash_profile"

RUN dotnet tool install --global GitVersion.Tool\
 && /bin/bash -c "source ${HOME}/.bash_profile"
