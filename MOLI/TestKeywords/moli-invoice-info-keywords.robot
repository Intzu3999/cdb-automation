*** Settings ***
Documentation    This file only share invoice info keywords only

Resource    ../MOLI-testSettings.robot

*** Keywords ***

Get Billing Info Before
    [Arguments]    ${accessToken}    ${phoneNo}
    ${headers}=    Create Dictionary     Authorization=${accessToken}
    ##Sent Request
    Create Session     getBillingInfo   ${BAU_MOLI3_BASE_URL}    headers=${headers}    verify=true
    ${response}=     Get On Session    getBillingInfo    ${GET_INVOICE_BILLING_PATH}${phoneNo}${GET_INVOICE_BILLING_PATH2}    
    Should Be Equal As Numbers    ${response.status_code}    200
    #Store Response
    ${getBillingInfoBeforeResponse}=    Set Variable    ${response.json()}
    RETURN   ${getBillingInfoBeforeResponse}

Get Billing Info Before Negative
    [Arguments]    ${accessToken}    ${phoneNo}
    ${headers}=    Create Dictionary     Authorization=${accessToken}
    ##Sent Request
    Create Session     getBillingInfo   ${BAU_MOLI3_BASE_URL}    headers=${headers}    verify=true
    ${response}=     Get On Session    getBillingInfo    ${GET_INVOICE_BILLING_PATH}${phoneNo}${GET_INVOICE_BILLING_PATH2}    expected_status=any    
    Should Not Be Equal As Numbers    ${response.status_code}    200
    #Store Response
    ${getBillingInfoBeforeUnsuccessfulResponse}=    Set Variable    ${response.json()}
    RETURN   ${getBillingInfoBeforeUnsuccessfulResponse}

Get Billing Info After
    [Arguments]    ${accessToken}    ${phoneNo}
    ${headers}=    Create Dictionary     Authorization=${accessToken}
    ##Sent Request
    Create Session     getBillingInfo   ${BAU_MOLI3_BASE_URL}    headers=${headers}    verify=true
    ${response}=     Get On Session    getBillingInfo    ${GET_INVOICE_BILLING_PATH}${phoneNo}${GET_INVOICE_BILLING_PATH2}    
    Should Be Equal As Numbers    ${response.status_code}    200
    #Store Response
    ${getBillingInfoAfterResponse}=    Set Variable    ${response.json()}
    RETURN   ${getBillingInfoAfterResponse}

Get Billing Info After Negative
    [Arguments]    ${accessToken}    ${phoneNo}
    ${headers}=    Create Dictionary     Authorization=${accessToken}
    ##Sent Request
    Create Session     getBillingInfo   ${BAU_MOLI3_BASE_URL}    headers=${headers}    verify=true
    ${response}=     Get On Session    getBillingInfo    ${GET_INVOICE_BILLING_PATH}${phoneNo}${GET_INVOICE_BILLING_PATH2}    expected_status=any    
    Should Not Be Equal As Numbers    ${response.status_code}    200
    #Store Response
    ${getBillingInfoAfterUnsuccessfulResponse}=    Set Variable    ${response.json()}
    RETURN   ${getBillingInfoAfterUnsuccessfulResponse}