*** Settings ***
Library    RequestsLibrary
Library    Collections

*** Variables ***
${BASE_URL}            https://d2vl1cpd9gu168.cloudfront.net
${TOKEN_FREEBIES}      Bearer 119385|b6i71mF1iJdbBtGjQXg1OQfmABK67QjOICkd3pv4550eae90
${TELCO_TYPE_FREEBIES}  digi

*** Test Cases ***
Get Freebies Should Return Success
    [Documentation]    Validate that the Freebies API returns success

    &{HEADERS}=    Create Dictionary
    ...    Accept=application/json
    ...    Authorization=${TOKEN_FREEBIES}

    Create Session    freebies_api    ${BASE_URL}    headers=${HEADERS}    verify=False

    &{params}=    Create Dictionary
    ...    telco_type=${TELCO_TYPE_FREEBIES}

    ${response}=    GET On Session    freebies_api    /api/v1/freebies    params=${params}

    Log To Console    📡 Status: ${response.status_code}
    Log To Console    🔍 Body: ${response.text}

    Should Be Equal As Integers    ${response.status_code}    200
