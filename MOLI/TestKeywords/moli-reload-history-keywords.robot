*** Settings ***
Documentation    This file only share reload history keywords only

Resource    ../MOLI-testSettings.robot

*** Keywords ***

Get Reload History
    [Arguments]    ${accessToken}    ${phoneNo}    ${performPrepaidReloadSuccessResponse}
    ${txnIdList}=    Get Value From Json    ${performPrepaidReloadSuccessResponse}    $.transactionId
    #Extract the first element from each list
    ${txnId}=    Get From List    ${txnIdList}    0

    ${headers}=    Create Dictionary    Authorization=${accessToken}
    #Send request
    Create Session    getReloadHistory    ${BAU_MOLI2_BASE_URL}    headers=${headers}    verify=true
    ${response}=    GET On Session    getReloadHistory    ${GET_SUBSCRIBER_RELOAD_HISTORY_PATH3}${phoneNo}${GET_SUBSCRIBER_RELOAD_HISTORY_PATH2}${GET_SUBSCRIBER_RELOAD_HISTORY_PATH4}${txnId}
    Should Be Equal As Numbers    ${response.status_code}    200
    #Store Response
    ${getReloadHistoryResponse}=    Set Variable    ${response.json()}
    RETURN   ${getReloadHistoryResponse}

Get Reload History From Bill Payment
    [Arguments]    ${accessToken}    ${phoneNo}    ${performPostpaidBillPaymentSuccessResponse}
    ${txnIdList}=    Get Value From Json    ${performPostpaidBillPaymentSuccessResponse}    $.transactionId
    #Extract the first element from each list
    ${txnId}=    Get From List    ${txnIdList}    0

    ${headers}=    Create Dictionary    Authorization=${accessToken}
    #Send request
    Create Session    getReloadHistory    ${BAU_MOLI2_BASE_URL}    headers=${headers}    verify=true
    ${response}=    GET On Session    getReloadHistory    ${GET_SUBSCRIBER_RELOAD_HISTORY_PATH3}${phoneNo}${GET_SUBSCRIBER_RELOAD_HISTORY_PATH2}${GET_SUBSCRIBER_RELOAD_HISTORY_PATH4}${txnId}
    Should Be Equal As Numbers    ${response.status_code}    200
    #Store Response
    ${getReloadHistoryResponse}=    Set Variable    ${response.json()}
    RETURN   ${getReloadHistoryResponse}

Validate Reload History
    [Arguments]    ${performPrepaidReloadSuccessResponse}    ${getReloadHistoryResponse}
    ${txnIdList}=    Get Value From Json    ${performPrepaidReloadSuccessResponse}    $.transactionId
    ${rechargeAmtList}=      Get Value From Json    ${performPrepaidReloadSuccessResponse}    $.value[0].topUp.amount
    ${txnDateList}=        Get Value From Json    ${getReloadHistoryResponse}    $.reloadHistory[*].transactionDate
    ${amountList}=         Get Value From Json    ${getReloadHistoryResponse}    $.reloadHistory[*].value.amount
    ${taxList}=            Get Value From Json    ${getReloadHistoryResponse}    $.reloadHistory[*].value.taxAmount
    #Extract the first element from each list
    ${txnId}=    Get From List    ${txnIdList}    0
    ${rechargeAmt}=    Get From List    ${rechargeAmtList}      0
    ${txnDate}=    Get From List    ${txnDateList}    0
    ${amount}=    Get From List    ${amountList}    0
    ${taxAmount}=    Get From List    ${taxList}    0
    #Calculate total recharge
    ${expectedRecharge}=    Evaluate    format(float(${amount}) + float(${taxAmount}), ".2f")
    #Validate difference
    Should Be Equal As Numbers    ${expectedRecharge}    ${rechargeAmt}

Validate Reload History From Bill Payment
    [Arguments]    ${performPostpaidBillPaymentSuccessResponse}    ${getReloadHistoryResponse}
    ${txnIdList}=    Get Value From Json    ${performPostpaidBillPaymentSuccessResponse}    $.transactionId
    ${paymentAmtList}=      Get Value From Json    ${performPostpaidBillPaymentSuccessResponse}    $.paymentAmount
    ${txnDateList}=        Get Value From Json    ${getReloadHistoryResponse}    $.reloadHistory[*].transactionDate
    ${amountList}=         Get Value From Json    ${getReloadHistoryResponse}    $.reloadHistory[*].value.amount
    ${taxList}=            Get Value From Json    ${getReloadHistoryResponse}    $.reloadHistory[*].value.taxAmount
    #Extract the first element from each list
    ${txnId}=    Get From List    ${txnIdList}    0
    ${paymentAmt}=    Get From List    ${paymentAmtList}      0
    ${txnDate}=    Get From List    ${txnDateList}    0
    ${amount}=    Get From List    ${amountList}    0
    ${taxAmount}=    Get From List    ${taxList}    0
    #Calculate total recharge
    ${expectedPayment}=    Evaluate    format(float(${amount}) + float(${taxAmount}), ".2f")
    #Validate difference
    Should Be Equal As Numbers    ${expectedPayment}    ${paymentAmt}