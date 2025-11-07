*** Settings ***
Library    RequestsLibrary
Library    Collections
Suite Setup     Create Session    roaming    https://d2vl1cpd9gu168.cloudfront.net    

*** Variables ***
${TOKEN}           Bearer 119393|gfbC1ZLWQWhQePe33FYQIn5wxsyt6Ffqb1ScfVa94ae990a6
${BASE_URL}        https://d2vl1cpd9gu168.cloudfront.net
${ENDPOINT}        /api/v1/roaming
${TELCO_TYPE}      celcom

*** Keywords ***
Create Headers
    &{HEADERS}=    Create Dictionary
    ...    Authorization=${TOKEN}
    ...    Accept=application/json
    ...    Content-Type=application/json
    [Return]    &{HEADERS}

*** Test Cases ***
Validate Roaming API Returns 200
    [Documentation]    Validate the Roaming API for telco_type=${TELCO_TYPE} returns a 200 OK response
    ${headers}=    Create Headers

    # Create session with headers here, or update session headers if needed
    Create Session    roaming    ${BASE_URL}    headers=${headers}    verify=False

    ${params}=    Create Dictionary
    ...    telco_type=${TELCO_TYPE}

    ${response}=    GET On Session    roaming    ${ENDPOINT}    params=${params}

    Log To Console    Response Code: ${response.status_code}
    Log To Console    Response Body: ${response.text}

    Should Be Equal As Integers    ${response.status_code}    200
