*** Settings ***
Documentation    This file only share account keywords only

Resource    ../MOLI-testSettings.robot

*** Keywords ***

Get Account Usage Internet
    [Arguments]    ${accessToken}    ${phoneNo}
    ${headers}=    Create Dictionary    Authorization=${accessToken}
    # Sent Request
    Create Session    getAccountUsageInternet    ${BAU_MOLI_BASE_URL}    headers=${headers}    verify=true
    ${response}=    GET On Session    getAccountUsageInternet    ${GET_ACCOUNT_USAGE_PATH}${phoneNo}${GET_ACCOUNT_USAGE_PATH2}
    Should Be Equal As Numbers    ${response.status_code}    200
    #Store : internet offers
    ${json}=    Set Variable    ${response.json()}
    ${internetOffers}=    Get Value From Json    ${json}    $.plan.internet[*]
    Log    Internet offers: ${internetOffers}
    RETURN    ${internetOffers}