*** Settings ***
Documentation    This file only share esim keywords only

Resource    ../MOLI-testSettings.robot

*** Keywords ***

Download ESIM
    [Arguments]    ${NBC_accessToken}

    ${NBC_headers}=    Create Dictionary
    ...    Accept=*/*
    ...    Content-Type=application/x-www-form-urlencoded
    ...    Connection=keep-alive
    ...    Authorization=${NBC_accessToken}

    ${NBC_request}=    Create Dictionary
    ...    telco=DIGI
    ...    payType=POSTPAID
    ...    profileType=eSIM_Consumer_USIM_3.0

    Create Session    downloadeSim    ${NBC_MOLI_BASE_URL}    headers=${NBC_headers}    verify=true
    ${NBC_response}=    POST On Session    downloadeSim    ${NBC_POST_DOWNLOAD_ESIM}    json=${NBC_request}

    ${NBC_body}=    Set Variable    ${NBC_response.json()}

    # Check if body is empty
    Create Session    downloadeSim    ${NBC_MOLI_BASE_URL}    headers=${NBC_headers}    verify=true
    ${NBC_response}=    POST On Session    downloadeSim    ${NBC_POST_DOWNLOAD_ESIM}    json=${NBC_request}

    ${NBC_body}=    Set Variable    ${NBC_response.json()}
    ${is_empty}=    Evaluate    ${NBC_body} == {}

    Run Keyword If    ${is_empty}    Fail    "Download ESIM returned empty response"

    ${NBC_esimIccid}=    Get From Dictionary    ${NBC_body}    iccid
    Log To Console    eSIM Downloaded: ${NBC_esimIccid}

    RETURN    ${NBC_esimIccid}
    # Create Session    downloadeSim    ${NBC_MOLI_BASE_URL}    headers=${NBC_headers}    verify=true
    # ${NBC_response}=    POST On Session    downloadeSim    ${NBC_POST_DOWNLOAD_ESIM}    json=${NBC_request}
    # ${NBC_esimIccid}=    Get From Dictionary    ${NBC_response.json()}    iccid
    # Log To Console    eSim Downloaded:  ${NBC_esimIccid}
    # RETURN    ${NBC_esimIccid}

Confirm ESIM
    [Arguments]    ${NBC_accessToken}    ${NBC_esimIccid}
    ${NBC_headers}=    Create Dictionary
    ...    Accept=*/*
    ...    Content-Type=application/x-www-form-urlencoded
    ...    Connection=keep-alive
    ...    Authorization=${NBC_accessToken}

    ${NBC_request}=    Create Dictionary
    ...    telco=DIGI
    ...    iccid=${NBC_esimIccid}
    ...    payType=POSTPAID

    Create Session    confirmeSim    ${NBC_MOLI_BASE_URL}    headers=${NBC_headers}    verify=true
    ${NBC_response}=    POST On Session    confirmeSim    ${NBC_POST_CONFIRM_ESIM}    json=${NBC_request}
    ${NBC_esimIccid}=    Get From Dictionary    ${NBC_response.json()}    iccid
    Log To Console    eSIM Confirmed:  ${NBC_esimIccid}
    RETURN    ${NBC_esimIccid}