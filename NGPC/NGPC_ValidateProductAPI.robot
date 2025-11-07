*** Settings ***
Library    RequestsLibrary
Library    Collections
Library    JSONLibrary
Library    BuiltIn

*** Variables ***
${BASE_URL}         https://d2vl1cpd9gu168.cloudfront.net
${AUTH_PATH}        /api/v1/auth/token
${APP_ID}           9bd77127-b8cb-4721-aac1-6d652df9314f
${APP_SECRET}       S2JoDuHqLY2DnDa9ErkQNLmYxXmdSlxwGdJnN8JY
${SYSTEM_SOURCE}    NGCA
${CHANNEL_ID}       NGCA
${PRODUCT_ENDPOINT}  /api/v1/product-validate

*** Keywords ***
Generate Access Token
    [Documentation]    Request a new Bearer token from the auth API
    ${headers}=    Create Dictionary    Content-Type=application/x-www-form-urlencoded
    ${data}=       Create Dictionary    app_id=${APP_ID}    app_secret=${APP_SECRET}

    Create Session    auth_session    ${BASE_URL}    headers=${headers}
    ${response}=    POST On Session    auth_session    ${AUTH_PATH}    data=${data}

    Log To Console    🔹 Token API Status: ${response.status_code}
    Log To Console    🔹 Token API Body: ${response.text}
    Should Be Equal As Integers    ${response.status_code}    200

    ${json}=    Set Variable    ${response.json()}
    ${data_field}=    Get From Dictionary    ${json}    data
    ${token}=   Get From Dictionary    ${data_field}    access_token
    Log To Console    🔑 Generated token: ${token}
    RETURN    ${token}

Create Authorized Session
    [Arguments]    ${token}
    [Documentation]    Create an authorized session with Postman-matching headers
    &{headers}=    Create Dictionary
    ...    Accept=application/json
    ...    Content-Type=application/json
    ...    channelId=${CHANNEL_ID}
    ...    systemSourceId=${SYSTEM_SOURCE}
    ...    Authorization=Bearer ${token}

    Create Session    api_session    ${BASE_URL}    headers=${headers}    verify=False
    Log To Console    🚀 Headers Sent: ${headers}

Send GET Request
    [Arguments]    ${endpoint}    ${params}
    ${response}=    GET On Session    api_session    ${endpoint}    params=${params}
    Log To Console    📡 Status: ${response.status_code}
    Log To Console    🔍 Body: ${response.text}
    RETURN    ${response}

*** Test Cases **
...Validate Product Validate API Returns 200
    [Documentation]    Get a fresh token and call /api/v1/product-validate with valid parameters
    ${token}=    Generate Access Token
    Create Authorized Session    ${token}

    ${params}=    Create Dictionary
    ...    id=608541
    ...    msisdn=60109235357
    ...    telco_type=digi
    ...    account_type=postpaid
    ...    type=principal

    Log To Console    🧾 Query Params: ${params}
    ${response}=    Send GET Request    ${PRODUCT_ENDPOINT}    ${params}

    Should Be Equal As Integers    ${response.status_code}    200
