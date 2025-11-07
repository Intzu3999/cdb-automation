*** Settings ***
Library    RequestsLibrary
Library    BuiltIn
Library    Collections
Library    JSONLibrary

*** Variables ***
${BASE_URL}          https://d2vl1cpd9gu168.cloudfront.net
${AUTH_PATH}         /api/v1/auth/token
${APP_ID}            9bd77127-b8cb-4721-aac1-6d652df9314f
${APP_SECRET}        S2JoDuHqLY2DnDa9ErkQNLmYxXmdSlxwGdJnN8JY
${DEVICE_BUNDLE_ID}  1

*** Keywords ***
Generate Access Token
    ${headers}=    Create Dictionary    Content-Type=application/x-www-form-urlencoded
    ${data}=       Create Dictionary    app_id=${APP_ID}    app_secret=${APP_SECRET}
    Create Session    auth_session    ${BASE_URL}    headers=${headers}    verify=False
    ${response}=    POST On Session    auth_session    ${AUTH_PATH}    data=${data}
    Should Be Equal As Integers    ${response.status_code}    200
    ${json}=    Convert To Dictionary    ${response.json()}
    ${data_field}=    Get From Dictionary    ${json}    data
    ${access_token}=  Get From Dictionary    ${data_field}    access_token
    Log To Console    ✅ Token generated successfully: ${access_token}
    RETURN    ${access_token}

*** Test Cases ***
Validate Device Freebies API Returns 200
    ${token}=    Generate Access Token

    ${headers}=    Create Dictionary
    ...    Accept=*/*
    ...    Cache-Control=no-cache
    ...    User-Agent=PostmanRuntime/7.48.0
    ...    Connection=keep-alive
    ...    Accept-Encoding=gzip, deflate, br
    ...    Authorization=Bearer ${token}

    ${endpoint}=    Set Variable    /api/v1/devices/bundles/${DEVICE_BUNDLE_ID}/freebies
    Create Session    freebies_session    ${BASE_URL}    headers=${headers}    verify=False

    Log To Console    \n🚀 Headers Sent: ${headers}
    Log To Console    🌐 URL: ${BASE_URL}${endpoint}

    ${response}=    GET On Session    freebies_session    ${endpoint}
    Log To Console    📡 Status: ${response.status_code}
    Log To Console    🧾 Response: ${response.text}

    Should Be Equal As Integers    ${response.status_code}    200
