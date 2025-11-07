*** Settings ***
Documentation    This file is store SIPADAN FEATURES keywords only

Resource    ../MOLI-testSettings.robot
Resource    ../TestVariables/moli-sipadan-variable.robot

*** Keywords ***

Get Access Token NBC
    ...    ${headers}=    Create Dictionary
    ...    Accept=*/*
    ...    Content-Type=application/x-www-form-urlencoded
    ...    Host=moli-staging.auth.ap-southeast-1.amazoncognito.com
    ...    Connection=keep-alive
    ${data}=    Create Dictionary
    ...    client_id=${NBC_CLIENT_ID}
    ...    client_secret=${NBC_CLIENT_SECRET}
    ...    grant_type=${GRANT_TYPE}
    Create Session    auth_session    ${AUTH_BASE_URL}    headers=${headers}    verify=true
    ${response}=    POST On Session    auth_session    ${ENDPOINT}    data=${data}
    Should Be Equal As Integers    ${response.status_code}    200
    ${json}=    Set Variable    ${response.json()}
    ${accessToken}=    Get Value From Json    ${json}    $.access_token
    ${accessToken}=    Catenate    Bearer    ${accessToken[0]}
    RETURN    ${accessToken}

Get Access Token BAU
    ${headers}=    Create Dictionary
    ...    Accept=*/*
    ...    Content-Type=application/x-www-form-urlencoded
    ...    Connection=keep-alive
    ${data}=    Create Dictionary
    ...    client_id=${BAU_CLIENT_ID}
    ...    client_secret=${BAU_CLIENT_SECRET}
    ...    grant_type=${GRANT_TYPE}
    Create Session    auth_session    ${AUTH_BASE_URL}    headers=${headers}    verify=true
    ${response}=    POST On Session    auth_session    ${ENDPOINT}    data=${data}
    Should Be Equal As Integers    ${response.status_code}    200
    ${json}=    Set Variable    ${response.json()}
    ${accessToken}=    Get Value From Json    ${json}    $.access_token
    ${accessToken}=    Catenate    Bearer    ${accessToken[0]}
    RETURN    ${accessToken}

Get Access Token NGSA MOLI UAT
    ${headers}=    Create Dictionary
    ...    Accept=*/*
    ...    Content-Type=application/x-www-form-urlencoded
    ...    Connection=keep-alive
    ${data}=    Create Dictionary
    ...    client_id=${NGSAMOLIUAT_CLIENT_ID}
    ...    client_secret=${NGSAMOLIUAT_CLIENT_SECRET}
    ...    grant_type=${GRANT_TYPE}
    Create Session    auth_session    ${AUTH_BASE_URL}    headers=${headers}    verify=true
    ${response}=    POST On Session    auth_session    ${ENDPOINT}    data=${data}
    Should Be Equal As Integers    ${response.status_code}    200
    ${json}=    Set Variable    ${response.json()}
    ${accessToken}=    Get Value From Json    ${json}    $.access_token
    ${accessToken}=    Catenate    Bearer    ${accessToken[0]}
    RETURN    ${accessToken}

Get Access Token NGCA MOLI UAT
    ${headers}=    Create Dictionary
    ...    Accept=*/*
    ...    Content-Type=application/x-www-form-urlencoded
    ...    Connection=keep-alive
    ${data}=    Create Dictionary
    ...    client_id=${NGCAMOLIUAT_CLIENT_ID}
    ...    client_secret=${NGCAMOLIUAT_CLIENT_SECRET}
    ...    grant_type=${GRANT_TYPE}
    Create Session    auth_session    ${AUTH_BASE_URL}    headers=${headers}    verify=true
    ${response}=    POST On Session    auth_session    ${ENDPOINT}    data=${data}
    Should Be Equal As Integers    ${response.status_code}    200
    ${json}=    Set Variable    ${response.json()}
    ${accessToken}=    Get Value From Json    ${json}    $.access_token
    ${accessToken}=    Catenate    Bearer    ${accessToken[0]}
    RETURN    ${accessToken}

Get Access Token NGPAY
    ${headers}=    Create Dictionary
    ...    Accept=*/*
    ...    Content-Type=application/x-www-form-urlencoded
    ...    Connection=keep-alive
    ${data}=    Create Dictionary
    ...    client_id=${NGPAY_CLIENT_ID}
    ...    client_secret=${NGPAY_CLIENT_SECRET}
    ...    grant_type=${GRANT_TYPE}
    Create Session    auth_session    ${AUTH_BASE_URL}    headers=${headers}    verify=true
    ${response}=    POST On Session    auth_session    ${ENDPOINT}    data=${data}
    Should Be Equal As Integers    ${response.status_code}    200
    ${json}=    Set Variable    ${response.json()}
    ${accessToken}=    Get Value From Json    ${json}    $.access_token
    ${accessToken}=    Catenate    Bearer    ${accessToken[0]}
    RETURN    ${accessToken}

# ----------------------------------------------------------------------------------------------------------------------------
# Handling Logic: eg :referenceId
# 'ANYVALUE' 					                → Do nothing (do not add referenceId to request)
# '' (empty string) 					        → Add "referenceId": ""
# Any other value except __NOT_PROVIDED__ 	    → Add "referenceId": <value>
# __NOT_PROVIDED__ or variable not set 		    → Auto-generate random uppercase string and add "referenceId": "<RANDOM>"
# ----------------------------------------------------------------------------------------------------------------------------

Post Campaign Offer Retrieve    #using body
    [Arguments]    ${accessToken}    ${phoneNo}=None    ${searchFilters}=None    ${sortBy}=None    ${channelId}=None    ${transactionId}=__NOT_PROVIDED__   ${keyword}=None    ${requestedStatistic}=None  
    ${headers}=    Create Dictionary    Content-Type=application/json    Authorization=${accessToken}
    ${query}=    Create Dictionary
    Run Keyword If    '${phoneNo}' not in ['None','__NOT_PROVIDED__']    Set To Dictionary    ${query}    msisdn=${phoneNo}
    Run Keyword If    ${searchFilters} not in [None,'__NOT_PROVIDED__']    Set To Dictionary    ${query}    searchFilters=${searchFilters}
    Run Keyword If    ${sortBy} not in [None,'__NOT_PROVIDED__']    Set To Dictionary    ${query}    sortBy=${sortBy}
    Run Keyword If    ${keyword} not in [None,'__NOT_PROVIDED__']    Set To Dictionary    ${query}    keyword=${keyword}
    Run Keyword If    ${requestedStatistic} not in [None,'__NOT_PROVIDED__']    Set To Dictionary    ${query}    requestedStatistic=${requestedStatistic}
    Run Keyword If    '${channelId}' not in ['None','__NOT_PROVIDED__']    Set To Dictionary    ${query}    channelId=${channelId}
    
    #transactionId handling
    IF    '${transactionId}' == 'ANYVALUE'
        No Operation
    ELSE IF    '${transactionId}' == ''
        Set To Dictionary    ${query}    transactionId=
    ELSE IF    '${transactionId}' != '__NOT_PROVIDED__'
        Set To Dictionary    ${query}    transactionId=${transactionId}
    ELSE
        ${transactionId}=    Generate Random String    5    [UPPER]
        Set To Dictionary    ${query}    transactionId=${transactionId}
    END

    # Send Request
    Create Session    campaignOfferRetrieve    ${MOLI_NBC_BASE_URL}    headers=${headers}    verify=true
    ${response}=    POST On Session    campaignOfferRetrieve    ${POST_OFFER_RETRIEVE}    json=${query}    expected_status=any
    ${status_code}=    Set Variable    ${response.status_code}
    #Store Response
    ${campaignOfferRetrieveResponse}=    Set Variable    ${response.json()}

    #Extract Amazon Trace ID (case-insensitive lookup)
    ${headers}=    Set Variable    ${response.headers}    
    ${traceId}=    Run Keyword If    'X-Amzn-Trace-Id' in ${headers}    Get From Dictionary    ${headers}    X-Amzn-Trace-Id    ELSE    Set Variable    NOT FOUND

    #Pretty Print request & response
    ${prettyRequest}=    Evaluate    json.dumps(${query}, indent=4, ensure_ascii=False)    json
    ${prettyResponse}=   Evaluate    json.dumps(${campaignOfferRetrieveResponse}, indent=4, ensure_ascii=False)    json

    #Print cURL
    ${json_string}=    Evaluate    json.dumps(${query}, indent=2)    json
    ${curl}=    Catenate
    ...    curl -X POST '${MOLI_BAU_BASE_URL}${POST_OFFER_RETRIEVE}'
    ...    -H 'Content-Type: application/json'
    ...    -H 'Authorization: ${accessToken}'
    ...    -d '${json_string}'

    Log To Console    \n==================================================
    Log To Console    \n📤 Request Body:
    Log To Console    ${prettyRequest}
    Log To Console    --------------------------------------------------
    Log To Console    \n📥 Response Body:
    Log To Console    ${prettyResponse}
    Log To Console    --------------------------------------------------
    Log To Console    \n📥 Status Code: ${status_code}
    Log To Console    --------------------------------------------------
    Log To Console    \n📤 Curl:
    Log To Console    ${curl}
    Log To Console    --------------------------------------------------
    Log To Console    \n📥 X-Amzn-Trace-Id: ${traceId}
    Log To Console    ==================================================\n

    RETURN    ${campaignOfferRetrieveResponse}    ${status_code}

Put Customer Check Blacklist    #using body
    [Arguments]    ${accessToken}    ${idNumber}=None    ${idType}=None    ${birthDate}=None    ${nationality}=None
    ${headers}=    Create Dictionary    Content-Type=application/json    Authorization=${accessToken}
    ${query}=    Create Dictionary
    Run Keyword If    '${idNumber}' not in ['None','__NOT_PROVIDED__']    Set To Dictionary    ${query}    idNumber=${idNumber}
    Run Keyword If    '${idType}' not in ['None','__NOT_PROVIDED__']    Set To Dictionary    ${query}    idType=${idType}
    Run Keyword If    '${birthDate}' not in ['None','__NOT_PROVIDED__']    Set To Dictionary    ${query}    birthDate=${birthDate}
    Run Keyword If    '${nationality}' not in ['None','__NOT_PROVIDED__']    Set To Dictionary    ${query}    nationality=${nationality}

    #Send Request
    Create Session    customerCheckBlacklist    ${MOLI_BAU_BASE_URL}    headers=${headers}    verify=true
    ${response}=    PUT On Session    customerCheckBlacklist    ${PUT_CHECK_BLACKLIST}    json=${query}    expected_status=any
    ${status_code}=    Set Variable    ${response.status_code}
    #Store Response
    ${customerCheckBlacklistResponse}=    Set Variable    ${response.json()}

    #Extract Amazon Trace ID (case-insensitive lookup)
    ${headers}=    Set Variable    ${response.headers}    
    ${traceId}=    Run Keyword If    'X-Amzn-Trace-Id' in ${headers}    Get From Dictionary    ${headers}    X-Amzn-Trace-Id    ELSE    Set Variable    NOT FOUND

    #Pretty Print request & response
    ${prettyRequest}=    Evaluate    json.dumps(${query}, indent=4, ensure_ascii=False)    json
    ${prettyResponse}=   Evaluate    json.dumps(${customerCheckBlacklistResponse}, indent=4, ensure_ascii=False)    json

    #Print cURL
    ${json_string}=    Evaluate    json.dumps(${query}, indent=2)    json
    ${curl}=    Catenate
    ...    curl -X POST '${MOLI_BAU_BASE_URL}${PUT_CHECK_BLACKLIST}'
    ...    -H 'Content-Type: application/json'
    ...    -H 'Authorization: ${accessToken}'
    ...    -d '${json_string}'

    Log To Console    \n==================================================
    Log To Console    \n📤 Request Body:
    Log To Console    ${prettyRequest}
    Log To Console    --------------------------------------------------
    Log To Console    \n📥 Response Body:
    Log To Console    ${prettyResponse}
    Log To Console    --------------------------------------------------
    Log To Console    \n📥 Status Code: ${status_code}
    Log To Console    --------------------------------------------------
    Log To Console    \n📤 Curl:
    Log To Console    ${curl}
    Log To Console    --------------------------------------------------
    Log To Console    \n📥 X-Amzn-Trace-Id: ${traceId}
    Log To Console    ==================================================\n

    RETURN    ${customerCheckBlacklistResponse}    ${status_code}

Post Device Check Eligibility    #using body
    [Arguments]    ${accessToken}    ${imei}=None    ${phoneNo}=None    ${idNumber}=None    ${idType}=None    ${purchaseDate}=None    ${deviceName}=None
    ${headers}=    Create Dictionary    Content-Type=application/json    Authorization=${accessToken}
    ${query}=    Create Dictionary
    Run Keyword If    '${imei}' not in ['None','__NOT_PROVIDED__']    Set To Dictionary    ${query}    imei=${imei}
    Run Keyword If    '${phoneNo}' not in ['None','__NOT_PROVIDED__']    Set To Dictionary    ${query}    msisdn=${phoneNo}
    Run Keyword If    '${idNumber}' not in ['None','__NOT_PROVIDED__']    Set To Dictionary    ${query}    idNumber=${idNumber}
    Run Keyword If    '${idType}' not in ['None','__NOT_PROVIDED__']    Set To Dictionary    ${query}    idType=${idType}
    Run Keyword If    '${purchaseDate}' not in ['None','__NOT_PROVIDED__']    Set To Dictionary    ${query}    purchaseDate=${purchaseDate}
    Run Keyword If    '${deviceName}' not in ['None','__NOT_PROVIDED__']    Set To Dictionary    ${query}    deviceName=${deviceName}

    #Send Request
    Create Session    deviceCheckEligibility    ${MOLI_BAU_BASE_URL}    headers=${headers}    verify=true
    ${response}=   POST On Session    deviceCheckEligibility    ${POST_CHECK_ELIGIBILITY}    json=${query}    expected_status=any
    ${status_code}=    Set Variable    ${response.status_code}
    #Store Response
    ${deviceCheckEligibilityResponse}=    Set Variable    ${response.json()}

    #Extract Amazon Trace ID (case-insensitive lookup)
    ${headers}=    Set Variable    ${response.headers}    
    ${traceId}=    Run Keyword If    'X-Amzn-Trace-Id' in ${headers}    Get From Dictionary    ${headers}    X-Amzn-Trace-Id    ELSE    Set Variable    NOT FOUND

    #Pretty Print request & response
    ${prettyRequest}=    Evaluate    json.dumps(${query}, indent=4, ensure_ascii=False)    json
    ${prettyResponse}=   Evaluate    json.dumps(${deviceCheckEligibilityResponse}, indent=4, ensure_ascii=False)    json

    #Print cURL
    ${json_string}=    Evaluate    json.dumps(${query}, indent=2)    json
    ${curl}=    Catenate
    ...    curl -X POST '${MOLI_BAU_BASE_URL}${POST_CHECK_ELIGIBILITY}'
    ...    -H 'Content-Type: application/json'
    ...    -H 'Authorization: ${accessToken}'
    ...    -d '${json_string}'

    Log To Console    \n==================================================
    Log To Console    \n📤 Request Body:
    Log To Console    ${prettyRequest}
    Log To Console    --------------------------------------------------
    Log To Console    \n📥 Response Body:
    Log To Console    ${prettyResponse}
    Log To Console    --------------------------------------------------
    Log To Console    \n📥 Status Code: ${status_code}
    Log To Console    --------------------------------------------------
    Log To Console    \n📤 Curl:
    Log To Console    ${curl}
    Log To Console    --------------------------------------------------
    Log To Console    \n📥 X-Amzn-Trace-Id: ${traceId}
    Log To Console    ==================================================\n

    RETURN    ${deviceCheckEligibilityResponse}    ${status_code}

Post Charge Direct Billing TLX    #using body
    [Arguments]    ${accessToken}    ${phoneNo}=None    ${channel}=None    ${payment}=None    ${metadata}=None    
    ${headers}=    Create Dictionary    Content-Type=application/json    Authorization=${accessToken}
    ${query}=    Create Dictionary
    Run Keyword If    '${phoneNo}' not in ['None','__NOT_PROVIDED__']    Set To Dictionary    ${query}    msisdn=${phoneNo}

    ${referenceCode}=    Create Dictionary
    IF    '${channel}' == 'ANYVALUE'
        No Operation
    ELSE IF    '${channel}' == ''
        Set To Dictionary    ${referenceCode}    channel=
    ELSE IF    '${channel}' != '__NOT_PROVIDED__' and '${channel}' != 'None'
        Set To Dictionary    ${referenceCode}    channel=${channel}
    ELSE
        ${channel}=    Generate Random String    12    [UPPER]
        Set To Dictionary    ${referenceCode}    channel=${channel}
    END

    Run Keyword If    len(${referenceCode}) > 0    Set To Dictionary    ${query}    referenceCode=${referenceCode}
    Run Keyword If    ${payment} not in [None,'__NOT_PROVIDED__']    Set To Dictionary    ${query}    payment=${payment}
    Run Keyword If    ${metadata} not in [None,'__NOT_PROVIDED__']    Set To Dictionary    ${query}    metadata=${metadata}

    #Send Request
    Create Session    chargeDirectBillingTLX    ${MOLI_BAU_BASE_URL}    headers=${headers}    verify=true
    ${response}=    POST On Session    chargeDirectBillingTLX    ${POST_CHARGE_DIRECT_BILLING_TLX}    json=${query}    expected_status=any
    ${status_code}=    Set Variable    ${response.status_code}
    #Store Response
    ${chargeDirectBillingTLXResponse}=    Set Variable    ${response.json()}

    #Extract Amazon Trace ID (case-insensitive lookup)
    ${headers}=    Set Variable    ${response.headers}    
    ${traceId}=    Run Keyword If    'X-Amzn-Trace-Id' in ${headers}    Get From Dictionary    ${headers}    X-Amzn-Trace-Id    ELSE    Set Variable    NOT FOUND

    #Pretty Print request & response
    ${prettyRequest}=    Evaluate    json.dumps(${query}, indent=4, ensure_ascii=False)    json
    ${prettyResponse}=   Evaluate    json.dumps(${chargeDirectBillingTLXResponse}, indent=4, ensure_ascii=False)    json

    #Print cURL
    ${json_string}=    Evaluate    json.dumps(${query}, indent=2)    json
    ${curl}=    Catenate
    ...    curl -X POST '${MOLI_BAU_BASE_URL}${POST_CHARGE_DIRECT_BILLING_TLX}'
    ...    -H 'Content-Type: application/json'
    ...    -H 'Authorization: ${accessToken}'
    ...    -d '${json_string}'

    Log To Console    \n==================================================
    Log To Console    \n📤 Request Body:
    Log To Console    ${prettyRequest}
    Log To Console    --------------------------------------------------
    Log To Console    \n📥 Response Body:
    Log To Console    ${prettyResponse}
    Log To Console    --------------------------------------------------
    Log To Console    \n📥 Status Code: ${status_code}
    Log To Console    --------------------------------------------------
    Log To Console    \n📤 Curl:
    Log To Console    ${curl}
    Log To Console    --------------------------------------------------
    Log To Console    \n📥 X-Amzn-Trace-Id: ${traceId}
    Log To Console    ==================================================\n

    RETURN    ${chargeDirectBillingTLXResponse}    ${status_code}    

Post Postpaid Bill Payment    #using body
    [Arguments]    ${accessToken}    ${telco}=    ${phoneNo}=None    ${accountNumber}=None    ${sourceChannel}=None    ${branchCode}=None    ${amount}=None    ${paymentMethod}=None    ${creditCardNumber}=None    ${operationType}=None    ${referenceId}=__NOT_PROVIDED__    ${sourceReferenceNumber}=__NOT_PROVIDED__
    ${headers}=    Create Dictionary    Content-Type=application/json    Authorization=${accessToken}
    ${query}=    Create Dictionary

    Run Keyword If    '${phoneNo}' not in ['None','__NOT_PROVIDED__']    Set To Dictionary    ${query}    msisdn=${phoneNo}
    Run Keyword If    '${accountNumber}' not in ['None','__NOT_PROVIDED__']    Set To Dictionary    ${query}    accountNumber=${accountNumber}
    Run Keyword If    '${sourceChannel}' not in ['None','__NOT_PROVIDED__']    Set To Dictionary    ${query}    sourceChannel=${sourceChannel}
    Run Keyword If    '${branchCode}' not in ['None','__NOT_PROVIDED__']    Set To Dictionary    ${query}    branchCode=${branchCode}
    Run Keyword If    '${amount}' not in ['None','__NOT_PROVIDED__']    Set To Dictionary    ${query}    amount=${amount}
    Run Keyword If    ${paymentMethod} not in [None,'__NOT_PROVIDED__']    Set To Dictionary    ${query}    paymentMethod=${paymentMethod}
    Run Keyword If    '${creditCardNumber}' not in ['None','__NOT_PROVIDED__']    Set To Dictionary    ${query}    creditCardNumber=${creditCardNumber}
    Run Keyword If    '${operationType}' not in ['None','__NOT_PROVIDED__']    Set To Dictionary    ${query}    operationType=${operationType}

    #referenceId handling
    IF    '${referenceId}' == 'ANYVALUE'
        No Operation
    ELSE IF    '${referenceId}' == ''
        Set To Dictionary    ${query}    referenceId=
    ELSE IF    '${referenceId}' != '__NOT_PROVIDED__'
        Set To Dictionary    ${query}    referenceId=${referenceId}
    ELSE
        ${referenceId}=    Generate Random String    12    [UPPER]
        Set To Dictionary    ${query}    referenceId=${referenceId}
    END
    #sourceReferenceNumber handling
    IF    '${sourceReferenceNumber}' == 'ANYVALUE'
        No Operation
    ELSE IF    '${sourceReferenceNumber}' == ''
        Set To Dictionary    ${query}    sourceReferenceNumber=
    ELSE IF    '${sourceReferenceNumber}' != '__NOT_PROVIDED__'
        Set To Dictionary    ${query}    sourceReferenceNumber=${sourceReferenceNumber}
    ELSE
        ${sourceReferenceNumber}=    Generate Random String    12    [UPPER]
        Set To Dictionary    ${query}    sourceReferenceNumber=${sourceReferenceNumber}
    END
    
    #Send Request
    Create Session    postpaidBillPayment    ${MOLI_BAU_BASE_URL}    headers=${headers}    verify=true
    ${response}=    POST On Session    postpaidBillPayment    ${POST_POSTPAID_BILL_PAYMENT}${telco}    json=${query}    expected_status=any
    ${status_code}=    Set Variable    ${response.status_code}
    #Store Response
    ${postpaidBillPaymentResponse}=    Set Variable    ${response.json()}

    #Extract Amazon Trace ID (case-insensitive lookup)
    ${headers}=    Set Variable    ${response.headers}    
    ${traceId}=    Run Keyword If    'X-Amzn-Trace-Id' in ${headers}    Get From Dictionary    ${headers}    X-Amzn-Trace-Id    ELSE    Set Variable    NOT FOUND

    #Pretty Print request & response
    ${prettyRequest}=    Evaluate    json.dumps(${query}, indent=4, ensure_ascii=False)    json
    ${prettyResponse}=   Evaluate    json.dumps(${postpaidBillPaymentResponse}, indent=4, ensure_ascii=False)    json

    #Print cURL
    ${json_string}=    Evaluate    json.dumps(${query}, indent=2)    json
    ${curl}=    Catenate
    ...    curl -X POST '${MOLI_BAU_BASE_URL}${POST_POSTPAID_BILL_PAYMENT}${telco}'
    ...    -H 'Content-Type: application/json'
    ...    -H 'Authorization: ${accessToken}'
    ...    -d '${json_string}'

    Log To Console    \n==================================================
    Log To Console    \n📤 Request Body:
    Log To Console    ${prettyRequest}
    Log To Console    --------------------------------------------------
    Log To Console    \n📥 Response Body:
    Log To Console    ${prettyResponse}
    Log To Console    --------------------------------------------------
    Log To Console    \n📥 Status Code: ${status_code}
    Log To Console    --------------------------------------------------
    Log To Console    \n📤 Curl:
    Log To Console    ${curl}
    Log To Console    --------------------------------------------------
    Log To Console    \n📥 X-Amzn-Trace-Id: ${traceId}
    Log To Console    ==================================================\n

    RETURN    ${postpaidBillPaymentResponse}    ${status_code}

Post Prepaid Pinless Reload    #using body
    [Arguments]    ${accessToken}    ${phoneNo}=None    ${paymentAmount}=None    ${paymentMethod}=None    ${sourceChannel}=None    ${referenceId}=__NOT_PROVIDED__
    ${headers}=    Create Dictionary    Content-Type=application/json    Authorization=${accessToken}
    ${query}=    Create Dictionary

    Run Keyword If    '${phoneNo}' not in ['None','__NOT_PROVIDED__']    Set To Dictionary    ${query}    msisdn=${phoneNo}
    Run Keyword If    '${paymentAmount}' not in ['None','__NOT_PROVIDED__']    Set To Dictionary    ${query}    paymentAmount=${paymentAmount}
    Run Keyword If    '${paymentMethod}' not in ['None','__NOT_PROVIDED__']    Set To Dictionary    ${query}    paymentMethod=${paymentMethod}
    Run Keyword If    '${sourceChannel}' not in ['None','__NOT_PROVIDED__']    Set To Dictionary    ${query}    sourceChannel=${sourceChannel}

    #referenceId handling
    IF    '${referenceId}' == 'ANYVALUE'
        No Operation
    ELSE IF    '${referenceId}' == ''
        Set To Dictionary    ${query}    referenceId=
    ELSE IF    '${referenceId}' != '__NOT_PROVIDED__'
        Set To Dictionary    ${query}    referenceId=${referenceId}
    ELSE
        ${referenceId}=    Generate Random String    12    [UPPER]
        Set To Dictionary    ${query}    referenceId=${referenceId}
    END

    #Send Request
    Create Session    PrepaidReload    ${MOLI_BAU_BASE_URL}    headers=${headers}    verify=true
    ${response}=    POST On Session    PrepaidReload    ${POST_PREPAID_PINLESS_RELOAD_PATH}   json=${query}    expected_status=any
    ${status_code}=    Set Variable    ${response.status_code}
    #Store Response
    ${prepaidReloadResponse}=    Set Variable    ${response.json()}

    #Extract Amazon Trace ID (case-insensitive lookup)
    ${headers}=    Set Variable    ${response.headers}    
    ${traceId}=    Run Keyword If    'X-Amzn-Trace-Id' in ${headers}    Get From Dictionary    ${headers}    X-Amzn-Trace-Id    ELSE    Set Variable    NOT FOUND

    #Pretty Print request & response
    ${prettyRequest}=    Evaluate    json.dumps(${query}, indent=4, ensure_ascii=False)    json
    ${prettyResponse}=   Evaluate    json.dumps(${prepaidReloadResponse}, indent=4, ensure_ascii=False)    json

    #Print cURL
    ${json_string}=    Evaluate    json.dumps(${query}, indent=2)    json
    ${curl}=    Catenate
    ...    curl -X POST '${MOLI_BAU_BASE_URL}${POST_PREPAID_PINLESS_RELOAD_PATH}'
    ...    -H 'Content-Type: application/json'
    ...    -H 'Authorization: ${accessToken}'
    ...    -d '${json_string}'

    Log To Console    \n==================================================
    Log To Console    \n📤 Request Body:
    Log To Console    ${prettyRequest}
    Log To Console    --------------------------------------------------
    Log To Console    \n📥 Response Body:
    Log To Console    ${prettyResponse}
    Log To Console    --------------------------------------------------
    Log To Console    \n📥 Status Code: ${status_code}
    Log To Console    --------------------------------------------------
    Log To Console    \n📤 Curl:
    Log To Console    ${curl}
    Log To Console    --------------------------------------------------
    Log To Console    \n📥 X-Amzn-Trace-Id: ${traceId}
    Log To Console    ==================================================\n

    RETURN    ${prepaidReloadResponse}    ${status_code}

Put Update Account    #using body
    [Arguments]    ${accessToken}    ${phoneNo}=None    ${telco}=None    ${dealer}=None    ${sourceChannel}=None    ${update}=None
    ${headers}=    Create Dictionary    Content-Type=application/json    Authorization=${accessToken}
    ${query}=    Create Dictionary

    Run Keyword If    '${phoneNo}' not in ['None','__NOT_PROVIDED__']    Set To Dictionary    ${query}    msisdn=${phoneNo}
    Run Keyword If    '${telco}' not in ['None','__NOT_PROVIDED__']    Set To Dictionary    ${query}    telco=${telco}
    Run Keyword If    ${dealer} not in [None,'__NOT_PROVIDED__']    Set To Dictionary    ${query}    dealer=${dealer}
    Run Keyword If    '${sourceChannel}' not in ['None','__NOT_PROVIDED__']    Set To Dictionary    ${query}    sourceChannel=${sourceChannel}
    Run Keyword If    ${update} not in [None,'__NOT_PROVIDED__']    Set To Dictionary    ${query}    update=${update}

    #Send Request
    Create Session    updateAccount    ${MOLI_BAU_BASE_URL}    headers=${headers}    verify=true
    ${response}=    PUT On Session    updateAccount    ${PUT_UPDATE_ACCOUNT}   json=${query}    expected_status=any
    ${status_code}=    Set Variable    ${response.status_code}
    #Store Response
    ${updateAccountResponse}=    Set Variable    ${response.json()}

    #Extract Amazon Trace ID (case-insensitive lookup)
    ${headers}=    Set Variable    ${response.headers}    
    ${traceId}=    Run Keyword If    'X-Amzn-Trace-Id' in ${headers}    Get From Dictionary    ${headers}    X-Amzn-Trace-Id    ELSE    Set Variable    NOT FOUND

    #Pretty Print request & response
    ${prettyRequest}=    Evaluate    json.dumps(${query}, indent=4, ensure_ascii=False)    json
    ${prettyResponse}=   Evaluate    json.dumps(${updateAccountResponse}, indent=4, ensure_ascii=False)    json

    #Print cURL
    ${json_string}=    Evaluate    json.dumps(${query}, indent=2)    json
    ${curl}=    Catenate
    ...    curl -X POST '${MOLI_BAU_BASE_URL}${PUT_UPDATE_ACCOUNT}'
    ...    -H 'Content-Type: application/json'
    ...    -H 'Authorization: ${accessToken}'
    ...    -d '${json_string}'

    Log To Console    \n==================================================
    Log To Console    \n📤 Request Body:
    Log To Console    ${prettyRequest}
    Log To Console    --------------------------------------------------
    Log To Console    \n📥 Response Body:
    Log To Console    ${prettyResponse}
    Log To Console    --------------------------------------------------
    Log To Console    \n📥 Status Code: ${status_code}
    Log To Console    --------------------------------------------------
    Log To Console    \n📤 Curl:
    Log To Console    ${curl}
    Log To Console    --------------------------------------------------
    Log To Console    \n📥 X-Amzn-Trace-Id: ${traceId}
    Log To Console    ==================================================\n

    RETURN    ${updateAccountResponse}    ${status_code}

Get Billing Info    #using path parameter
    [Arguments]    ${accessToken}    ${phoneNo}=None
    ${headers}=    Create Dictionary    Content-Type=application/json    Authorization=${accessToken}
    ${baseEndpoint}=    Set Variable    ${GET_BILLING_INFO}

    # Handle phoneNo placeholder (remove or replace)
    ${endpoint}=    Run Keyword If    '${phoneNo}' in ['None', '', '${EMPTY}']
    ...    Replace String    ${baseEndpoint}    /{phoneNo}    ${EMPTY}
    ...    ELSE    Replace String    ${baseEndpoint}    {phoneNo}    ${phoneNo}

    #Send Request
    Create Session    billingInfo    ${MOLI_BAU_BASE_URL}    headers=${headers}    verify=true
    ${response}=    GET On Session    billingInfo    ${endpoint}   expected_status=any
    ${status_code}=    Set Variable    ${response.status_code}
    #Store Response
    ${billingInfoResponse}=    Set Variable    ${response.json()}

    #Extract Amazon Trace ID (case-insensitive lookup)
    ${headers}=    Set Variable    ${response.headers}    
    ${traceId}=    Run Keyword If    'X-Amzn-Trace-Id' in ${headers}    Get From Dictionary    ${headers}    X-Amzn-Trace-Id    ELSE    Set Variable    NOT FOUND

    #Pretty Print request & response
    ${prettyRequest}=    Set Variable    ${MOLI_BAU_BASE_URL}${endpoint}
    ${prettyResponse}=   Evaluate    json.dumps(${billingInfoResponse}, indent=4, ensure_ascii=False)    json

    #Print cURL
    ${curl}=    Catenate
    ...    curl -X POST '${MOLI_BAU_BASE_URL}${endpoint}'
    ...    -H 'Content-Type: application/json'
    ...    -H 'Authorization: ${accessToken}'

    Log To Console    \n==================================================
    Log To Console    \n📤 Request Body:
    Log To Console    ${prettyRequest}
    Log To Console    --------------------------------------------------
    Log To Console    \n📥 Response Body:
    Log To Console    ${prettyResponse}
    Log To Console    --------------------------------------------------
    Log To Console    \n📥 Status Code: ${status_code}
    Log To Console    --------------------------------------------------
    Log To Console    \n📤 Curl:
    Log To Console    ${curl}
    Log To Console    --------------------------------------------------
    Log To Console    \n📥 X-Amzn-Trace-Id: ${traceId}
    Log To Console    ==================================================\n

    RETURN    ${billingInfoResponse}    ${status_code}

Measure Billing Info Latency
    [Arguments]    ${accessToken}    ${phoneNo}
    ${headers}=    Create Dictionary    Content-Type=application/json    Authorization=${accessToken}
    ${baseEndpoint}=    Set Variable    ${GET_BILLING_INFO}

    # Handle phoneNo placeholder (remove or replace)
    ${endpoint}=    Run Keyword If    '${phoneNo}' in ['None', '', '${EMPTY}']
    ...    Replace String    ${baseEndpoint}    /{phoneNo}    ${EMPTY}
    ...    ELSE    Replace String    ${baseEndpoint}    {phoneNo}    ${phoneNo}

    #Send Request
    Create Session    accountStructure    ${MOLI_BAU_BASE_URL}    headers=${headers}    verify=true
    ${response}=    GET On Session    accountStructure    ${endpoint}   expected_status=any
    ${status_code}=    Set Variable    ${response.status_code}
    #Store Response
    ${billingInfoResponse}=    Set Variable    ${response.json()}

    #Extract Amazon Trace ID (case-insensitive lookup)
    ${headers}=    Set Variable    ${response.headers}    
    ${traceId}=    Run Keyword If    'X-Amzn-Trace-Id' in ${headers}    Get From Dictionary    ${headers}    X-Amzn-Trace-Id    ELSE    Set Variable    NOT FOUND

    # Convert latency from seconds to milliseconds
    ${latency}=    Evaluate    (${response.elapsed.total_seconds()} * 1000)

    RETURN    ${latency}    ${traceId}

Get Account Structure    #using query and path parameter
    [Arguments]    ${accessToken}    ${phoneNo}=None    ${level}=None
    ${headers}=    Create Dictionary    Content-Type=application/json    Authorization=${accessToken}
    ${baseEndpoint}=    Set Variable    ${GET_ACCOUNT_STRUCTURE}

    # Handle phoneNo placeholder (remove or replace)
    ${endpoint}=    Run Keyword If    '${phoneNo}' in ['None', '', '${EMPTY}']
    ...    Replace String    ${baseEndpoint}    /{phoneNo}    ${EMPTY}
    ...    ELSE    Replace String    ${baseEndpoint}    {phoneNo}    ${phoneNo}

    # Handle level query (append only if not empty)
    ${endpoint}=    Run Keyword If    '${level}' not in ['None', '', '${EMPTY}']
    ...    Catenate    SEPARATOR=    ${endpoint}?level=${level}
    ...    ELSE    Set Variable    ${endpoint}

    #Send Request
    Create Session    accountStructure    ${MOLI_BAU_BASE_URL}    headers=${headers}    verify=true
    ${response}=    GET On Session    accountStructure    ${endpoint}   expected_status=any
    ${status_code}=    Set Variable    ${response.status_code}
    #Store Response
    ${accountStructureResponse}=    Set Variable    ${response.json()}

    #Extract Amazon Trace ID (case-insensitive lookup)
    ${headers}=    Set Variable    ${response.headers}    
    ${traceId}=    Run Keyword If    'X-Amzn-Trace-Id' in ${headers}    Get From Dictionary    ${headers}    X-Amzn-Trace-Id    ELSE    Set Variable    NOT FOUND

    #Pretty Print request & response
    ${prettyRequest}=    Set Variable    ${MOLI_BAU_BASE_URL}${endpoint}
    ${prettyResponse}=   Evaluate    json.dumps(${accountStructureResponse}, indent=4, ensure_ascii=False)    json

    #Print cURL
    ${curl}=    Catenate
    ...    curl -X POST '${MOLI_BAU_BASE_URL}${endpoint}'
    ...    -H 'Content-Type: application/json'
    ...    -H 'Authorization: ${accessToken}'

    Log To Console    \n==================================================
    Log To Console    \n📤 Request Body:
    Log To Console    ${prettyRequest}
    Log To Console    --------------------------------------------------
    Log To Console    \n📥 Response Body:
    Log To Console    ${prettyResponse}
    Log To Console    --------------------------------------------------
    Log To Console    \n📥 Status Code: ${status_code}
    Log To Console    --------------------------------------------------
    Log To Console    \n📤 Curl:
    Log To Console    ${curl}
    Log To Console    --------------------------------------------------
    Log To Console    \n📥 X-Amzn-Trace-Id: ${traceId}
    Log To Console    ==================================================\n

    RETURN    ${accountStructureResponse}    ${status_code}

Post Addon Campaign Provisioning Request
    [Arguments]    ${accessToken}    ${action}=None    ${phoneNo}=None    ${offeringId}=None    ${source}=None    ${adjustmentCode}=None    ${attributeList}=None    ${endDate}=None    ${serviceName}=None    ${startDate}=None    ${transactionId}=__NOT_PROVIDED__
    ${headers}=    Create Dictionary    Content-Type=application/json    Authorization=${accessToken}
    ${query}=    Create Dictionary
    Run Keyword If    '${action}' not in ['None','__NOT_PROVIDED__']    Set To Dictionary    ${query}    action=${action}
    Run Keyword If    '${phoneNo}' not in ['None','__NOT_PROVIDED__']    Set To Dictionary    ${query}    msisdn=${phoneNo}
    Run Keyword If    '${offeringId}' not in ['None','__NOT_PROVIDED__']    Set To Dictionary    ${query}    offeringId=${offeringId}
    Run Keyword If    '${source}' not in ['None','__NOT_PROVIDED__']    Set To Dictionary    ${query}    source=${source}
    Run Keyword If    '${adjustmentCode}' not in ['None','__NOT_PROVIDED__']    Set To Dictionary    ${query}    adjustmentCode=${adjustmentCode}
    Run Keyword If    ${attributeList} not in [None,'__NOT_PROVIDED__']    Set To Dictionary    ${query}    attributeList=${attributeList}
    Run Keyword If    '${endDate}' not in ['None','__NOT_PROVIDED__']    Set To Dictionary    ${query}    endDate=${endDate}
    Run Keyword If    '${serviceName}' not in ['None','__NOT_PROVIDED__']    Set To Dictionary    ${query}    serviceName=${serviceName}
    Run Keyword If    '${startDate}' not in ['None','__NOT_PROVIDED__']    Set To Dictionary    ${query}    startDate=${startDate}
    
    #transactionId handling
    IF    '${transactionId}' == 'ANYVALUE'
        No Operation
    ELSE IF    '${transactionId}' == ''
        Set To Dictionary    ${query}    transactionId=
    ELSE IF    '${transactionId}' != '__NOT_PROVIDED__'
        Set To Dictionary    ${query}    transactionId=${transactionId}
    ELSE
        ${transactionId}=    Generate Random String    5    [UPPER]
        Set To Dictionary    ${query}    transactionId=${transactionId}
    END

    # Send Request
    Create Session    addOnCampaignProvisioningRequest    ${MOLI_NBC_BASE_URL}    headers=${headers}    verify=true
    ${response}=    POST On Session    addOnCampaignProvisioningRequest    ${POST_ADDON_CAMPAIGN_PROVISION}    json=${query}    expected_status=any
    ${status_code}=    Set Variable    ${response.status_code}
    #Store Response
    ${addOnCampaignProvisioningRequestResponse}=    Set Variable    ${response.json()}

    #Extract Amazon Trace ID (case-insensitive lookup)
    ${headers}=    Set Variable    ${response.headers}    
    ${traceId}=    Run Keyword If    'X-Amzn-Trace-Id' in ${headers}    Get From Dictionary    ${headers}    X-Amzn-Trace-Id    ELSE    Set Variable    NOT FOUND

    #Pretty Print request & response
    ${prettyRequest}=    Evaluate    json.dumps(${query}, indent=4, ensure_ascii=False)    json
    ${prettyResponse}=   Evaluate    json.dumps(${addOnCampaignProvisioningRequestResponse}, indent=4, ensure_ascii=False)    json

    #Print cURL
    ${json_string}=    Evaluate    json.dumps(${query}, indent=2)    json
    ${curl}=    Catenate
    ...    curl -X POST '${MOLI_BAU_BASE_URL}${POST_ADDON_CAMPAIGN_PROVISION}'
    ...    -H 'Content-Type: application/json'
    ...    -H 'Authorization: ${accessToken}'
    ...    -d '${json_string}'

    Log To Console    \n==================================================
    Log To Console    \n📤 Request Body:
    Log To Console    ${prettyRequest}
    Log To Console    --------------------------------------------------
    Log To Console    \n📥 Response Body:
    Log To Console    ${prettyResponse}
    Log To Console    --------------------------------------------------
    Log To Console    \n📥 Status Code: ${status_code}
    Log To Console    --------------------------------------------------
    Log To Console    \n📤 Curl:
    Log To Console    ${curl}
    Log To Console    --------------------------------------------------
    Log To Console    \n📥 X-Amzn-Trace-Id: ${traceId}
    Log To Console    ==================================================\n

    RETURN    ${addOnCampaignProvisioningRequestResponse}    ${status_code}
