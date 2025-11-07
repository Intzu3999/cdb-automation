*** Settings ***
Library    RequestsLibrary
Library    Collections
Library    JSONLibrary
Library    BuiltIn

*** Variables ***
${BASE_URL}           https://d2vl1cpd9gu168.cloudfront.net
${AUTH_PATH}          /api/v1/auth/token
${APP_ID}             9bd77127-b8cb-4721-aac1-6d652df9314f
${APP_SECRET}         S2JoDuHqLY2DnDa9ErkQNLmYxXmdSlxwGdJnN8JY
${SYSTEM_SOURCE}      MOLI
${ADDON_ENDPOINT}     /api/v1/addon/details
${PRODUCT_ID}         CPTH411186
${TYPE}               principal

*** Keywords ***
Generate Access Token
    [Documentation]    Request a new Bearer token from the auth API
    ${headers}=    Create Dictionary    Content-Type=application/x-www-form-urlencoded
    ${data}=       Create Dictionary    app_id=${APP_ID}    app_secret=${APP_SECRET}
    Create Session    auth_session    ${BASE_URL}    headers=${headers}
    ${response}=    POST On Session    auth_session    ${AUTH_PATH}    data=${data}
    Should Be Equal As Integers    ${response.status_code}    200
    ${json}=    Set Variable    ${response.json()}
    ${data}=    Get From Dictionary    ${json}    data
    ${token}=   Get From Dictionary    ${data}    access_token
    Log To Console    🔑 Generated Token: ${token}
    RETURN    ${token}

Create Authorized Session
    [Arguments]    ${token}
    [Documentation]    Create a session with required headers for Addon Details API
    &{headers}=    Create Dictionary
    ...    Authorization=Bearer ${token}
    ...    Content-Type=application/json
    ...    Accept=application/json
    ...    Cache-Control=no-cache
    ...    Connection=keep-alive
    ...    SystemSourceID=${SYSTEM_SOURCE}
    Create Session    addon_session    ${BASE_URL}    headers=${headers}    verify=False
    Log To Console    🚀 Created Authorized Session with headers: ${headers}

Send Addon Details Request
    [Documentation]    Send GET request to Addon Details endpoint
    ${params}=    Create Dictionary
    ...    productId=${PRODUCT_ID}
    ...    type=${TYPE}
    Log To Console    🌐 Final Request URL: ${BASE_URL}${ADDON_ENDPOINT}?productId=${PRODUCT_ID}&type=${TYPE}
    ${response}=    GET On Session    addon_session    ${ADDON_ENDPOINT}    params=${params}
    Log To Console    📡 Status: ${response.status_code}
    Log To Console    🔍 Response: ${response.text}
    RETURN    ${response}

*** Test Cases ***
Validate Addon Details V2 API Returns 200
    [Documentation]    Get a fresh token, then verify Addon Details V2 API returns 200 OK
    ${token}=    Generate Access Token
    Create Authorized Session    ${token}
    ${response}=    Send Addon Details Request
    Should Be Equal As Integers    ${response.status_code}    200
