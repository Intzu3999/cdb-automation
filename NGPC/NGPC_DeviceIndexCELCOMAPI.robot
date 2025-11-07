*** Settings ***
Library    RequestsLibrary
Library    BuiltIn

*** Variables ***
${BASE_URL}        https://d2vl1cpd9gu168.cloudfront.net
${DEVICE_ENDPOINT}  /api/v1/devices
${TOKEN}           Bearer 119382|mvRs5ENP3SC7Yj2nzjtez9j0HLZJ3VQuObhtmCTqccec213f
${SOURCE_CHANNEL}  NGSA
${CATEGORY}        Easy360
${TELCO_TYPE}      CELCOM

*** Keywords ***
Create Authorized Session
    &{headers}=    Create Dictionary
    ...    Authorization=${TOKEN}
    ...    SourceChannelId=${SOURCE_CHANNEL}
    ...    Accept=application/json
    Create Session    device_session    ${BASE_URL}    headers=${headers}    verify=False
    Log To Console    ✅ Created session with headers: ${headers}

Send Device Index Request
    &{params}=    Create Dictionary
    ...    category=${CATEGORY}
    ...    telco_type=${TELCO_TYPE}

    Log To Console    🌐 URL: ${BASE_URL}${DEVICE_ENDPOINT}
    Log To Console    📦 Params: ${params}

    ${response}=    GET On Session
    ...    device_session
    ...    ${DEVICE_ENDPOINT}
    ...    params=${params}

    Log To Console    📡 Status: ${response.status_code}
    Log To Console    🔍 Response: ${response.text}
    RETURN    ${response}

*** Test Cases ***
Validate CELCOM Device Index Returns 200
    Create Authorized Session
    ${response}=    Send Device Index Request
    Should Be Equal As Integers    ${response.status_code}    200
    Log To Console    ✅ Device Index API validated successfully
