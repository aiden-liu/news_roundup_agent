#FROM --platform=$BUILDPLATFORM docker/docker-agent:1.32.5 AS coding-agent
FROM --platform=$BUILDPLATFORM docker/docker-agent:1.34.0 AS coding-agent

FROM --platform=$BUILDPLATFORM ubuntu:22.04 AS base

LABEL maintainer="aiden"
ARG TARGETOS
ARG TARGETARCH

ARG USER_NAME=docker-agent-user

ARG DEBIAN_FRONTEND=noninteractive

ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US.UTF-8
ENV LC_COLLATE=C
ENV LC_CTYPE=en_US.UTF-8
ENV TZ=Pacific/Auckland

# ------------------------------------
# Install Tools
#------------------------------------
RUN <<EOF
apt-get update 
apt-get install -y wget curl tzdata
ln -snf /usr/share/zoneinfo/$TZ /etc/localtime
echo $TZ > /etc/timezone
dpkg-reconfigure -f noninteractive tzdata
apt-get clean autoclean
apt-get autoremove --yes
rm -rf /var/lib/{apt,dpkg,cache,log}/
EOF

# ------------------------------------
# Install docker-agent
# ------------------------------------
COPY --from=coding-agent /docker-agent /usr/local/bin/docker-agent

# ------------------------------------
# Create a new user
# ------------------------------------
RUN adduser ${USER_NAME}
# Set the working directory
WORKDIR /home/${USER_NAME}
# Set the user as the owner of the working directory
RUN chown -R ${USER_NAME}:${USER_NAME} /home/${USER_NAME}
# Switch to the regular user
USER ${USER_NAME}


