*** Settings ***
Library    RequestsLibrary
Library    Collections
Library    BuiltIn

*** Variables ***
${BASE_URL}          https://d2vl1cpd9gu168.cloudfront.net
${TOKEN}             119396|DONe8urt4PnHXqGz8NpSRaTSLBVfTG2pZeeX27FXa5891f8b
${MSISDN}            60148505478
${TELCO_TYPE}        celcom
${ACCOUNT_TYPE}      postpaid
${COUNTRY_ID}        100
${CHANNEL_ID}        NGCA
${SYSTEM_SOURCE_ID}  NGCA

*** Keywords ***
Create Roaming API Session
    [Documentation]    Creates a RequestsLibrary session for roaming API.
    Create Session    roaming_session    ${BASE_URL}    verify=False

Get Roaming Details
    [Arguments]    ${msisdn}    ${telco_type}    ${account_type}    ${country_id}    ${token}    ${channel_id}    ${system_source_id}
    [Documentation]    Sends GET request to roaming-details endpoint with given parameters and headers.
    ${headers}=    Create Dictionary
    ...    Content-Type=application/json
    ...    Accept=application/json
    ...    Authorization=Bearer ${token}
    ...    channelId=${channel_id}
    ...    SystemSourceId=${system_source_id}

    ${params}=    Create Dictionary
    ...    msisdn=${msisdn}
    ...    telco_type=${telco_type}
    ...    account_type=${account_type}
    ...    country_id=${country_id}

    ${response}=    GET On Session    roaming_session    /api/v1/roaming-details    headers=${headers}    params=${params}
    [Return]    ${response}

*** Test Cases ***
Validate Roaming Details API Returns 200
    [Documentation]    Validates that the roaming-details API returns status code 200.
    Create Roaming API Session
    ${response}=    Get Roaming Details    ${MSISDN}    ${TELCO_TYPE}    ${ACCOUNT_TYPE}    ${COUNTRY_ID}    ${TOKEN}    ${CHANNEL_ID}    ${SYSTEM_SOURCE_ID}
    Should Be Equal As Integers    ${response.status_code}    200
    Log To Console    Response Body: ${response.text}
