*** Settings ***
Documentation    This file only share Addon keywords only

Resource    ../MOLI-testSettings.robot

*** Keywords ***

Check And Subscribe-Unsubscribe Addon Prepaid Digi
    [Arguments]    ${accessToken}    ${phoneNo}    ${offers}
    ${found}=    Set Variable    ${False}
    FOR    ${offer}    IN    @{offers}
        ${serviceName}=    Get From Dictionary    ${offer}    serviceName
        Exit For Loop If    '${serviceName}' == '90010868'
    END
    # After the loop, serviceName holds last iterated value only; compute found via a second pass or status keyword
    ${found}=    Run Keyword And Return Status    Evaluate    any(o.get('serviceName')=='90010868' for o in $offers)
    Log    Found status: ${found}
    Run Keyword If    ${found}
    ...    Manage Unsubscribe-Subscribe Digi     ${accessToken}    ${phoneNo}
    ...    ELSE
    ...    Manage Subscribe-Unsubscribe Digi      ${accessToken}    ${phoneNo}

Manage Unsubscribe-Subscribe Digi
    [Arguments]    ${accessToken}    ${phoneNo}
    Unsubscribe Addon Prepaid Digi    ${accessToken}    ${phoneNo}
    Sleep    30s
    Subscribe Addon Prepaid Digi    ${accessToken}    ${phoneNo}

Manage Subscribe-Unsubscribe-Digi
    [Arguments]    ${accessToken}    ${phoneNo}
    Subscribe Addon Prepaid Digi    ${accessToken}    ${phoneNo}
    Sleep    30s
    Unsubscribe Addon Prepaid Digi    ${accessToken}    ${phoneNo}

Subscribe Addon Prepaid Digi
    [Arguments]    ${accessToken}    ${phoneNo}
    ${headers}=    Create Dictionary    Content-Type=application/json    Authorization=${accessToken}
    &{product}=    Create Dictionary    productId=90010868    productName=5G39-55GB_UL Internet-12mbps_3GB HS_Unltd Calls-AutoRenew
    @{products}=   Create List    ${product}
    &{subscribe}=  Create Dictionary    products=${products}
    ${query}=    Create Dictionary
    ...    msisdn=${phoneNo}
    ...    payType=PREPAID
    ...    subscribe=${subscribe}
    #Sent Request
    Create Session    subscribeAddOn   ${BAU_MOLI2_BASE_URL}    headers=${headers}    verify=true
    ${response}=    PUT On Session    subscribeAddOn    ${PUT_ADDON_CHANGE_PATH}    json=${query}
    Should Be Equal As Numbers    ${response.status_code}    200
    # Store Response
    ${json}=    Set Variable    ${response.json()}
    Log    Subscribed: ${json}

Unsubscribe Addon Prepaid Digi
    [Arguments]    ${accessToken}    ${phoneNo}
    ${headers}=    Create Dictionary    Content-Type=application/json    Authorization=${accessToken}
    &{product}=    Create Dictionary    productId=90010868    productName=5G39-55GB_UL Internet-12mbps_3GB HS_Unltd Calls-AutoRenew
    @{products}=   Create List    ${product}
    &{unsubscribe}=  Create Dictionary    products=${products}
    ${query}=    Create Dictionary
    ...    msisdn=${phoneNo}
    ...    payType=PREPAID
    ...    unsubscribe=${unsubscribe}
    #Sent Request
    Create Session    unSubscribeAddOn   ${BAU_MOLI2_BASE_URL}    headers=${headers}    verify=true
    ${response}=    PUT On Session    unSubscribeAddOn    ${PUT_ADDON_CHANGE_PATH}    json=${query}
    Should Be Equal As Numbers    ${response.status_code}    200
    # Store Response
    ${json}=    Set Variable    ${response.json()}
    Log    Unsubscribed: ${json}


Check And Subscribe-Unsubscribe Addon Prepaid Celcom
    [Arguments]    ${accessToken}    ${phoneNo}    ${offers}
    ${found}=    Set Variable    ${False}
    FOR    ${offer}    IN    @{offers}
        ${serviceName}=    Get From Dictionary    ${offer}    serviceName
        Exit For Loop If    '${serviceName}' == '90010868'
    END
    # After the loop, serviceName holds last iterated value only; compute found via a second pass or status keyword
    ${found}=    Run Keyword And Return Status    Evaluate    any(o.get('serviceName')=='90010868' for o in $offers)
    Log    Found status: ${found}
    Run Keyword If    ${found}
    ...    Manage Unsubscribe-Subscribe Celcom     ${accessToken}    ${phoneNo}
    ...    ELSE
    ...    Manage Subscribe-Unsubscribe Celcom      ${accessToken}    ${phoneNo}

Manage Unsubscribe-Subscribe Celcom
    [Arguments]    ${accessToken}    ${phoneNo}
    Unsubscribe Addon Prepaid Celcom    ${accessToken}    ${phoneNo}
    Sleep    30s
    Subscribe Addon Prepaid Celcom    ${accessToken}    ${phoneNo}

Manage Subscribe-Unsubscribe Celcom
    [Arguments]    ${accessToken}    ${phoneNo}
    Subscribe Addon Prepaid Celcom   ${accessToken}    ${phoneNo}
    Sleep    30s
    Unsubscribe Addon Prepaid Celcom   ${accessToken}    ${phoneNo}

Subscribe Addon Prepaid Celcom
    [Arguments]    ${accessToken}    ${phoneNo}
    ${headers}=    Create Dictionary    Content-Type=application/json    Authorization=${accessToken}
    &{product}=    Create Dictionary    productId=90010868    productName=5G39-55GB_UL Internet-12mbps_3GB HS_Unltd Calls-AutoRenew
    @{products}=   Create List    ${product}
    &{subscribe}=  Create Dictionary    products=${products}
    ${query}=    Create Dictionary
    ...    msisdn=${phoneNo}
    ...    payType=PREPAID
    ...    subscribe=${subscribe}
    #Sent Request
    Create Session    subscribeAddOn   ${BAU_MOLI2_BASE_URL}    headers=${headers}    verify=true
    ${response}=    PUT On Session    subscribeAddOn    ${PUT_ADDON_CHANGE_PATH}    json=${query}
    Should Be Equal As Numbers    ${response.status_code}    200
    # Store Response
    ${json}=    Set Variable    ${response.json()}
    Log    Subscribed: ${json}

Unsubscribe Addon Prepaid Celcom
    [Arguments]    ${accessToken}    ${phoneNo}
    ${headers}=    Create Dictionary    Content-Type=application/json    Authorization=${accessToken}
    &{product}=    Create Dictionary    productId=C_Data_PPS_Base_UL    productName=Internet Pass - 5G 25 Juara Keren 2025 (30 days)
    @{products}=   Create List    ${product}
    &{unsubscribe}=  Create Dictionary    products=${products}
    ${query}=    Create Dictionary
    ...    msisdn=${phoneNo}
    ...    payType=PREPAID
    ...    unsubscribe=${unsubscribe}
    #Sent Request
    Create Session    unSubscribeAddOn   ${BAU_MOLI2_BASE_URL}    headers=${headers}    verify=true
    ${response}=    PUT On Session    unSubscribeAddOn    ${PUT_ADDON_CHANGE_PATH}    json=${query}
    Should Be Equal As Numbers    ${response.status_code}    200
    # Store Response
    ${json}=    Set Variable    ${response.json()}
    Log    Unsubscribed: ${json}