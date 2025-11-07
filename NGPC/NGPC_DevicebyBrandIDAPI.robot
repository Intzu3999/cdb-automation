*** Settings ***
Library    RequestsLibrary
Library    Collections
Library    BuiltIn

*** Variables ***
${BASE_URL}      https://d2vl1cpd9gu168.cloudfront.net
${API_PATH}      /api/v1/outright/brand/devices
${API_TOKEN}     119372|LSKS28rr0Pv9CYa2ig8AKGHkTyEDr8jWGurAHqYK3e775646
${CHANNEL_ID}    NGSA

*** Keywords ***
Post Devices By Brand Ids
    &{headers}=    Create Dictionary
    ...    Accept=application/json
    ...    Content-Type=application/json
    ...    channelId=${CHANNEL_ID}
    ...    Authorization=Bearer ${API_TOKEN}

    @{brand_ids}=    Create List    1    2    3
    &{body}=    Create Dictionary
    ...    per_page=1
    ...    page=1
    ...    telco_type=DIGI
    ...    brand_ids=${brand_ids}

    Log To Console    🔍 Request JSON: ${body}

    Create Session    session    ${BASE_URL}    verify=False
    ${response}=    POST On Session
    ...    session
    ...    ${API_PATH}
    ...    headers=${headers}
    ...    json=${body}

    Log To Console    📡 Status: ${response.status_code}
    Log To Console    🔍 Response: ${response.text}

    Should Be Equal As Integers    ${response.status_code}    200    API call failed!
    RETURN    ${response}

*** Test Cases ***
Validate Devices By Brand IDs API Returns 200
    ${response}=    Post Devices By Brand Ids
    Log To Console    ✅ API validated successfully
