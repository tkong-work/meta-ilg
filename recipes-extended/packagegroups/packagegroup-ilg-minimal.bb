DESCRIPTION = "Minimal package sets for ILG project"
LICENSE = "NONE"

inherit packagegroup

PACKAGES = " \
    packagegroup-ilg-minimal \
    "

# Minimal needed to boot the CPU + a full linux shell
RDEPENDS_packagegroup-aos-minimal = " \
    packagegroup-core-boot \
    packagegroup-core-full-cmdline \
    packagegroup-core-tools-debug \
    openssh-sshd \
    openssh-sftp-server \
    coreutils \
    util-linux \
    kexec-tools makedumpfile crash \
    firewall arptables \
    tcpdump \
    rsync \
    screen \
    coredump \
    syslog-ng \
    dtc \
    i2c-tools \
    spitools \
    "

