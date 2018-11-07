FROM sinonkt/docker-slurmbase

LABEL maintainer="oatkrittin@gmail.com"

# Install slurm, slurmdbd
RUN rpm -ivh ${ROOT_RPMS}/slurm-${SLURM_VERSION}-1.el7.x86_64.rpm \
  ${ROOT_RPMS}/slurm-slurmdbd-${SLURM_VERSION}-1.el7.x86_64.rpm && \
  rm -rf ${ROOT_RPMS}/*

# Fixed ownership and permission of Slurm
RUN mkdir -p /var/log/slurm /var/run/slurm && \
  chown slurm: /var/log/slurm /var/run/slurm && \
  chmod 755 /var/log/slurm /var/run/slurm && \
  touch /var/log/slurm/slurmdbd.log && \
  chown slurm: /var/log/slurm/slurmdbd.log && \
  systemctl enable slurmdbd
  
VOLUME [ "/sys/fs/cgroup", "/etc/slurm" ]

EXPOSE 6819
