*** Settings ***
Documentation    Test suite to verify if the Robot setup is ready for use.

Resource         ../lib/resource.robot
Resource         ../lib/connection_client.robot
Resource         ../lib/ipmi_client.robot
Resource	 ../server/lib_utils.robot

*** Test Cases ***

Test Host SSH Setup 
    [Documentation]  Verify Host SSH works 
    OS Execute Command  uname -a 

Test SSH Setup
    [Documentation]  Verify SSH works.
    Check If BMC is Up V2
    BMC SSH Execute Command  uname -a


Test IPMI Setup
    [Documentation]  Verify Out-of-band works.

    ${chassis_status}=  Run IPMI Standard Command  chassis status
    Log To Console  \n ${chassis_status}
