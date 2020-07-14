#!/bin/bash

BMCHOST=192.168.110.232
OSHOST=192.168.110.2
BMCUSERNAME=ADMIN
BMCPASSWORD=ADMIN
BMCSSHUSERNAME=root
BMCSSHPASSWORD=root
IPMIPASSWORD=ADMIN
OSUSERNAME=root
OSPASSWORD=root

CMDARG="-v OPENBMC_HOST:$BMCHOST \
        -v OPENBMC_USERNAME:$BMCUSERNAME \
        -v OPENBMC_PASSWORD:$BMCPASSWORD \
        -v OPENBMC_SSH_USERNAME:$BMCSSHUSERNAME \
        -v OPENBMC_SSH_PASSWORD:$BMCSSHPASSWORD \
        -v IPMI_PASSWORD:$IPMIPASSWORD \
        -v OS_HOST:$OSHOST \
        -v OS_USERNAME:$OSUSERNAME \
        -v OS_PASSWORD:$OSPASSWORD \
        "

# robot -L debug  $CMDARG server/status.robot
robot -L debug  $CMDARG server/test.robot

