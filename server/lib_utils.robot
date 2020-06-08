
Resource                ../lib/utils.robot


*** Keywords ***

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

