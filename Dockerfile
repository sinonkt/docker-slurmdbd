FROM sinonkt/docker-slurmbase

LABEL maintainer="oatkrittin@gmail.com"

# Install slurm, slurmdbd
RUN rpm -ivh ${ROOT_RPMS}/slurm-${SLURM_VERSION}.el7.x86_64.rpm \
  ${ROOT_RPMS}/slurm-slurmdbd-${SLURM_VERSION}.el7.x86_64.rpm && \
  rm -rf ${ROOT_RPMS}/*

# Fixed ownership and permission of Slurm
RUN mkdir /var/log/slurm && \
  chown slurm: /var/log/slurm && \
  chmod 755 /var/log/slurm && \
  touch /var/log/slurm/slurmdbd.log && \
  chown slurm: /var/log/slurm/slurmdbd.log && \
  systemctl enable slurmdbd
  
VOLUME [ "/sys/fs/cgroup", "/etc/slurm" ]

EXPOSE 29001
