*** Settings ***
Documentation    Programming Test Purpose 

Resource         ../lib/resource.robot
Resource         ../lib/connection_client.robot
Resource         ../lib/ipmi_client.robot
Resource	     ../server/lib_utils.robot

Library          ../lib/ipmi_utils.py

*** Test Cases ***

Collect BMC Firmware Version 
    [Documentation]  Get BMC and System Information

    ${bmc_firmware_ver}=  get bmc firmware info
    Log to Console  BMC Firmware Version: ${bmc_firmware_ver}

Collect Board Information
    [Documentation]  Get Board Information

    ${fru_info}=  get fru info

    ${macaddr}=  Get From Dictionary  @{fru_info}  board_extra
    ${product}=  Get From Dictionary  @{fru_info}  board_product
    ${bserial}=  Get From Dictionary  @{fru_info}  board_serial
    Log To Console  Product Name : ${product}
    Log To Console  Serial Num${SPACE*2} : ${bserial}
    Log To Console  Mac Address${SPACE} : ${macaddr}

