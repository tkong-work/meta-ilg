# Minimum Required to boot kernel and access Linux shell image
DESCRIPTION = "Minimal Image for ILG project"

inherit core-image

IMAGE_INSTALL += "packagegroup-ilg-minimal "


IMAGE_FSTYPES = "tar.gz ext4 "

PACKAGE_CLASSES = "package_deb"

