*** Settings ***
Documentation    This file only store subscriber keywords.

Resource    ../MOLI-testSettings.robot

*** Keywords ***

Get Subscriber Profile Before
    [Arguments]    ${accessToken}    ${phoneNo}
    ${headers}=    Create Dictionary    Authorization=${accessToken}
    #Sent Request
    Create Session    getSubscriberProfile    ${BAU_MOLI2_BASE_URL}    headers=${headers}    verify=true
    ${response}=    GET On Session    getSubscriberProfile    ${GET_SUBSCRIBER_PROFILE_PATH}${phoneNo}
    Should Be Equal As Numbers    ${response.status_code}    200
    #Store Response
    ${getSubscriberProfileBeforeResponse}=    Set Variable    ${response.json()}
    RETURN   ${getSubscriberProfileBeforeResponse}

Get Prepaid Balance Before
    [Arguments]    ${accessToken}    ${phoneNo}
    ${headers}=    Create Dictionary    Authorization=${accessToken}
    #Sent Request
    Create Session    getSubscriberPrepaidBalance    ${BAU_MOLI_BASE_URL}    headers=${headers}    verify=true
    ${response}=    GET On Session    getSubscriberPrepaidBalance    ${GET_SUBSCRIBER_PREPAID_BALANCE_PATH}${phoneNo}${GET_SUBSCRIBER_PREPAID_BALANCE_PATH2}
    Should Be Equal As Numbers    ${response.status_code}    200
    #Store Response
    ${getSubscriberPrepaidBalanceBeforeResponse}=    Set Variable    ${response.json()}
    RETURN   ${getSubscriberPrepaidBalanceBeforeResponse}

Get Subscriber Profile After
    [Arguments]    ${accessToken}    ${phoneNo}
    ${headers}=    Create Dictionary    Authorization=${accessToken}
    #Sent Request
    Create Session    getSubscriberProfile    ${BAU_MOLI2_BASE_URL}    headers=${headers}    verify=true
    ${response}=    GET On Session    getSubscriberProfile    ${GET_SUBSCRIBER_PROFILE_PATH}${phoneNo}
    Should Be Equal As Numbers    ${response.status_code}    200
    #Store Response
    ${getSubscriberProfileAfterResponse}=    Set Variable    ${response.json()}
    RETURN   ${getSubscriberProfileAfterResponse}

Get Prepaid Balance After
    [Arguments]    ${accessToken}    ${phoneNo}
    ${headers}=    Create Dictionary    Authorization=${accessToken}
    #Sent Request
    Create Session    getSubscriberPrepaidBalance    ${BAU_MOLI_BASE_URL}    headers=${headers}    verify=true
    ${response}=    GET On Session    getSubscriberPrepaidBalance    ${GET_SUBSCRIBER_PREPAID_BALANCE_PATH}${phoneNo}${GET_SUBSCRIBER_PREPAID_BALANCE_PATH2}
    Should Be Equal As Numbers    ${response.status_code}    200
    #Store Response
    ${getSubscriberPrepaidBalanceAfterResponse}=    Set Variable    ${response.json()}
    RETURN   ${getSubscriberPrepaidBalanceAfterResponse}

Get Subscriber Profile NonCD
    [Arguments]    ${accessToken}    ${phoneNo}
    ${headers}=    Create Dictionary    Authorization=${accessToken}
    #Sent Request
    Create Session    getSubscriberProfile    ${BAU_MOLI2_BASE_URL}    headers=${headers}    verify=true
    ${response}=    GET On Session    getSubscriberProfile    ${GET_SUBSCRIBER_PROFILE_PATH}${phoneNo}    expected_status=any
    Should Not Be Equal As Numbers    ${response.status_code}    200
    #Store Response
    ${getSubscriberProfileNonCD}=    Set Variable    ${response.json()}
    RETURN   ${getSubscriberProfileNonCD}

# Get Subscriber Addons
#     [Arguments]    ${accessToken}    ${phoneNo}
#     ${headers}=    Create Dictionary    Authorization=${accessToken}
#     #Sent Request
#     Create Session    getSubscriberAddons    ${BAU_MOLI_BASE_URL}    headers=${headers}    verify=true
#     ${response}=    GET On Session    getSubscriberAddons    ${GET_SUBSCRIBER_PROFILE_PATH}${phoneNo}
#     Should Be Equal As Numbers    ${response.status_code}    200
#     #Store only subscription Addon    
#     ${json}=    Set Variable    ${response.json()}
#     ${addons}=    Get Value From Json    ${json}    $.subscriptions.addons[*]
#     #Check if any subscription Addon within the list
#     ${addons_length}=    Get Length    ${addons}
#     Run Keyword If    ${addons_length} == 0    Log    No add ons available
#     RETURN    ${addons}

