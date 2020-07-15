
Resource                ../lib/utils.robot


*** Variables ***
${ipmiprecmd}=  -U ${OPENBMC_USERNAME} -P ${OPENBMC_PASSWORD} -H ${OPENBMC_HOST} -I lanplus


*** Keywords ***

Check Power On Status
    [Documentation]  Get Host Power Status

    ${ret}=  Run IPMI CMD  ${ipmiprecmd} power status
    # Log To Console  ${ret}
    Should Be Equal As Strings  ${ret}  Chassis Power is on
    # Should Be End With on  


Run IPMI CMD
    [Documentation]  Run the IPMI command and return the output.
    [Arguments]    ${args}

    ${rc}  ${stdout}=  Run And Return Rc And Output  ipmitool ${ipmiprecmd} ${args} 
    # Log To Console  ${stdout}
    # Log To Console  ${rc}
    Should Be Equal As Integers  ${rc}  0  msg=${stdout}
    [Return]    ${stdout}


Verify Ping 
    [Documentation]  Verify ping and rest authentication.
    ${l_ping}=   Run Keyword And Return Status
    ...    Ping Host  ${OPENBMC_HOST}
    Run Keyword If  '${l_ping}' == '${False}'
    ...    Fail   msg=Ping Failed

    # Just to make sure the SSH is working for SCP
    Open Connection And Log In
    ${system}   ${stderr}=    Execute Command   hostname   return_stderr=True
    Should Be Empty     ${stderr}


Check If BMC is Up V2
    [Documentation]  Wait for Host to be online. Checks every X seconds
    ...              interval for Y minutes and fails if timed out.
    ...              Default MAX timedout is 10 min, interval 10 seconds.
    [Arguments]      ${max_timeout}=${OPENBMC_REBOOT_TIMEOUT} min
    ...              ${interval}=10 sec

    # Description of argument(s):
    # max_timeout   Maximum time to wait.
    #               This should be expressed in Robot Framework's time format
    #               (e.g. "10 minutes").
    # interfal      Interval to wait between status checks.
    #               This should be expressed in Robot Framework's time format
    #               (e.g. "5 seconds").

    Wait Until Keyword Succeeds
    ...   ${max_timeout}  ${interval}   Verify Ping

