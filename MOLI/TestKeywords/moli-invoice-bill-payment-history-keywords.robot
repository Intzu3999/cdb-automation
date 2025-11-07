*** Settings ***
Documentation    This file only share bill payment history keywords only

Resource    ../MOLI-testSettings.robot

*** Keywords ***

Get Bill Payment History
    [Arguments]    ${accessToken}    ${phoneNo}
    ${headers}=    Create Dictionary    Authorization=${accessToken}
    # Send request
    Create Session    getBillPaymentHistory    ${BAU_MOLI2_BASE_URL}    headers=${headers}    verify=true
    ${response}=    GET On Session    getBillPaymentHistory    ${GET_INVOICE_BILLING_PATH}${phoneNo}${GET_PAYMENT_HISTORY_PATH}
    Should Be Equal As Numbers    ${response.status_code}    200
    #Store Response
    ${getBillPaymentHistoryResponse}=    Set Variable    ${response.json()}
    RETURN   ${getBillPaymentHistoryResponse}

Validate Bill Payment History
    [Arguments]    ${performPostpaidBillPaymentSuccessResponse}    ${getBillPaymentHistoryResponse}
    ${txnIdList}=    Get Value From Json    ${performPostpaidBillPaymentSuccessResponse}    $.transactionId
    ${paymentAmtList}=      Get Value From Json    ${performPostpaidBillPaymentSuccessResponse}    $.paymentAmount
    ${txnDateList}=        Get Value From Json    ${getBillPaymentHistoryResponse}    $.paymentHistory[*].transactionDate
    ${amountList}=         Get Value From Json    ${getBillPaymentHistoryResponse}    $.paymentHistory[*].value.amount
    ${txnId2List}=         Get Value From Json    ${getBillPaymentHistoryResponse}    $.paymentHistory[*].transactionId
    #Extract the first element from each list
    ${txnId}=    Get From List    ${txnIdList}    0
    ${paymentAmt}=    Get From List    ${paymentAmtList}      0
    ${txnDate}=    Get From List    ${txnDateList}    0
    ${amount}=    Get From List    ${amountList}    0
    ${txnId2}=    Get From List    ${txnId2List}    0
    #Validate difference
    Should Be Equal As Numbers    ${amount}    ${paymentAmt}
    Should Be Equal As Numbers    ${txnId2}    ${txnId}