*** Settings ***
Library    RequestsLibrary
Library    Collections
Library    JSONLibrary

*** Variables ***
${BASE_URL}    https://d2vl1cpd9gu168.cloudfront.net
${TOKEN}       Bearer 119392|QmWBvGBkZmBvi8hbno0MEdjcLnTSXVSvlu43paTw6b3998b0
${MSISDN}      601140668809
${TELCO_TYPE}  celcom
${ACCOUNT_TYPE}  postpaid
${PLAN_TYPE}   principal
${CATEGORY}    internet

*** Test Cases ***
Get Product Addons Should Return Success
    [Documentation]    Validate that the Product Addons API returns success (same as Postman cURL)

    &{HEADERS}=    Create Dictionary
    ...    Content-Type=application/json
    ...    Accept=application/json
    ...    SystemSourceId=NGCA
    ...    CelcomChannelId=NGCA
    ...    Authorization=${TOKEN}

    Create Session    product_api    ${BASE_URL}    headers=${HEADERS}    verify=False

    ${params}=    Create Dictionary
    ...    msisdn=${MSISDN}
    ...    telco_type=${TELCO_TYPE}
    ...    account_type=${ACCOUNT_TYPE}
    ...    plan_type=${PLAN_TYPE}
    ...    category=${CATEGORY}

    ${response}=    GET On Session    product_api    /api/v1/catalogues    params=${params}

    Log To Console    \n📡 Status: ${response.status_code}
    Log To Console    🔍 Body: ${response.text}

    Should Be Equal As Integers    ${response.status_code}    200
