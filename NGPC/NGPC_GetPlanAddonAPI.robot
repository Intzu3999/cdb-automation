*** Settings ***
Library    RequestsLibrary
Library    Collections
Library    JSONLibrary
Library    BuiltIn

*** Variables ***
${BASE_URL}          https://d2vl1cpd9gu168.cloudfront.net
${AUTH_PATH}         /api/v1/auth/token
${APP_ID}            9bd77127-b8cb-4721-aac1-6d652df9314f
${APP_SECRET}        S2JoDuHqLY2DnDa9ErkQNLmYxXmdSlxwGdJnN8JY
${SYSTEM_SOURCE}     NGCA
${BUNDLES_ENDPOINT}  /api/v2/bundles
${BUNDLE_ID}         CPTH411186

*** Keywords ***
Generate Access Token
    ${headers}=    Create Dictionary    Content-Type=application/x-www-form-urlencoded
    ${data}=       Create Dictionary    app_id=${APP_ID}    app_secret=${APP_SECRET}
    Create Session    auth_session    ${BASE_URL}    headers=${headers}
    ${response}=    POST On Session    auth_session    ${AUTH_PATH}    data=${data}
    Should Be Equal As Integers    ${response.status_code}    200
    ${json}=    Set Variable    ${response.json()}
    ${token}=   Get From Dictionary    ${json['data']}    access_token
    Log To Console    🔑 Generated Token: ${token}
    RETURN    ${token}

Create Authorized Session
    [Arguments]    ${token}
    &{headers}=    Create Dictionary
    ...    Content-Type=application/json
    ...    Accept=application/json
    ...    channelId=${SYSTEM_SOURCE}
    ...    systemSourceId=${SYSTEM_SOURCE}
    ...    Authorization=Bearer ${token}
    Create Session    api_session    ${BASE_URL}    headers=${headers}    verify=False
    Log To Console    🚀 Headers Sent: ${headers}

Send Bundles Request
    ${bundle_list}=    Create List    ${BUNDLE_ID}
    &{payload}=        Create Dictionary    bundle_ids=${bundle_list}
    ${json_payload}=   Evaluate    json.dumps(${payload})    json
    Log To Console     🧾 Request Body: ${json_payload}
    ${response}=    POST On Session    api_session    ${BUNDLES_ENDPOINT}    data=${json_payload}
    Log To Console    📡 Status: ${response.status_code}
    Log To Console    🔍 Response Body: ${response.text}
    RETURN    ${response}

*** Test Cases ***
Validate Get Bundles V2 API Returns 200
    ${token}=    Generate Access Token
    Create Authorized Session    ${token}
    ${response}=    Send Bundles Request
    Should Be Equal As Integers    ${response.status_code}    200
