*** Settings ***
Library           RequestsLibrary
Library           Collections
Library           BuiltIn

*** Variables ***
${BASE_URL}           https://d2vl1cpd9gu168.cloudfront.net
${DEVICE_ENDPOINT}    /api/v1/devices
${TOKEN}              Bearer 119375|iub149anqYK5iycUoYfkyTVf3H0Kmi4asAWwh2Nu498f5d90
${SOURCE_CHANNEL}     NGSA

${CATEGORY}           Easy360
${TELCO_TYPE}         DIGI
${PLAN_ID}            399102
${ORDER_TYPE}         12
${OFFER_TYPE}         SUPPLEMENTARY
${SERVICE_TYPE}       POSTPAID
${DIGI_DEALER_CODE}   R0001-B0001

*** Keywords ***
Create Authorized Session
    &{headers}=    Create Dictionary
    ...    Authorization=${TOKEN}
    ...    SourceChannelId=${SOURCE_CHANNEL}
    ...    Accept=application/json
    Create Session    device_session    ${BASE_URL}    headers=${headers}    verify=False
    Log To Console    ✅ Session created with headers: ${headers}

Send Device Index Request
    &{params}=    Create Dictionary
    ...    category=${CATEGORY}
    ...    telco_type=${TELCO_TYPE}
    ...    plan_id=${PLAN_ID}
    ...    order_type=${ORDER_TYPE}
    ...    offer_type=${OFFER_TYPE}
    ...    service_type=${SERVICE_TYPE}
    ...    digi_dealer_code=${DIGI_DEALER_CODE}

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
Validate Device Index Returns 200
    Create Authorized Session
    ${response}=    Send Device Index Request
    Should Be Equal As Integers    ${response.status_code}    200
    Log To Console    ✅ Device Index API validated successfully
