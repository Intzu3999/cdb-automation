*** Settings ***

Library    RequestsLibrary
Library    JSONLibrary
Library    String

*** Variables ***

${CLIENT_ID}    190sth074afcel3hm124hi2r7m    #2pc38sgrhiggaqdoumujp0h2l1
${CLIENT_SECRET}    qv48sl9afi1jc6dt0cmf2r264pjkjq4l85tq86mcm4c6cm83v4l    #9dn661gdr1rijvb8jvn1cjo5rle3scosm6vgvjqadpcmb95ll66
${GRANT_TYPE}    client_credentials
${ENDPOINT}    /token
${ACCESS_TOKEN} 

${BASE_URL}    https://moli-staging.auth.ap-southeast-1.amazoncognito.com
${MOLI_BAU_BASE_URL}    https://d1dvzfm7v42b0o.cloudfront.net
${GET_DEVICE_PROFILE}    /moli-resources-ms/v1.0/resources/device-profile?
${PUT_V2_SUBSCRIBER_UNBAR}    /moli-subscriber/v2/subscriber/unbar
${GET_V2_ADDON_ELIGIBLE_LIST}    /moli-tlx2/v2.0/addon/eligible-list?
${PUT_V2_BUNDLE_SUBSCRIBE}    /moli-tlx/v2/bundles/subscribe
${GET_V4_CUSTOMER_CONTRACT}    /moli-customer/v4/customer/contracts?
${GET_V1_UNBILLED}    /moli-invoice/v1/billing/unbilled?


${CLIENT_ID2}    2k8oeiidp7k5mf0d23qghcvllt
${CLIENT_SECRET2}    mov5gj4jaif90s1e91el1m6e0q7lltlo14e7chvqebc28bfjl72    

${CLIENT_ID3}    2qc9rrddug63k8g3rg08vlvb0u
${CLIENT_SECRET3}    q747kr5um9ca167rtgpk81ve36hrl299uugs02o9h1qd4c0rc5t
*** Keywords ***

Log Pretty Json
    [Arguments]    ${data}    ${label}=Response
    ${json_string}=    Evaluate    json.dumps(${data}, indent=4)    json
    Log To Console    \n================ ${label} =================
    Log To Console    ${json_string}
    Log To Console    ===========================================


Get Access Token
    ${headers}=    Create Dictionary
    ...    Accept=*/*
    ...    Content-Type=application/x-www-form-urlencoded
    ...    Host=moli-staging.auth.ap-southeast-1.amazoncognito.com
    ...    Connection=keep-alive
    ...    Cookie=XSRF-TOKEN=e061565a-d902-4110-adc6-aaabee5ff19b; XSRF-TOKEN=f98cb3ae-600f-4f05-87f2-12da82b9e864; XSRF-TOKEN=608da1db-e108-4861-8361-3fb7891e0d61
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
    RETURN    ${ACCESS_TOKEN}


Generate Access Token Using Encoded Client
    ${encoded_client}    Evaluate    base64.b64encode(b"${CLIENT_ID2}:${CLIENT_SECRET2}")
    ${headers}=    Create Dictionary
    ...    Accept=*/* 
    ...    Authorization=Basic ${encoded_client}
    ...    Content-Type=application/x-www-form-urlencoded
    ${formdata}=    Create Dictionary    grant_type=client_credentials
    Create Session    AUTH    ${MOLI_BAU_BASE_URL}    verify=true    disable_warnings=1
    ${response}=    POST On Session    AUTH    /moli-cognito/oauth2/token    data=${formdata}    headers=${headers}
    Log    Status code: ${response.status_code}
    Log    Response body: ${response.content}
    ${json}=    Set Variable    ${response.json()}
    ${tokenJson}=    Get Value From Json    ${json}    $.access_token
    ${ACCESS_TOKEN}=    Catenate    Bearer    ${response.json()}[access_token]
    RETURN    ${ACCESS_TOKEN}


Get Access Token NGCA
    ${headers}=    Create Dictionary
    ...    Accept=*/*
    ...    Content-Type=application/x-www-form-urlencoded
    ...    Host=moli-staging.auth.ap-southeast-1.amazoncognito.com
    ...    Connection=keep-alive
    ...    Cookie=XSRF-TOKEN=e061565a-d902-4110-adc6-aaabee5ff19b; XSRF-TOKEN=f98cb3ae-600f-4f05-87f2-12da82b9e864; XSRF-TOKEN=608da1db-e108-4861-8361-3fb7891e0d61
    ${data}=    Create Dictionary
    ...    client_id=${CLIENT_ID3}
    ...    client_secret=${CLIENT_SECRET3}
    ...    grant_type=${GRANT_TYPE}
    Create Session    auth_session    ${BASE_URL}    headers=${headers}    verify=true
    ${response}=    POST On Session    auth_session    ${ENDPOINT}    data=${data}
    Should Be Equal As Integers    ${response.status_code}    200
    ${json}=    Set Variable    ${response.json()}
    ${tokenJson}=    Get Value From Json    ${json}    $.access_token
    ${ACCESS_TOKEN}=    Catenate    Bearer    ${response.json()}[access_token]
    RETURN    ${ACCESS_TOKEN}


Get Device Profile
    [Arguments]    ${ACCESS_TOKEN}    ${DEVICE_PROFILE_SYSTEM_ROUTE}    ${DEVICE_PROFILE_MSISDN}    ${DEVICE_PROFILE_IMEI}
    ${headers}=    Create Dictionary
    ...    Accept=*/*
    ...    Authorization=${ACCESS_TOKEN}
    ${endpoint}=    Set Variable    ${GET_DEVICE_PROFILE}systemRoute=${DEVICE_PROFILE_SYSTEM_ROUTE}&msisdn=${DEVICE_PROFILE_MSISDN}&imei=${DEVICE_PROFILE_IMEI}

    Log To Console    \n[GET] ${endpoint}

    Create Session    getDeviceProfile    ${MOLI_BAU_BASE_URL}    headers=${headers}    verify=true
    ${response}=    GET On Session    getDeviceProfile    ${endpoint}
    Should Be Equal As Numbers    ${response.status_code}    200
    ${json}=    Set Variable    ${response.json()}

    Log Pretty Json    ${json}    Response


Put Unbar Subscriber V2
    [Arguments]    ${ACCESS_TOKEN}    ${UNBAR_SUBSCRIBER_MSISDN}    ${UNBAR_SUBSCRIBER_SOURCE_CHANNEL}    ${UNBAR_SUBSCRIBER_TYPE}    ${UNBAR_SUBSCRIBER_REASON}
    ${headers}=    Create Dictionary
    ...    Accept=*/*
    ...    Authorization=${ACCESS_TOKEN}
    ${request}=    Create Dictionary
    ...    msisdn=${UNBAR_SUBSCRIBER_MSISDN}
    ...    sourceChannel=${UNBAR_SUBSCRIBER_SOURCE_CHANNEL}
    ...    type=${UNBAR_SUBSCRIBER_TYPE}
    ...    reason=${UNBAR_SUBSCRIBER_REASON}

    Log Pretty Json    ${request}    Request

    Create Session    putUnbarSubscriberV2    ${MOLI_BAU_BASE_URL}    headers=${headers}    verify=true
    ${response}=    PUT On Session    putUnbarSubscriberV2    ${PUT_V2_SUBSCRIBER_UNBAR}    json=${request}
    Should Be Equal As Numbers    ${response.status_code}    200
    ${json}=    Set Variable    ${response.json()}

    Log Pretty Json    ${json}    Response


Get TLX Addon Eligible List V2
    [Arguments]    ${ACCESS_TOKEN}    ${ADDON_ELIGIBLE_LIST_MSISDN}    ${ADDON_ELIGIBLE_LIST_TELCO}
    ${headers}=    Create Dictionary
    ...    Accept=*/*
    ...    Authorization=${ACCESS_TOKEN}
    ${endpoint}=    Set Variable    ${GET_V2_ADDON_ELIGIBLE_LIST}msisdn=${ADDON_ELIGIBLE_LIST_MSISDN}&telco=${ADDON_ELIGIBLE_LIST_TELCO}

    Log To Console    \n[GET] ${endpoint}

    Create Session    getAddonEligibleListV2    ${MOLI_BAU_BASE_URL}    headers=${headers}    verify=true
    ${response}=    GET On Session    getAddonEligibleListV2    ${endpoint}
    Should Be Equal As Numbers    ${response.status_code}    200
    ${json}=    Set Variable    ${response.json()}

    Log Pretty Json    ${json}    Response


Put TLX Bundle Subscribe V2
    [Arguments]    ${ACCESS_TOKEN}    ${BUNDLE_SUBSCRIBE_MSISDN}    ${BUNDLE_SUBSCRIBE_TELCO}    ${BUNDLE_SUBSCRIBE_BUNDLEID}    ${BUNDLE_SUBSCRIBE_DEALERCODE}    ${BUNDLE_SUBSCRIBE_IMEI}    ${BUNDLE_SUBSCRIBE_REFERENCENUMBER}    ${BUNDLE_SUBSCRIBE_CALLBACKURL}    ${EXPECTED_CODE}    ${EXPECTED_DESCRIPTION}    ${EXPECTED_REASON}
    ${headers}=    Create Dictionary
    ...    Accept=*/*
    ...    Authorization=${ACCESS_TOKEN}
    ${request}=    Create Dictionary
    ...    msisdn=${BUNDLE_SUBSCRIBE_MSISDN}
    ...    telco=${BUNDLE_SUBSCRIBE_TELCO}
    ...    bundleId=${BUNDLE_SUBSCRIBE_BUNDLEID}
    ...    dealerCode=${BUNDLE_SUBSCRIBE_DEALERCODE}
    ...    imei=${BUNDLE_SUBSCRIBE_IMEI}
    ...    referenceNumber=${BUNDLE_SUBSCRIBE_REFERENCENUMBER}
    ...    callbackURL=${BUNDLE_SUBSCRIBE_CALLBACKURL}

    Log Pretty Json    ${request}    Request

    Create Session    putBundleSubscribeV2    ${MOLI_BAU_BASE_URL}    headers=${headers}    verify=true
    ${response}=    PUT On Session    putBundleSubscribeV2    ${PUT_V2_BUNDLE_SUBSCRIBE}    json=${request}    expected_status=400
    Should Be Equal As Numbers    ${response.status_code}    400
    ${json}=    Set Variable    ${response.json()}

    Log Pretty Json    ${json}    Response

    ${actual_code}=         Get Value From Json    ${json}    $.source.code
    ${actual_description}=  Get Value From Json    ${json}    $.source.description
    ${actual_reason}=       Get Value From Json    ${json}    $.source.reason
    Should Be Equal As Numbers    ${actual_code[0]}         ${EXPECTED_CODE}
    Should Be Equal As Strings    ${actual_description[0]}  ${EXPECTED_DESCRIPTION}
    Should Be Equal As Strings    ${actual_reason[0]}       ${EXPECTED_REASON}


Get Customer Contract V4
    [Arguments]    ${ACCESS_TOKEN}    ${CUSTOMER_CONTRACT_MSISDN}    ${CUSTOMER_CONTRACT_TELCO}
    ${headers}=    Create Dictionary
    ...    Accept=*/*
    ...    Authorization=${ACCESS_TOKEN}
    ${endpoint}=    Set Variable    ${GET_V4_CUSTOMER_CONTRACT}msisdn=${CUSTOMER_CONTRACT_MSISDN}&telco=${CUSTOMER_CONTRACT_TELCO}

    Log To Console    \n[GET] ${endpoint}

    Create Session    getCustomerContractV4    ${MOLI_BAU_BASE_URL}    headers=${headers}    verify=true
    ${response}=    GET On Session    getCustomerContractV4    ${endpoint}
    Should Be Equal As Numbers    ${response.status_code}    200
    ${json}=    Set Variable    ${response.json()}

    Log Pretty Json    ${json}    Response


Get Unbilled Transactions V1
    [Arguments]    ${ACCESS_TOKEN}    ${UNBILLED_MSISDN}    ${UNBILLED_TELCO}
    ${headers}=    Create Dictionary
    ...    Accept=*/*
    ...    Authorization=${ACCESS_TOKEN}
    ${endpoint}=    Set Variable    ${GET_V1_UNBILLED}msisdn=${UNBILLED_MSISDN}&telco=${UNBILLED_TELCO}

    Log To Console    \n[GET] ${endpoint}

    Create Session    getUnbilledTransactionV1    ${MOLI_BAU_BASE_URL}    headers=${headers}    verify=true
    ${response}=    GET On Session    getUnbilledTransactionV1    ${endpoint}
    Should Be Equal As Numbers    ${response.status_code}    200
    ${json}=    Set Variable    ${response.json()}

    Log Pretty Json    ${json}    Response

*** Test Cases ***

✔ Ticket MOLI-1805: API [resources-ms/retrieve-device-profile] new service api
    [Documentation]    [MOLI and APIGW] P1 - Device details and IMEI
    ${ACCESS_TOKEN}    Get Access Token
    Get Device Profile    ${ACCESS_TOKEN}    MDM    60109238110    352401014041521     # Digi
    Get Device Profile    ${ACCESS_TOKEN}    ADMS    60133994940    35577791387471    # Celcom

✔ Ticket MOLI-1807: [subscriber/unbar-subscriber-v2] new service api
    [Documentation]   [MOLI] - NGCA Promise to Pay
    ${ACCESS_TOKEN}    Get Access Token
    Put Unbar Subscriber V2    ${ACCESS_TOKEN}    60198456609    MOLI-TEST    RESUME    54    #Celcom

✔ Ticket MOLI-1970: [moli-tlx/list-eligible-offers-v2] new service api
    [Documentation]   [MOLI] Eligible AddOn for Millom/ APIGW
    ${ACCESS_TOKEN}    Generate Access Token Using Encoded Client
    Get TLX Addon Eligible List V2    ${ACCESS_TOKEN}   601016037480    CELCOMDIGI    # Always CelcomDigi

✔ Ticket MOLI-1809: [gateway-tlx] forward all error details 
    [Documentation]   [MOLI] FAAS Error Enhancement
    ${ACCESS_TOKEN}    Get Access Token
    Put TLX Bundle Subscribe V2    ${ACCESS_TOKEN}    60102000511    DIGI    11d211ef-f2cd-4d40-9013-7baabe000000    dealer23A    350123451234560    39695a2d-72a2-49ed-9d77-5512459c5671    https://callmebackwhen.ready    400    Request failed with status code 400    Bundle is currently disabled and cannot be activated.    # #Digi : Prepaid No Balance
    Put TLX Bundle Subscribe V2    ${ACCESS_TOKEN}    60198456609    CELCOM    11d211ef-f2cd-4d40-9013-7baabe000000    dealer23A    350123451234560    39695a2d-72a2-49ed-9d77-5512459c5671    https://callmebackwhen.ready    400    Request failed with status code 400    Bundle is currently disabled and cannot be activated.        # #Celcom : Prepaid No Balance

✔ Ticket MOLI-1868: [customer/get-contract-v4] new service api
    [Documentation]   [MOLI] NGSA Get Device List​ 
    ${ACCESS_TOKEN}    Get Access Token
    Get Customer Contract V4    ${ACCESS_TOKEN}        60104364654    DIGI    #Digi
    Get Customer Contract V4    ${ACCESS_TOKEN}        60133994940    CELCOM  #Celcom

✔ Ticket MOLI-1810: [invoice/get-unbilled-transactions] new service api (celcom)
    [Documentation]   [MOLI] NGCA View Unbilled Transaction​
    ${ACCESS_TOKEN}    Get Access Token NGCA
    Get Unbilled Transactions V1    ${ACCESS_TOKEN}    601114904228    CELCOM    #Celcom


# Other Tickets/Issues
# ✔    Ticket MOLI-1808: [network/get-network-v2] new service api | [MOLI] - Alternative Telco Verification - Tested by Nash    
# ✘    Ticket MOLI-1806: [moli-daisy] decouple from moli | [MOLI][Daisy] - Bug Fixes by Decoupling Daisy from Moli
# ✘    [MOLI] CMP API Enhancement
# ✘    NGCA Prod Issue: Freedom Addon
# ✘    Ticket MOLI-1988: [tlx/subscribe-bundle-v2] new parameters requestId  for TLX Bundle Subscribe | MOLI] Enabling SwapAsia for Phone Care on NGOS - Blocked due to TLX pending to deployed changes
# ✘    Ticket MOLI-1812: [addon/change-addon] handle LifestylePurchase addon category | [MOLI] NGPC LifestylePurchase​ - Blocked due to XC Cisco NGCA and Cisco umbrella issue
