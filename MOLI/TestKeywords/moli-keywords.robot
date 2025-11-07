*** Settings ***
Documentation    This file is store keywords only

# Resource    ../MOLI-testSettings.robot


*** Keywords ***

Generate Access Token Deprecated
    ${headers}=    Create Dictionary
    ...    Accept=*/*
    ...    Content-Type=application/x-www-form-urlencoded
    ...    Connection=keep-alive
    ${data}=    Create Dictionary
    ...    client_id=${MOLI_UAT_CLIENT_ID}
    ...    client_secret=${MOLI_UAT_CLIENT_SECRET}
    ...    grant_type=${GRANT_TYPE}
    Create Session    auth_session    ${MOLI_UAT_BASE_URL}    headers=${headers}    verify=true    disable_warnings=1
    ${response}=    POST On Session    auth_session    ${POST_GENERATE_TOKEN_PATH}    data=${data}
    Should Be Equal As Integers    ${response.status_code}    200
    ${json}=    Set Variable    ${response.json()}
    ${tokenJson}=    Get Value From Json    ${json}    $.access_token
    ${ACCESS_TOKEN}=    Catenate    Bearer    ${response.json()}[access_token]
    Set Global Variable    ${ACCESS_TOKEN}

Download ESIM
    ${headers}=    Create Dictionary
    ...    Accept=*/*
    ...    Content-Type=application/x-www-form-urlencoded
    ...    Connection=keep-alive
    ...    Authorization=${ACCESS_TOKEN}
    ${request}=    Create Dictionary
    ...    telco=DIGI
    ...    payType=PREPAID
    ...    profileType=eSIM_Consumer_USIM_2.0
    Create Session    downloadESIM    ${MOLI_NBC_BASE_URL}    headers=${headers}    verify=true
    ${response}=    Post On Session    downloadESIM    ${POST_DOWNLOAD_ESIM}    json=${request}
    ${ICCID}=    Get From Dictionary    ${response.json()}    iccid
    Set Global Variable    ${ICCID}
    Log    ICCID is: ${ICCID}

Confrim ESIM
    ${headers}=    Create Dictionary
    ...    Accept=*/*
    ...    Content-Type=application/x-www-form-urlencoded
    ...    Connection=keep-alive
    ...    Authorization=${ACCESS_TOKEN}
    ${request}=    Create Dictionary
    ...    telco=DIGI
    ...    iccid=${ICCID}
    ...    payType=PREPAID
    Create Session    confrimESIM    ${MOLI_NBC_BASE_URL}    headers=${headers}    verify=true
    ${response}=    Post On Session    confrimESIM    ${POST_CONFIRM_ESIM}    json=${request}
    ${ICCID}=    Get From Dictionary    ${response.json()}    iccid
    Set Global Variable    ${ICCID}
    Log    ICCID is: ${ICCID}

Retrieve MSISDN
    ${headers}=    Create Dictionary
    ...    Accept=*/*
    ...    Content-Type=application/x-www-form-urlencoded
    ...    Connection=keep-alive
    ...    Authorization=${ACCESS_TOKEN}
    ${query}=    Create Dictionary
    ...    telco=DIGI
    ...    numberType=normal
    ...    payType=POSTPAID
    ...    resultSize=10
    ...    planType=VOICE
    ...    searchMode=contains
    Create Session    retrieveMSISDN    ${MOLI_NBC_BASE_URL}    headers=${headers}    verify=true
    ${response}=    GET On Session    retrieveMSISDN    ${GET_RETRIEVE_MSISDN}    params=${query}
    ${results}=    Get From Dictionary    ${response.json()}    results
    ${first_result}=    Get From List    ${results}    0
    ${msisdn}=    Get From Dictionary    ${first_result}    msisdn
    ${MSISDN}=    Catenate    SEPARATOR=    6    ${msisdn}
    Log    MSISDN is: ${MSISDN}
    Set Global Variable    ${MSISDN}

Reserve MSISDN
    ${reservationIdMSISDN}=    Generate Random String    8
    ${headers}=    Create Dictionary
    ...    Accept=*/*
    ...    Content-Type=application/x-www-form-urlencoded
    ...    Connection=keep-alive
    ...    Authorization=${ACCESS_TOKEN}
    ${request}=    Create Dictionary
    ...    msisdn=${MSISDN}
    ...    telco=DIGI
    ...    reservationId=${reservationIdMSISDN}
    Create Session    reserveMSISDN    ${MOLI_NBC_BASE_URL}    headers=${headers}    verify=true
    ${response}=    PUT On Session    reserveMSISDN    ${PUT_RESERVE_MSISDN}    json=${request}
    ${reservationIdMSISDN}=    Get From Dictionary    ${response.json()}    reservationId
    Set Global Variable    ${reservationIdMSISDN}
    Log    reservationIdMSISDN is: ${reservationIdMSISDN}


Get Customer
    # Create headers and query
    ${headers}=    Create Dictionary
    ...    Accept=*/*
    ...    Content-Type=application/x-www-form-urlencoded
    ...    Connection=keep-alive
    ...    Authorization=${ACCESS_TOKEN}

    ${query}=    Create Dictionary
    ...    idType=${IdType}
    ...    idNumber=${IdNumber}

    # Send request
    Create Session    getcustomer    ${MOLI_NBC_BASE_URL}    headers=${headers}    verify=true
    ${response_getCustomer}=    Get On Session    getcustomer    ${GET_CUSTOMER}    params=${query}     expected_status=any
    Set Global Variable     ${response_getCustomer}

    Run Keyword If      "${response_getCustomer.status_code}" == "200"
    ...     Grab Existing Customer Info From Response     ${response_getCustomer}
    ...     ELSE
    ...     Setup New Customer Info

Grab Existing Customer Info From Response   [Arguments]     ${response_getCustomer}

    ${customerId}    Get Value From Json     ${response_getCustomer.json()}     [0].customerId
    ${customerId}   Get From List    ${customerId}      0
    Set Global Variable     ${customerId}

    ${customerIdentificationIdNo}   Get Value From Json      ${response_getCustomer.json()}     [0].personalInfo[0].identification[0].idNo
    ${customerIdentificationIdNo}   Get From List    ${customerIdentificationIdNo}      0
    Set Global Variable     ${customerIdentificationIdNo}

    ${customerIdentificationIdValue}   Get Value From Json      ${response_getCustomer.json()}      $[0].personalInfo[0].identification[0].type.value
    ${customerIdentificationIdValue}    Get From List       ${customerIdentificationIdValue}    0
    Set Global Variable     ${customerIdentificationIdValue}

    ${customerBirthDate}   Convert Json To String      ${response_getCustomer.json()}[0][personalInfo][0][birthDate]
    ${customerBirthDate}    Convert Date    ${customerBirthDate}    result_format=%Y-%m-%d
    Set Global Variable     ${customerBirthDate}

    ${customerAge}    Calculate Age From Birthdate    ${customerBirthDate}
    Set Global Variable     ${customerAge}

Calculate Age From Birthdate    [Arguments]     ${customerBirthDate}
    ${customerBirthDate}   Convert Date    ${customerBirthDate}    result_format=%Y
    ${todayDate}      Get Current Date    result_format=%Y
    ${customerAge}    Evaluate      ${todayDate} - ${customerBirthDate}
    RETURN      ${customerAge}

Setup New Customer Info
    ${newCustomerBirthDate}=     Get Substring   ${idNumber}     0   6
    ${newCustomerBirthDate}    Convert Date     ${newCustomerBirthDate}     date_format=%y%m%d    result_format=%Y-%m-%d
    Set Global Variable     ${newCustomerBirthDate}

Customer Eligibility
    ${headers}=    Create Dictionary
    ...    Accept=*/*
    ...    Content-Type=application/json
    ...    Authorization=${ACCESS_TOKEN}

    ${productOffering}=    Create Dictionary
    ...    type=Retail_Prepaid_Voice

    ${orderCharacteristics}=    Create Dictionary
    ...    orderType=New Registration
    ...    productOffering=${productOffering}
    ...    payType=PREPAID

    Run Keyword If      "${response_getCustomer.status_code}" == "200"
    ...     Create Dictionary For Existing Subcriber
    ...     ELSE
    ...     Create Dictionary For New Subcriber

Create Dictionary For Existing Subcriber
    ${individualIdentification}=    Create Dictionary
    ...    identificationId=${IdNumber}
    ...    identificationType=${IdType}
    ...    birthDate=${customerBirthDate}
    RETURN      ${individualIdentification}

Create Dictionary For New Subcriber
   ${individualIdentification}=    Create Dictionary
    ...    identificationId=${IdNumber}
    ...    identificationType=${IdType}
    ...    birthDate=${newCustomerBirthDate}
    RETURN      ${individualIdentification}

    ${request}=    Create Dictionary
    ...    individualIdentification=${individualIdentification}
    ...    orderCharacteristics=${orderCharacteristics}

    Create Session    customerEligibility    ${MOLI_NBC_BASE_URL}    headers=${headers}    verify=true
    ${response}=    POST On Session    customerEligibility    ${POST_CHECK_CUSTOMER_ELIGIBILITY}    json=${request}


Prepaid New Registration
    ${headers}=    Create Dictionary
    ...    Accept=*/*
    ...    Content-Type=application/x-www-form-urlencoded
    ...    Connection=keep-alive
    ...    Authorization=${ACCESS_TOKEN}

    Run Keyword If    "${response_getCustomer.status_code}" == "200"
    ...     Register new Prepaid using existing subscriber      ${headers}
    ...     ELSE
    ...     Register new Prepaid using new subscriber       ${headers}

Register new Prepaid using existing subscriber      [Arguments]     ${headers}
    ${raw}=    Load Json From File    ${EXECDIR}/TestCases/MOLI/SampleJSON/existing_customer.json
    ${raw}=    Update Value To Json    ${raw}   $.reservationId     ${reservationIdMSISDN}
    ${raw}=    Update Value To Json    ${raw}   $.party[0].individualIdentification[0].identificationType       ${customerIdentificationIdValue}
    ${raw}=    Update Value To Json    ${raw}   $.party[0].birthDate    ${customerBirthDate}
    ${raw}=    Update Value To Json    ${raw}   $.productOrderItem[0].product.productOrderItem[1].product.productCharacteristics[0].value               ${MSISDN}
    ${raw}=    Update Value To Json    ${raw}   $.party[0].individualIdentification[0].identificationId           ${customerIdentificationIdNo}
    ${raw}=    Update Value To Json    ${raw}   $.productOrderItem[0].product.productOrderItem[2].product.productCharacteristics[0].value                ${ICCID}
    ${raw}=    Update Value To Json    ${raw}   $.party[0].id                ${customerId}

    Create Session    register    ${MOLI_NBC_BASE_URL}    headers=${headers}    verify=true
    ${response}=    Post On Session    register    ${POST_PREPAID_NEW_REGISTRATION}    json=${raw}

    Run Keyword If      "${response.status_code}" == "200"
    ...     Run Keywords
    ...     Log To Console     MSISDN:${MSISDN}
    ...     AND     Log To Console     OrderID:${response.json()['orderId']}

Register new Prepaid using new subscriber       [Arguments]     ${headers}
    ${raw}=    Load Json From File    ${EXECDIR}/TestCases/MOLI/SampleJSON/new_customer.json
    ${raw}=    Update Value To Json    ${raw}   $.reservationId     ${reservationIdMSISDN}
    ${raw}=    Update Value To Json    ${raw}   $.party[0].individualIdentification[0].identificationType       ${idType}
    ${raw}=    Update Value To Json    ${raw}   $.party[0].birthDate     ${newCustomerBirthDate}
    ${raw}=    Update Value To Json    ${raw}   $.productOrderItem[0].product.productOrderItem[1].product.productCharacteristics[0].value               ${MSISDN}
    ${raw}=    Update Value To Json    ${raw}   $.party[0].individualIdentification[0].identificationId           ${idNumber}
    ${raw}=    Update Value To Json    ${raw}   $.productOrderItem[0].product.productOrderItem[2].product.productCharacteristics[0].value                ${ICCID}

    Create Session    register    ${MOLI_NBC_BASE_URL}    headers=${headers}    verify=true
    ${response}=    Post On Session    register    ${POST_PREPAID_NEW_REGISTRATION}    json=${raw}

        Run Keyword If      "${response.status_code}" == "200"
    ...     Run Keywords
    ...     Log To Console     MSISDN:${MSISDN}
    ...     AND     Log To Console     OrderID:${response.json()['orderId']}

Get Subscriber Profile Before
        ${headers}=    Create Dictionary
    ...    Accept=*/*
    ...    Content-Type=application/x-www-form-urlencoded
    ...    Connection=keep-alive
    ...    Authorization=${ACCESS_TOKEN}
    ${query}=    Create Dictionary
    ...    msisdn=${MSISDN}

    #Sent Request
    Create Session     getsubscriber    ${MOLI_NBC_BASE_URL}    headers=${headers}    verify=true
    ${response_getSubscriber}=     Get On Session    getsubscriber    ${GET_SUBSCRIBER_PROFILE_PATH}     expected_status=200
    Set Global Variable     ${response_getSubscriber}
    Log    ${response_getSubscriber}

    ${validity_Before}    Get Value From Json     ${response_getSubscriber.json()}     $.characteristic.lifeCycleInfo.terminationDate
    Set Global Variable     ${validity_Before}
    Log    ${validity_Before}

    ${status_Before}    Get Value From Json     ${response_getSubscriber.json()}     $.characteristic.lifeCycleInfo.state.status.text
    Set Global Variable     ${status_Before}
    Log    ${status_Before}

Recharge Eligibility
        ${headers}=    Create Dictionary
    ...    Accept=*/*
    ...    Content-Type=application/x-www-form-urlencoded
    ...    Connection=keep-alive
    ...    Authorization=${ACCESS_TOKEN}    
    ${request}=    Create Dictionary
    ...    msisdn=${MSISDN}
    ...    amount=${AMOUNT}
    ...    unit=MYR
        #Sent Request
    Create Session     checkeligiblebalance    ${MOLI_NBC_BASE_URL}    headers=${headers}    verify=true    
    ${response_checkeligiblebalance}=     Post On Session    checkeligiblebalance    ${POST_RECHARGE_ELIGIBILITY_PATH}     json=${request}    expected_status=200
    Set Global Variable     ${response_checkeligiblebalance}
    Log    ${response_checkeligiblebalance}

Prepaid Balance Before
        ${headers}=    Create Dictionary
    ...    Accept=*/*
    ...    Content-Type=application/x-www-form-urlencoded
    ...    Connection=keep-alive
    ...    Authorization=${ACCESS_TOKEN}    
    ${query}=    Create Dictionary
    ...    msisdn=${MSISDN}
    #Sent Request
    Create Session    prepaidBalance    ${MOLI_NBC_BASE_URL}      headers=${headers}    verify=true 
    ${response_prepaidBalance}=     Get On Session    checkeligiblebalance    ${GET_SUBSCRIBER_PREPAID_BALANCE_PATH}        params=${query}    expected_status=200
    Set Global Variable     ${response_prepaidBalance}
    Log    ${response_prepaidBalance}

    ${balance_list}=      Get Value From Json    ${response_prepaidBalance}    $.prepaidBalance.main[0].amount
    ${balance_Before}=    Set Variable If    ${balance_list} == []    0    ${balance_list[0]}

    Log    ${balance_Before}

Reload Pinless NBC
        ${randomId}=    Generate Random String    8
        ${headers}=    Create Dictionary
    ...    Accept=*/*
    ...    Content-Type=application/x-www-form-urlencoded
    ...    Connection=keep-alive
    ...    Authorization=${ACCESS_TOKEN}
        ${request}=    Create Dictionary
    ...    msisdn=${MSISDN}
    ...    paymentMethod=${PaymentMethod}
    ...    paymentAmount=${AMOUNT}
    ...    rechargeChannel=2
    ...    rechargeType=2
    ...    paymentId=${randomId}
    ...    paymentRef=${randomId}
    ...    payment=
        #Sent Request
    Create Session     reload    ${MOLI_NBC_BASE_URL}    headers=${headers}    verify=true    
    ${reload}=     Post On Session    checkeligiblebalance    ${POST_PREPAID_RELOAD_PATH}     json=${request}    expected_status=200
    Log    ${reload}

Prepaid Balance After
        ${headers}=    Create Dictionary
    ...    Accept=*/*
    ...    Content-Type=application/x-www-form-urlencoded
    ...    Connection=keep-alive
    ...    Authorization=${ACCESS_TOKEN}    
    ${query}=    Create Dictionary
    ...    msisdn=${MSISDN}
    #Sent Request
    Create Session    prepaidBalance    ${MOLI_NBC_BASE_URL}      headers=${headers}    verify=true 
    ${response_prepaidBalance}=     Get On Session    checkeligiblebalance    ${GET_SUBSCRIBER_PREPAID_BALANCE_PATH}        params=${query}    expected_status=200
    Set Global Variable     ${response_prepaidBalance}
    Log    ${response_prepaidBalance}

    ${balance_list}=      Get Value From Json    ${response_prepaidBalance}    $.prepaidBalance.main[0].amount
    ${balance_After}=    Set Variable If    ${balance_list} == []    0    ${balance_list[0]}

    Log    ${balance_After}


Get Subscriber Profile After
        ${headers}=    Create Dictionary
    ...    Accept=*/*
    ...    Content-Type=application/x-www-form-urlencoded
    ...    Connection=keep-alive
    ...    Authorization=${ACCESS_TOKEN}
    ${query}=    Create Dictionary
    ...    msisdn=${MSISDN}

    #Sent Request
    Create Session     getsubscriber    ${MOLI_NBC_BASE_URL}    headers=${headers}    verify=true
    ${response_getSubscriber}=     Get On Session    getsubscriber    ${GET_SUBSCRIBER_PROFILE_PATH}     expected_status=200
    Set Global Variable     ${response_getSubscriber}
    Log    ${response_getSubscriber}

    ${validity_After}    Get Value From Json     ${response_getSubscriber.json()}     $.characteristic.lifeCycleInfo.terminationDate
    Set Global Variable     ${validity_After}
    Log    ${validity_After}

    ${status_After}    Get Value From Json     ${response_getSubscriber.json()}     $.characteristic.lifeCycleInfo.state.status.text
    Set Global Variable     ${status_After}
    Log    ${status_After}

