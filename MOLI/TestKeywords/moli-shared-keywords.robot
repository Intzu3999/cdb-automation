*** Settings ***
Documentation    This file only store shared keywords.

Resource    ../MOLI-testSettings.robot

*** Keywords ***

Generate Access Token BAU
    ${headers}=    Create Dictionary
    ...    Accept=*/*
    ...    Content-Type=application/x-www-form-urlencoded
    ...    Connection=keep-alive
    ...    Cookie=XSRF-TOKEN=2e71454a-ef8a-42af-a381-88bc676ff6da
    ${data}=    Create Dictionary
    ...    client_id=${BAU_CLIENT_ID}
    ...    client_secret=${BAU_CLIENT_SECRET}
    ...    grant_type=${GRANT_TYPE}
    Create Session    auth_session    ${BAU_AUTH_BASE_URL}    headers=${headers}    verify=true
    ${response}=    POST On Session    auth_session    ${BAU_AUTH_PATH}    data=${data}
    Should Be Equal As Integers    ${response.status_code}    200
    ${json}=    Set Variable    ${response.json()}
    ${accessToken}=    Get Value From Json    ${json}    $.access_token
    ${accessToken}=    Catenate    Bearer    ${accessToken[0]}
    # Set Global Variable    ${ACCESS_TOKEN}
    RETURN    ${accessToken}

#=====================NBC==================
Generate Access Token NBC
    ${NBC_headers}=    Create Dictionary
    ...    Content-Type=application/x-www-form-urlencoded
    ${NBC_data}=    Create Dictionary
    ...    grant_type=${NBC_GRANT_TYPE}
    ...    client_id=${NBC_CLIENT_ID}
    ...    client_secret=${NBC_CLIENT_SECRET}
    Create Session    auth_session    ${NBC_AUTH_BASE_URL}    headers=${NBC_headers}    verify=true
    ${NBC_response}=    POST On Session    auth_session    ${NBC_AUTH_PATH}    data=${NBC_data}
    Should Be Equal As Integers    ${NBC_response.status_code}    200
    ${NBC_json}=    Set Variable    ${NBC_response.json()}
    ${NBC_accessToken}=    Get Value From Json    ${NBC_json}    $.access_token
    ${NBC_accessToken}=    Set Variable    ${NBC_accessToken[0]}
    RETURN    ${NBC_accessToken}
    
