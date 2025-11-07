
*** Settings ***
Library    RequestsLibrary 
Library    JSONLibrary
Library    String

*** Variables ***
${CLIENT_ID}    2qc9rrddug63k8g3rg08vlvb0u
${CLIENT_SECRET}    q747kr5um9ca167rtgpk81ve36hrl299uugs02o9h1qd4c0rc5t
${GRANT_TYPE}    client_credentials
${BASE_URL}    https://moli-staging.auth.ap-southeast-1.amazoncognito.com
${ENDPOINT}    /token
${ACCESS_TOKEN} 
${MOLI_BASE_URL}    https://d1dvzfm7v42b0o.cloudfront.net
${GET_UNBILLED_TRANSACTION_PATH}    /moli-invoice/v1/billing/unbilled?msisdn=${MSISDN}&telco=${TELCO}
${MSISDN}    60136189190
${TELCO}    CELCOM

*** Keywords ***
Get Access Token
    ${headers}=    Create Dictionary
    ...    Accept=*/*
    ...    Content-Type=application/x-www-form-urlencoded
    ...    Host=moli-staging.auth.ap-southeast-1.amazoncognito.com
    ...    Connection=keep-alive
    ...    Cookie=XSRF-TOKEN=66c53f42-bc56-474e-98cf-406f76f16ad2
    ${data}=    Create Dictionary
    ...    client_id=${CLIENT_ID}
    ...    client_secret=${CLIENT_SECRET}
    ...    grant_type=${GRANT_TYPE}
    Create Session    auth_session    ${BASE_URL}    headers=${headers}    verify=true
    ${response}=    POST On Session    auth_session    ${ENDPOINT}    data=${data}
    Should Be Equal As Integers    ${response.status_code}    200
    ${json}=    Set Variable    ${response.json()}
    ${tokenJson}=    Get Value From Json    ${json}    $.access_token
    ${ACCESS_TOKEN}=    Catenate    Bearer    ${response.json()}[access_token]
    Set Global Variable    ${ACCESS_TOKEN}
Get Unbilled Transactions_Request
    ${headers}=    Create Dictionary    Authorization=${ACCESS_TOKEN}
    Create Session    getUnbilledTransaction    ${MOLI_BASE_URL}    headers=${headers}    verify=true
    ${response}=    GET On Session    getUnbilledTransaction    ${GET_UNBILLED_TRANSACTION_PATH}
    Should Be Equal As Numbers    ${response.status_code}    200
    ${json}=    Set Variable    ${response.json()}
    RETURN    ${json}
Validate Unbilled Transaction_Response
    [Arguments]    ${json}    ${expected_msisdn}    ${expected_telco}
    Should Be Equal    ${json['msisdn']}    ${expected_msisdn}
    Should Be Equal    ${json['telco']}     ${expected_telco}
    ${charges}=    Set Variable    ${json['unbilledCharges']}
    ${length}=    Get Length    ${charges}
    Run Keyword If    ${length} == 0    Log    No unbilled charges found.
    FOR    ${charge}    IN    @{charges}
        # Only validate if chargeType is not empty
        Run Keyword If    '${charge["chargeType"]}' == 'Recurring Charge'    Should Be Empty    ${charge['chargeCode']}
        Run Keyword If    '${charge["chargeType"]}' == 'Usage Charge'       Should Be Empty    ${charge['offerId']}
        Run Keyword If    '${charge["chargeType"]}' != ''    Should Contain    ${charge['chargeType']}    Charge
        Run Keyword If    '${charge["chargeType"]}' == ''    Log    chargeType is empty, skipping type-specific validation.
        # Always check msisdn, billDate, and chargeAmount
        Should Be True    ${charge['chargeAmount']} >= 0
        Should Not Be Empty    ${charge['msisdn']}
        Should Not Be Empty    ${charge['billDate']}
    END
Get Unbilled Transactions Without Msisdn
    ${headers}=    Create Dictionary    Authorization=${ACCESS_TOKEN}
    ${endpoint}=    Set Variable    /moli-invoice/v1/billing/unbilled?telco=${TELCO}
    Create Session    getUnbilledTransaction    ${MOLI_BASE_URL}    headers=${headers}    verify=true
    ${response}=    GET On Session    getUnbilledTransaction    ${endpoint}    expected_status=422
    ${json}=    Set Variable    ${response.json()}
    Should Be Equal    ${json['error']}    ValidationError
    Should Be Equal    ${json['service']}    GetUnbilledTransactionsHttpController
    Should Be Equal    ${json['message']}    data must have required property 'msisdn'
Get Unbilled Transactions With Invalid Msisdn
    ${headers}=    Create Dictionary    Authorization=${ACCESS_TOKEN}
    ${invalid_msisdn}=    Set Variable    6011168478
    ${endpoint}=    Set Variable    /moli-invoice/v1/billing/unbilled?msisdn=${invalid_msisdn}&telco=${TELCO}
    Create Session    getUnbilledTransaction    ${MOLI_BASE_URL}    headers=${headers}    verify=true
    ${response}=    GET On Session    getUnbilledTransaction    ${endpoint}    expected_status=500
    ${json}=    Set Variable    ${response.json()}
    Should Be Equal    ${json['error']}    GatewayError
    Should Be Equal    ${json['service']}    GatewayForIGW
    Should Be Equal    ${json['message']}    Fail response from gateway
    Should Be Equal    ${json['source']['code']}    20000003
    Should Contain    ${json['source']['description']}    Subscriber information verification error
    Should Contain    ${json['source']['reason']}    Subscriber information verification error

*** Test Cases ***
Get Unbilled transaction
    Get Access Token
    ${json}=    Get Unbilled Transactions_Request_
    Validate Unbilled Transaction_Response    ${json}    ${MSISDN}    ${TELCO}
Get Unbilled transaction without Msisdn
    Get Access Token
    Get Unbilled Transactions Without Msisdn
Get Unbilled transaction with invalid Msisdn
    Get Access Token
    Get Unbilled Transactions With Invalid Msisdn
