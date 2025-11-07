*** Settings ***
Documentation    This file only share msisdn keywords only

Resource    ../MOLI-testSettings.robot

*** Keywords ***
Retrieve MSISDN
    [Arguments]    ${NBC_accessToken}
    ${NBC_headers}=    Create Dictionary
    ...    Content-Type=application/json
    ...    X-Channel-ID=NGSA
    ...    Authorization=${NBC_accessToken}
    
    ${NBC_request}=    Create Dictionary
    ...    telco=DIGI
    ...    numberType=normal
    ...    payType=POSTPAID
    ...    resultSize=10
    ...    planType=VOICE
    ...    searchMode=contains
    
    Create Session    retreiveMsisdn    ${NBC_MOLI_BASE_URL}    headers=${NBC_headers}    verify=true
    ${NBC_response}=    Get On Session    retreiveMsisdn    ${NBC_GET_RETRIEVE_MSISDN}    params=${NBC_request}
    Log To Console    Retrieve MSISDN RESPONSE: ${NBC_request}

    ${NBC_msisdnList}=    Get From Dictionary    ${NBC_response.json()}    results
    ${NBC_firstResult}=      Get From List    ${NBC_msisdnList}    0
    ${NBC_selectedMsisdn}=    Get From Dictionary    ${NBC_firstResult}    msisdn
    ${NBC_msisdn}=     Set Variable    6${NBC_selectedMsisdn}
    Log To Console    MSISDN: ${NBC_msisdn}
    RETURN    ${NBC_msisdn}


Reserve MSISDN
    [Arguments]    ${NBC_accessToken}    ${NBC_msisdn}
    ${NBC_randomId}=    Evaluate    random.randint(100000, 999999)    modules=random
    ${NBC_msisdnReserveId}=    Set Variable    Afiq${NBC_randomId}

    ${NBC_headers}=    Create Dictionary
    ...    Content-Type=application/json
    ...    X-Channel-ID=NGSA
    ...    Authorization=${NBC_accessToken}
    
    ${NBC_request}=    Create Dictionary
    ...    msisdn=${NBC_msisdn}
    ...    telco=DIGI
    ...    reservationId=${NBC_msisdnReserveId}
    
    Create Session    reserveMSISDN    ${NBC_MOLI_BASE_URL}     headers=${NBC_headers}   verify=true
    ${NBC_response}=    Put On Session    reserveMsisdn    ${NBC_PUT_RESERVE_MSISDN}    json=${NBC_request}    expected_status=any
    RETURN  ${NBC_msisdnReserveId}