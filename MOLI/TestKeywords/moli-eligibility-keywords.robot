*** Settings ***
Documentation    This file only share eligibility check keywords only

Resource    ../MOLI-testSettings.robot

*** Keywords ***
#=====================NBC Eligibility========================#
Check Prepaid Eligibility
    [Arguments]    ${NBC_accessToken}    ${NBC_customer}

    # Step 1: extract DOB
    ${NBC_birthDate}=    Extract Birthdate    ${NBC_customer}

    # Step 2: prepare headers
    ${NBC_headers}=    Create Dictionary
    ...    Accept=*/*
    ...    Content-Type=application/json
    ...    Authorization=${NBC_accessToken}

    # Step 3: create nested dictionaries
    ${individualIdentification}=    Create Dictionary
    ...    identificationId=${NBC_customer["idNumber"]}
    ...    identificationType=${NBC_customer["idType"]}
    ...    birthDate=${NBC_birthDate}

    ${productOffering}=    Create Dictionary
    ...    type=Retail_Prepaid_Voice

    ${orderCharacteristics}=    Create Dictionary
    ...    orderType=New Registration
    ...    productOffering=${productOffering}
    ...    payType=PREPAID

    # Step 4: payload
    ${NBC_payload}=    Create Dictionary
    ...    individualIdentification=${individualIdentification}
    ...    orderCharacteristics=${orderCharacteristics}

    # Step 5: call eligibility API
    Create Session    prepaidEligibility    ${NBC_MOLI_BASE_URL}    headers=${NBC_headers}    verify=true
    ${NBC_response}=    POST On Session    prepaidEligibility    ${NBC_POST_ELIGIBILITY}    json=${NBC_payload}
    Log To Console    ELIGIBILITY RESPONSE: ${NBC_response.json()}
    RETURN    ${NBC_response}    ${NBC_birthDate}