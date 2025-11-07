*** Settings ***
Documentation    This file only share reload keywords only

Resource    ../MOLI-testSettings.robot

*** Keywords ***

Post Perform Prepaid Pinless Reload
    [Arguments]    ${accessToken}    ${phoneNo}    ${paymentAmount}    ${paymentMethod}    ${sourceChannel}
    ${adjustmentCode}=    Generate Random String    6
    ${headers}=    Create Dictionary    Content-Type=application/json    Authorization=${accessToken}
    ${query}=    Create Dictionary
    ...    msisdn=${phoneNo}
    ...    paymentAmount=${paymentAmount}
    ...    adjustmentCode=${adjustmentCode}
    ...    paymentMethod=${paymentMethod}
    ...    sourceChannel=${sourceChannel}
    #Send Request
    Create Session    performPrepaidReload    ${BAU_MOLI2_BASE_URL}    headers=${headers}    verify=true
    ${response}=    POST On Session    performPrepaidReload    ${POST_PREPAID_PINLESS_RELOAD_PATH}    json=${query}
    Should Be Equal As Numbers    ${response.status_code}    200
    #Store Response
    ${performPrepaidReloadSuccessResponse}=    Set Variable    ${response.json()}
    RETURN   ${performPrepaidReloadSuccessResponse}

Post Perform Prepaid Pinless Reload Negative 
    [Arguments]    ${accessToken}    ${phoneNo}    ${paymentAmount}    ${paymentMethod}    ${sourceChannel}
    ${adjustmentCode}=    Generate Random String    6
    ${headers}=    Create Dictionary    Content-Type=application/json    Authorization=${accessToken}
    ${query}=    Create Dictionary
    ...    msisdn=${phoneNo}
    ...    paymentAmount=${paymentAmount}
    ...    adjustmentCode=${adjustmentCode}
    ...    paymentMethod=${paymentMethod}
    ...    sourceChannel=${sourceChannel}
    #Send Request
    Create Session    performPrepaidReload    ${BAU_MOLI2_BASE_URL}    headers=${headers}    verify=true
    ${response}=    POST On Session    performPrepaidReload    ${POST_PREPAID_PINLESS_RELOAD_PATH}    json=${query}    expected_status=any
    Should Not Be Equal As Numbers    ${response.status_code}    200
    # Store: Response
    ${performPrepaidReloadUnsuccessResponse}=    Set Variable    ${response.json()}
    RETURN   ${performPrepaidReloadUnsuccessResponse}

Validate Reload Amount Correct
    [Arguments]    ${getSubscriberPrepaidBalanceABeforeResponse}    ${performPrepaidReloadSuccessResponse}    ${getSubscriberPrepaidBalanceAfterResponse}
    ${balanceBeforeList}=    Get Value From Json    ${getSubscriberPrepaidBalanceABeforeResponse}    $.prepaidBalance.main[0].amount
    ${balanceAfterList}=     Get Value From Json    ${getSubscriberPrepaidBalanceAfterResponse}    $.prepaidBalance.main[0].amount
    ${rechargeAmtList}=      Get Value From Json    ${performPrepaidReloadSuccessResponse}    $.value[0].topUp.amount
    #Extract the first element from each list
    ${balanceBefore}=    Get From List    ${balanceBeforeList}    0
    ${balanceAfter}=     Get From List    ${balanceAfterList}     0
    ${rechargeAmt}=      Get From List    ${rechargeAmtList}      0
    #Calculate difference
    ${expectedRecharge}=    Evaluate    format(float(${balanceAfter}) - float(${balanceBefore}), ".2f")
    #Validate difference
    Should Be Equal As Numbers    ${expectedRecharge}    ${rechargeAmt}

Validate Reload Amount Correct From Bill Payment    
    [Arguments]    ${getSubscriberPrepaidBalanceBeforeResponse}    ${performPostpaidBillPaymentSuccessResponse}    ${getSubscriberPrepaidBalanceAfterResponse}
    ${balanceBeforeList}=    Get Value From Json    ${getSubscriberPrepaidBalanceBeforeResponse}    $.prepaidBalance.main[0].amount
    ${balanceAfterList}=     Get Value From Json    ${getSubscriberPrepaidBalanceAfterResponse}    $.prepaidBalance.main[0].amount
    ${paymentAmtList}=    Get Value From Json    ${performPostpaidBillPaymentSuccessResponse}    $.paymentAmount
    #Extract the first element from each list
    ${balanceBefore}=    Get From List    ${balanceBeforeList}    0
    ${balanceAfter}=     Get From List    ${balanceAfterList}     0
    ${paymentAmt}=      Get From List    ${paymentAmtList}      0
    #Calculate difference
    ${expectedRecharge}=    Evaluate    format(float(${balanceAfter}) - float(${balanceBefore}), ".2f")
    #Validate difference
    Should Be Equal As Numbers    ${expectedRecharge}    ${paymentAmt}

Validate Reload Amount Unchanged
    [Arguments]    ${getSubscriberPrepaidBalanceABeforeResponse}    ${getSubscriberPrepaidBalanceAfterResponse}
    ${balanceBeforeList}=    Get Value From Json    ${getSubscriberPrepaidBalanceABeforeResponse}    $.prepaidBalance.main[0].amount
    ${balanceAfterList}=     Get Value From Json    ${getSubscriberPrepaidBalanceAfterResponse}    $.prepaidBalance.main[0].amount
    #Extract the first element from each list
    ${balanceBefore}=    Get From List    ${balanceBeforeList}    0
    ${balanceAfter}=     Get From List    ${balanceAfterList}     0
    #Calculate difference
    ${expectedRecharge}=    Evaluate    format(float(${balanceAfter}) - float(${balanceBefore}), ".2f")
    Should Be Equal As Numbers    ${expectedRecharge}   0
    Should Be Equal    ${balanceBefore}    ${balanceAfter}

Validate Prepaid Lifecycle Active
    [Arguments]    ${getSubscriberProfileBeforeResponse}    ${getSubscriberProfileAfterResponse}
    ${statusBeforeList}=    Get Value From Json    ${getSubscriberProfileBeforeResponse}    $.status
    ${statusAfterList}=    Get Value From Json    ${getSubscriberProfileAfterResponse}    $.status
    ${terminationDateBeforeList}=    Get Value From Json    ${getSubscriberProfileBeforeResponse}    $.characteristic.lifeCycleInfo.terminationDate
    ${terminationDateAfterList}=    Get Value From Json    ${getSubscriberProfileAfterResponse}    $.characteristic.lifeCycleInfo.terminationDate
    #Extract the first element from each list
    ${statusBefore}=    Get From List    ${statusBeforeList}    0
    ${statusAfter}=     Get From List    ${statusAfterList}     0
    ${terminationDateBefore}=    Get From List    ${terminationDateBeforeList}    0
    ${terminationDateAfter}=     Get From List    ${terminationDateAfterList}     0
    #Validate status is Active
    Should Be Equal As Strings    ${statusBefore}    Active
    Should Be Equal As Strings    ${statusAfter}     Active
    # Validate Termination Date is updated
    Should Not Be Equal As Strings    ${terminationDateBefore}    ${terminationDateAfter}

Validate Prepaid Lifecycle Updated From Barred To Active
    [Arguments]    ${getSubscriberProfileBeforeResponse}    ${getSubscriberProfileAfterResponse}
    ${statusBeforeList}=    Get Value From Json    ${getSubscriberProfileBeforeResponse}    $.status
    ${statusAfterList}=    Get Value From Json    ${getSubscriberProfileAfterResponse}    $.status
    ${terminationDateBeforeList}=    Get Value From Json    ${getSubscriberProfileBeforeResponse}    $.characteristic.lifeCycleInfo.terminationDate
    ${terminationDateAfterList}=    Get Value From Json    ${getSubscriberProfileAfterResponse}    $.characteristic.lifeCycleInfo.terminationDate
    #Extract the first element from each list
    ${statusBefore}=    Get From List    ${statusBeforeList}    0
    ${statusAfter}=     Get From List    ${statusAfterList}     0
    ${terminationDateBefore}=    Get From List    ${terminationDateBeforeList}    0
    ${terminationDateAfter}=     Get From List    ${terminationDateAfterList}     0
    # Validate status from Barred -> Active
    Should Be Equal As Strings    ${statusBefore}    Barred
    Should Be Equal As Strings    ${statusAfter}     Active
    # Validate termination date is updated
    Should Not Be Equal As Strings    ${terminationDateBefore}    ${terminationDateAfter}

Validate Prepaid Lifecycle Suspended
    [Arguments]    ${getSubscriberProfileBeforeResponse}    ${getSubscriberProfileAfterResponse}
    ${statusBeforeList}=    Get Value From Json    ${getSubscriberProfileBeforeResponse}    $.status
    ${statusAfterList}=    Get Value From Json    ${getSubscriberProfileAfterResponse}    $.status
    ${terminationDateBeforeList}=    Get Value From Json    ${getSubscriberProfileBeforeResponse}    $.characteristic.lifeCycleInfo.terminationDate
    ${terminationDateAfterList}=    Get Value From Json    ${getSubscriberProfileAfterResponse}    $.characteristic.lifeCycleInfo.terminationDate
    #Extract the first element from each list
    ${statusBefore}=    Get From List    ${statusBeforeList}    0
    ${statusAfter}=     Get From List    ${statusAfterList}     0
    ${terminationDateBefore}=    Get From List    ${terminationDateBeforeList}    0
    ${terminationDateAfter}=     Get From List    ${terminationDateAfterList}     0
    # Validate status remains Suspended
    Should Be Equal As Strings    ${statusBefore}    Suspended
    Should Be Equal As Strings    ${statusAfter}     Suspended
    # Validate termination date remains
    Should Be Equal As Strings    ${terminationDateBefore}    ${terminationDateAfter}

Validate Prepaid Lifecycle Deactivated
    [Arguments]    ${getSubscriberProfileBeforeResponse}    ${getSubscriberProfileAfterResponse}
    ${statusBeforeList}=    Get Value From Json    ${getSubscriberProfileBeforeResponse}    $.status
    ${statusAfterList}=    Get Value From Json    ${getSubscriberProfileAfterResponse}    $.status
    ${terminationDateBeforeList}=    Get Value From Json    ${getSubscriberProfileBeforeResponse}    $.characteristic.lifeCycleInfo.terminationDate
    ${terminationDateAfterList}=    Get Value From Json    ${getSubscriberProfileAfterResponse}    $.characteristic.lifeCycleInfo.terminationDate
    #Extract the first element from each list
    ${statusBefore}=    Get From List    ${statusBeforeList}    0
    ${statusAfter}=     Get From List    ${statusAfterList}     0
    ${terminationDateBefore}=    Get From List    ${terminationDateBeforeList}    0
    ${terminationDateAfter}=     Get From List    ${terminationDateAfterList}     0
    # Validate status remains Deactivated
    Should Be Equal As Strings    ${statusBefore}    Deactivated
    Should Be Equal As Strings    ${statusAfter}     Deactivated
    # Validate termination date remains
    Should Be Equal As Strings    ${terminationDateBefore}    ${terminationDateAfter}

Validate Postpaid Lifecycle
    [Arguments]    ${getSubscriberProfileBeforeResponse}    ${getSubscriberProfileAfterResponse}
    ${typeBeforeList}=    Get Value From Json    ${getSubscriberProfileBeforeResponse}    $.type
    ${typeAfterList}=    Get Value From Json    ${getSubscriberProfileAfterResponse}    $.type
    #Extract the first element from each list
    ${typeBefore}=    Get From List    ${typeBeforeList}    0
    ${typeAfter}=     Get From List    ${typeAfterList}     0
    # Validate type is Postpaid
    Should Be Equal As Strings    ${typeBefore}    POSTPAID
    Should Be Equal As Strings    ${typeAfter}     POSTPAID
    # Validate type remains
    Should Be Equal As Strings    ${typeBefore}    ${typeAfter}

Log Reload Summary
    [Arguments]    ${phoneNo}    ${getSubscriberProfileBeforeResponse}    ${getSubscriberPrepaidBalanceBeforeResponse}    ${performPrepaidReloadSuccessResponse}    ${getSubscriberProfileAfterResponse}    ${getSubscriberPrepaidBalanceAfterResponse}    ${getReloadHistoryResponse}
    ${typeList}=    Get Value From Json    ${getSubscriberProfileBeforeResponse}    $.type
    ${statusBeforeList}=    Get Value From Json    ${getSubscriberProfileBeforeResponse}    $.status
    ${statusAfterList}=    Get Value From Json    ${getSubscriberProfileAfterResponse}    $.status
    ${terminationDateBeforeList}=    Get Value From Json    ${getSubscriberProfileBeforeResponse}    $.characteristic.lifeCycleInfo.terminationDate
    ${terminationDateAfterList}=    Get Value From Json    ${getSubscriberProfileAfterResponse}    $.characteristic.lifeCycleInfo.terminationDate
    ${balanceBeforeList}=    Get Value From Json    ${getSubscriberPrepaidBalanceBeforeResponse}    $.prepaidBalance.main[0].amount
    ${balanceAfterList}=    Get Value From Json    ${getSubscriberPrepaidBalanceAfterResponse}    $.prepaidBalance.main[0].amount
    ${txnIdList}=    Get Value From Json    ${performPrepaidReloadSuccessResponse}    $.transactionId
    ${rechargeAmtList}=    Get Value From Json    ${performPrepaidReloadSuccessResponse}    $.value[0].topUp.amount
    ${txnDateList}=        Get Value From Json    ${getReloadHistoryResponse}    $.reloadHistory[*].transactionDate
    ${amountList}=         Get Value From Json    ${getReloadHistoryResponse}    $.reloadHistory[*].value.amount
    ${taxAmountList}=            Get Value From Json    ${getReloadHistoryResponse}    $.reloadHistory[*].value.taxAmount
    #Extract the first element from each list
    ${type}=    Get From List    ${typeList}    0
    ${statusBefore}=    Get From List    ${statusBeforeList}    0
    ${statusAfter}=     Get From List    ${statusAfterList}     0
    ${terminationDateBefore}=    Get From List    ${terminationDateBeforeList}    0
    ${terminationDateAfter}=     Get From List    ${terminationDateAfterList}     0
    ${balanceBefore}=    Get From List    ${balanceBeforeList}    0
    ${balanceAfter}=     Get From List    ${balanceAfterList}     0
    ${txnId}=    Get From List    ${txnIdList}    0
    ${rechargeAmt}=      Get From List    ${rechargeAmtList}      0
    ${txnDate}=    Get From List    ${txnDateList}    0
    ${amount}=    Get From List    ${amountList}    0
    ${taxAmount}=    Get From List    ${taxAmountList}    0

    Log To Console    \n========== 📌 RELOAD SUMMARY ==========
    Log To Console    MSISDN: ${phoneNo}
    Log To Console    Type: ${type}
    Log To Console    Txn Date: ${txnDate}
    Log To Console    Txn ID: ${txnId}
    Log To Console    Amount: ${amount}
    Log To Console    Tax Amount: ${taxAmount}
    Log To Console    Total Reload (Amount + Tax): ${rechargeAmt}
    Log To Console    Status Before: ${statusBefore}
    Log To Console    Status After: ${statusAfter}
    Log To Console    Expiry Before: ${terminationDateBefore}
    Log To Console    Expiry After: ${terminationDateAfter}
    Log To Console    \nGet Prepaid Balance 
    Log To Console    [Bef] Balance: ${balanceBefore}
    Log To Console    [Aft] Balance: ${balanceAfter}
    Log To Console    =======================================\n

Log Reload Summary Invalid
    [Arguments]    ${phoneNo}    ${getSubscriberProfileBeforeResponse}    ${getSubscriberPrepaidBalanceBeforeResponse}    ${getSubscriberProfileAfterResponse}    ${getSubscriberPrepaidBalanceAfterResponse}    ${performPrepaidReloadUnsuccessResponse}
    ${typeList}=    Get Value From Json    ${getSubscriberProfileBeforeResponse}    $.type
    ${statusBeforeList}=    Get Value From Json    ${getSubscriberProfileBeforeResponse}    $.status
    ${statusAfterList}=    Get Value From Json    ${getSubscriberProfileAfterResponse}    $.status
    ${terminationDateBeforeList}=    Get Value From Json    ${getSubscriberProfileBeforeResponse}    $.characteristic.lifeCycleInfo.terminationDate
    ${terminationDateAfterList}=    Get Value From Json    ${getSubscriberProfileAfterResponse}    $.characteristic.lifeCycleInfo.terminationDate
    ${balanceBeforeList}=    Get Value From Json    ${getSubscriberPrepaidBalanceBeforeResponse}    $.prepaidBalance.main[0].amount
    ${balanceAfterList}=    Get Value From Json    ${getSubscriberPrepaidBalanceAfterResponse}    $.prepaidBalance.main[0].amount
    ${errorList}=          Get Value From Json    ${performPrepaidReloadUnsuccessResponse}    $.error
    ${serviceList}=        Get Value From Json    ${performPrepaidReloadUnsuccessResponse}    $.service
    ${messageList}=        Get Value From Json    ${performPrepaidReloadUnsuccessResponse}    $.message
    ${sourceCodeList}=     Get Value From Json    ${performPrepaidReloadUnsuccessResponse}    $.source.code
    ${sourceDescList}=     Get Value From Json    ${performPrepaidReloadUnsuccessResponse}    $.source.description
    ${sourceReasonList}=   Get Value From Json    ${performPrepaidReloadUnsuccessResponse}    $.source.reason
    #Extract the first element from each list
    ${type}=    Get From List    ${typeList}    0
    ${statusBefore}=    Get From List    ${statusBeforeList}    0
    ${statusAfter}=     Get From List    ${statusAfterList}     0
    ${terminationDateBefore}=    Get From List    ${terminationDateBeforeList}    0
    ${terminationDateAfter}=     Get From List    ${terminationDateAfterList}     0
    ${balanceBefore}=    Get From List    ${balanceBeforeList}    0
    ${balanceAfter}=     Get From List    ${balanceAfterList}     0
    ${error}=          Get From List    ${errorList}          0
    ${service}=        Get From List    ${serviceList}        0
    ${message}=        Get From List    ${messageList}        0
    ${sourceCode}=     Get From List    ${sourceCodeList}     0
    ${sourceDesc}=     Get From List    ${sourceDescList}     0
    ${sourceReason}=   Get From List    ${sourceReasonList}   0

    Log To Console    \n========== 📌 RELOAD SUMMARY ==========
    Log To Console    MSISDN: ${phoneNo}
    Log To Console    Type: ${type}
    Log To Console    Status Before: ${statusBefore}
    Log To Console    Status After: ${statusAfter}
    Log To Console    Expiry Before: ${terminationDateBefore}
    Log To Console    Expiry After: ${terminationDateAfter}
    Log To Console    \nGet Prepaid Balance 
    Log To Console    [Bef] Balance: ${balanceBefore}
    Log To Console    [Aft] Balance: ${balanceAfter}
    Log To Console    \nPrepaid Reload Unsuccessful
    Log To Console    Error: ${error} | Service: ${service} | Message: ${message} | Source Code: ${sourceCode}
    Log To Console    Source Description: ${sourceDesc} | Source Reason: ${sourceReason}
    Log To Console    =====================================\n

Log Reload Summary Invalid II
    [Arguments]    ${phoneNo}    ${getSubscriberProfileBeforeResponse}    ${getSubscriberPrepaidBalanceBeforeResponse}    ${getBillingInfoBeforeResponse}    ${getSubscriberProfileAfterResponse}    ${getSubscriberPrepaidBalanceAfterResponse}    ${getBillingInfoAfterResponse}    ${performPrepaidReloadUnsuccessResponse}
    ${typeList}=    Get Value From Json    ${getSubscriberProfileBeforeResponse}    $.type
    ${statusBeforeList}=    Get Value From Json    ${getSubscriberProfileBeforeResponse}    $.status
    ${statusAfterList}=    Get Value From Json    ${getSubscriberProfileAfterResponse}    $.status
    ${terminationDateBeforeList}=    Get Value From Json    ${getSubscriberProfileBeforeResponse}    $.characteristic.lifeCycleInfo.terminationDate
    ${terminationDateAfterList}=    Get Value From Json    ${getSubscriberProfileAfterResponse}    $.characteristic.lifeCycleInfo.terminationDate
    ${balanceBeforeList}=    Get Value From Json    ${getSubscriberPrepaidBalanceBeforeResponse}    $.prepaidBalance.main[0].amount
    ${balanceAfterList}=    Get Value From Json    ${getSubscriberPrepaidBalanceAfterResponse}    $.prepaidBalance.main[0].amount
    ${advanceBeforeList}=    Get Value From Json    ${getBillingInfoBeforeResponse}    $.balances.advancePayment
    ${advanceAfterList}=     Get Value From Json    ${getBillingInfoAfterResponse}    $.balances.advancePayment
    ${overdueBeforeList}=    Get Value From Json    ${getBillingInfoBeforeResponse}    $.balances.overdueAmount
    ${overdueAfterList}=     Get Value From Json    ${getBillingInfoAfterResponse}    $.balances.overdueAmount
    ${outstandingBeforeList}=    Get Value From Json    ${getBillingInfoBeforeResponse}    $.balances.outstandingAmount
    ${outstandingAfterList}=     Get Value From Json    ${getBillingInfoAfterResponse}    $.balances.outstandingAmount
    ${unbilledBeforeList}=    Get Value From Json    ${getBillingInfoBeforeResponse}    $.balances.unbilledAmount
    ${unbilledAfterList}=     Get Value From Json    ${getBillingInfoAfterResponse}    $.balances.unbilledAmount
    ${errorList}=          Get Value From Json    ${performPrepaidReloadUnsuccessResponse}    $.error
    ${serviceList}=        Get Value From Json    ${performPrepaidReloadUnsuccessResponse}    $.service
    ${messageList}=        Get Value From Json    ${performPrepaidReloadUnsuccessResponse}    $.message
    ${sourceCodeList}=     Get Value From Json    ${performPrepaidReloadUnsuccessResponse}    $.source.code
    ${sourceDescList}=     Get Value From Json    ${performPrepaidReloadUnsuccessResponse}    $.source.description
    ${sourceReasonList}=   Get Value From Json    ${performPrepaidReloadUnsuccessResponse}    $.source.reason
    #Extract the first element from each list
    ${type}=    Get From List    ${typeList}    0
    ${statusBefore}=    Get From List    ${statusBeforeList}    0
    ${statusAfter}=     Get From List    ${statusAfterList}     0
    ${terminationDateBefore}=    Get From List    ${terminationDateBeforeList}    0
    ${terminationDateAfter}=     Get From List    ${terminationDateAfterList}     0
    ${balanceBefore}=    Get From List    ${balanceBeforeList}    0
    ${balanceAfter}=     Get From List    ${balanceAfterList}     0
    ${advanceBefore}=    Get From List    ${advanceBeforeList}    0
    ${advanceAfter}=    Get From List    ${advanceAfterList}    0
    ${overdueBefore}=    Get From List    ${overdueBeforeList}    0
    ${overdueAfter}=    Get From List    ${overdueAfterList}    0
    ${outstandingBefore}=    Get From List     ${outstandingBeforeList}    0
    ${outstandingAfter}=     Get From List     ${outstandingAfterList}    0
    ${unbilledBefore}=    Get From List     ${unbilledBeforeList}    0
    ${unbilledAfter}=     Get From List     ${unbilledAfterList}    0
    ${error}=          Get From List    ${errorList}          0
    ${service}=        Get From List    ${serviceList}        0
    ${message}=        Get From List    ${messageList}        0
    ${sourceCode}=     Get From List    ${sourceCodeList}     0
    ${sourceDesc}=     Get From List    ${sourceDescList}     0
    ${sourceReason}=   Get From List    ${sourceReasonList}   0

    Log To Console    \n========== 📌 RELOAD SUMMARY ==========
    Log To Console    MSISDN: ${phoneNo}
    Log To Console    Type: ${type}
    Log To Console    Status Before: ${statusBefore}
    Log To Console    Status After: ${statusAfter}
    Log To Console    Expiry Before: ${terminationDateBefore}
    Log To Console    Expiry After: ${terminationDateAfter}
    Log To Console    \nGet Prepaid Balance 
    Log To Console    [Bef] Balance: ${balanceBefore}
    Log To Console    [Aft] Balance: ${balanceAfter}
    Log To Console    \nGet Postpaid Billing
    Log To Console    [Bef] Advance Payment: ${advanceBefore} | Overdue Payment: ${overdueBefore} | Outstanding Payment: ${outstandingBefore} | Unbilled Payment: ${unbilledBefore}
    Log To Console    [Aft] Advance Payment: ${advanceAfter} | Overdue Payment: ${overdueAfter} | Outstanding Payment: ${outstandingAfter} | Unbilled Payment: ${unbilledAfter}
    Log To Console    \nPrepaid Reload Unsuccessful
    Log To Console    Error: ${error} | Service: ${service} | Message: ${message} | Source Code: ${sourceCode}
    Log To Console    Source Description: ${sourceDesc} | Source Reason: ${sourceReason}
    Log To Console    =====================================\n

Log Reload Summary Invalid III
    [Arguments]    ${phoneNo}    ${getSubscriberProfileBeforeResponse}    ${getSubscriberPrepaidBalanceBeforeResponse}    ${getBillingInfoBeforeResponse}    ${getSubscriberProfileAfterResponse}    ${getSubscriberPrepaidBalanceAfterResponse}    ${getBillingInfoAfterResponse}    ${performPrepaidReloadUnsuccessResponse}
    ${typeList}=    Get Value From Json    ${getSubscriberProfileBeforeResponse}    $.type
    ${statusBeforeList}=    Get Value From Json    ${getSubscriberProfileBeforeResponse}    $.status
    ${statusAfterList}=    Get Value From Json    ${getSubscriberProfileAfterResponse}    $.status
    ${terminationDateBeforeList}=    Get Value From Json    ${getSubscriberProfileBeforeResponse}    $.characteristic.lifeCycleInfo.terminationDate
    ${terminationDateAfterList}=    Get Value From Json    ${getSubscriberProfileAfterResponse}    $.characteristic.lifeCycleInfo.terminationDate
    ${balanceBeforeList}=    Get Value From Json    ${getSubscriberPrepaidBalanceBeforeResponse}    $.prepaidBalance.main[0].amount
    ${balanceAfterList}=    Get Value From Json    ${getSubscriberPrepaidBalanceAfterResponse}    $.prepaidBalance.main[0].amount
    ${advanceBeforeList}=    Get Value From Json    ${getBillingInfoBeforeResponse}    $.balances.advancePayment
    ${advanceAfterList}=     Get Value From Json    ${getBillingInfoAfterResponse}    $.balances.advancePayment
    ${overdueBeforeList}=    Get Value From Json    ${getBillingInfoBeforeResponse}    $.balances.overdueAmount
    ${overdueAfterList}=     Get Value From Json    ${getBillingInfoAfterResponse}    $.balances.overdueAmount
    ${outstandingBeforeList}=    Get Value From Json    ${getBillingInfoBeforeResponse}    $.balances.outstandingAmount
    ${outstandingAfterList}=     Get Value From Json    ${getBillingInfoAfterResponse}    $.balances.outstandingAmount
    ${unbilledBeforeList}=    Get Value From Json    ${getBillingInfoBeforeResponse}    $.balances.unbilledAmount
    ${unbilledAfterList}=     Get Value From Json    ${getBillingInfoAfterResponse}    $.balances.unbilledAmount
    ${errorList}=          Get Value From Json    ${performPrepaidReloadUnsuccessResponse}    $.error
    ${serviceList}=        Get Value From Json    ${performPrepaidReloadUnsuccessResponse}    $.service
    ${messageList}=        Get Value From Json    ${performPrepaidReloadUnsuccessResponse}    $.message
    #Extract the first element from each list
    ${type}=    Get From List    ${typeList}    0
    ${statusBefore}=    Get From List    ${statusBeforeList}    0
    ${statusAfter}=     Get From List    ${statusAfterList}     0
    ${terminationDateBefore}=    Get From List    ${terminationDateBeforeList}    0
    ${terminationDateAfter}=     Get From List    ${terminationDateAfterList}     0
    ${balanceBefore}=    Get From List    ${balanceBeforeList}    0
    ${balanceAfter}=     Get From List    ${balanceAfterList}     0
    ${advanceBefore}=    Get From List    ${advanceBeforeList}    0
    ${advanceAfter}=    Get From List    ${advanceAfterList}    0
    ${overdueBefore}=    Get From List    ${overdueBeforeList}    0
    ${overdueAfter}=    Get From List    ${overdueAfterList}    0
    ${outstandingBefore}=    Get From List     ${outstandingBeforeList}    0
    ${outstandingAfter}=     Get From List     ${outstandingAfterList}    0
    ${unbilledBefore}=    Get From List     ${unbilledBeforeList}    0
    ${unbilledAfter}=     Get From List     ${unbilledAfterList}    0
    ${error}=          Get From List    ${errorList}          0
    ${service}=        Get From List    ${serviceList}        0
    ${message}=        Get From List    ${messageList}        0

    Log To Console    \n========== 📌 RELOAD SUMMARY ==========
    Log To Console    MSISDN: ${phoneNo}
    Log To Console    Type: ${type}
    Log To Console    Status Before: ${statusBefore}
    Log To Console    Status After: ${statusAfter}
    Log To Console    Expiry Before: ${terminationDateBefore}
    Log To Console    Expiry After: ${terminationDateAfter}
    Log To Console    \nGet Prepaid Balance 
    Log To Console    [Bef] Balance: ${balanceBefore}
    Log To Console    [Aft] Balance: ${balanceAfter}
    Log To Console    \nGet Postpaid Billing
    Log To Console    [Bef] Advance Payment: ${advanceBefore} | Overdue Payment: ${overdueBefore} | Outstanding Payment: ${outstandingBefore} | Unbilled Payment: ${unbilledBefore}
    Log To Console    [Aft] Advance Payment: ${advanceAfter} | Overdue Payment: ${overdueAfter} | Outstanding Payment: ${outstandingAfter} | Unbilled Payment: ${unbilledAfter}
    Log To Console    \nPrepaid Reload Unsuccessful
    Log To Console    Error: ${error} | Service: ${service} | Message: ${message}
    Log To Console    =====================================\n

Log Subscriber Invalid
    [Arguments]    ${phoneNo}    ${getSubscriberProfileNonCD}
    ${errorList}=    Get Value From Json    ${getSubscriberProfileNonCD}    $.error
    ${serviceList}=    Get Value From Json    ${getSubscriberProfileNonCD}    $.service
    ${messageList}=    Get Value From Json    ${getSubscriberProfileNonCD}    $.message
    #Extract the first element from each list
    ${error}=    Get From List    ${errorList}    0
    ${service}=    Get From List    ${serviceList}    0
    ${message}=    Get From List    ${messageList}    0

    Log To Console    \n========= ❌ SUBSCRIBER ERROR =========
    Log To Console    MSISDN: ${phoneNo}
    Log To Console    \nGet Subscriber
    Log To Console    Error: ${error}
    Log To Console    Service: ${service}
    Log To Console    Message: ${message}
    Log To Console    =====================================\n
    # [Arguments]    ${accessToken}    ${phoneNo}    ${rechargeAmount}    ${paymentMethod}
    # ${adjustmentCode}=    Generate Random String    6
    # ${headers}=    Create Dictionary    Content-Type=application/json    Authorization=${accessToken}
    # ${request_body}=    Create Dictionary
    # ...    msisdn=${phoneNo}
    # ...    paymentAmount=${rechargeAmount}
    # ...    adjustmentCode=${adjustmentCode}
    # ...    paymentMethod=${paymentMethod}
    # ...    sourceChannel=NGCA
    # Create Session    performPrepaidReload    ${BAU_MOLI_BASE_URL}    headers=${headers}    verify=true
    # ${response}=    POST On Session    performPrepaidReload    ${POST_PREPAID_PINLESS_RELOAD_PATH}    json=${request_body}
    # Should Be Equal As Numbers    ${response.status_code}    200

# Validate Reload Amount Correct
#     [Arguments]    ${BALANCE_BEFORE}    ${RECHARGE_AMOUNT}    ${BALANCE_AFTER}
#     Should Not Be Equal    ${BALANCE_BEFORE}    ${BALANCE_AFTER}
#     Log    Recharge Amount: ${RECHARGE_AMOUNT}
#     ${BALANCE_BEFORE_RECHARGE}=    Evaluate    float(${BALANCE_BEFORE}[0])
#     ${BALANCE_AFTER_RECHARGE}=    Evaluate    float(${BALANCE_AFTER}[0])
#     ${VALIDATE_AMOUNT_RECHARGE}=    Evaluate    round(${BALANCE_AFTER_RECHARGE} - ${BALANCE_BEFORE_RECHARGE}, 2)
#     Log    Calculated Recharge Amount: ${VALIDATE_AMOUNT_RECHARGE}
#     Should Be Equal As Numbers    ${VALIDATE_AMOUNT_RECHARGE}    ${RECHARGE_AMOUNT}    0.01

###########=====================NBC Reload========================#################
NBC Peform Dealer Reload
    [Arguments]    ${NBC_accessToken}    ${NBC_reloadProductId}=1350
    ${NBC_headers}=    Create Dictionary
    ...    Content-Type=application/json
    ...    X-Channel-ID=NGSA
    ...    Authorization=${NBC_accessToken}
    ${NBC_logicalResource1}=    Create Dictionary
    ...    referredType=SubscriberMSISDN
    ...    type=msisdn
    ...    value=${NBC_PREPAID_MSISDN}
    ${NBC_logicalResource2}=    Create Dictionary
    ...    referredType=NetworkMSISDN
    ...    type=msisdn
    ...    value=60220883253
    ${NBC_logicalResources}=    Create List    ${NBC_logicalResource1}    ${NBC_logicalResource2}
    ${NBC_rechargeAmount}=    Create Dictionary
    ...    value=${NBC_RELOAD_AMOUNT}
    ...    unit=MYR
    ${NBC_requestor}=    Create Dictionary
    ...    id=OWNER31322
    ...    secret=isI7wSWc82V965SbG6Rpy4Z0K2fjyv8V0vumlzgNMytY6M0OV71kojhjdq0wKuXFiAVTCIx3Pezck0OqWq7rXQ==
    ${NBC_note}=    Create Dictionary    text=
    ${NBC_request_body}=    Create Dictionary
    ...    logicalResource=${NBC_logicalResources}
    ...    rechargeType=Airtime
    ...    rechargeMethod=cash
    ...    amount=${NBC_rechargeAmount}
    ...    brandId=
    ...    productId=${NBC_reloadProductId}
    ...    productOfferingId=
    ...    requestor=${NBC_requestor}
    ...    note=${NBC_note}
    Create Session    dealerReloadSession    ${NBC_MOLI_BASE_URL}    headers=${NBC_headers}    verify=true
    ${NBC_response}=    POST On Session    dealerReloadSession    ${NBC_PREPAID_RELOAD_DEALER_WALLET}    json=${NBC_request_body}
    Should Be Equal As Integers    ${NBC_response.status_code}    200
    RETURN    ${NBC_response.json()}

NBC Peform Retail Reload
    [Arguments]    ${NBC_accessToken}    ${NBC_prepaidMSISDN}    ${NBC_rechargeAmount}    ${NBC_paymentMethod}    ${NBC_Channel}    ${NBC_rechargeType}    ${NBC_paymentID}    ${NBC_paymentRef}
    ${NBC_random_ID}=    Evaluate    random.randint(100000, 999999)    random
    ${NBC_paymentId}=    Set Variable    MOLI${NBC_random_ID}
    ${NBC_headers}=    Create Dictionary    Content-Type=application/json    Authorization=${NBC_accessToken}
    ${NBC_request_body}=    Create Dictionary
    ...    msisdn=${NBC_prepaidMSISDN}
    ...    paymentMethod=${NBC_paymentMethod}
    ...    paymentAmount=${NBC_rechargeAmount}
    ...    rechargeType=${NBC_rechargeType}
    ...    paymentID=${NBC_paymentId}
    ...    paymentRef=${NBC_paymentId}
    ...    paymentMethod=${NBC_paymentMethod}
    Create Session    performRetailPrepaidReload    ${NBC_MOLI_BASE_URL}    headers=${NBC_headers}    verify=true
    ${NBC_response}=    POST On Session    performRetailPrepaidReload    ${NBC_PREPAID_RELOAD_DEALER_WALLET}    json=${NBC_request_body}
    Should Be Equal As Numbers    ${NBC_response.status_code}    200

NBC Validate Reload Amount
    [Arguments]    ${NBC_BALANCE_BEFORE}    ${NBC_BALANCE_AFTER}    ${NBC_RECHARGE_AMOUNT}
    Should Not Be Equal    ${NBC_BALANCE_BEFORE}    ${NBC_BALANCE_AFTER}
    Log    Recharge Amount: ${NBC_RECHARGE_AMOUNT}
    ${NBC_BALANCE_BEFORE_RECHARGE}=    Evaluate    float(${NBC_BALANCE_BEFORE}[0])
    ${NBC_BALANCE_AFTER_RECHARGE}=    Evaluate    float(${NBC_BALANCE_AFTER}[0])
    ${NBC_VALIDATE_AMOUNT_RECHARGE}=    Evaluate    round(${NBC_BALANCE_AFTER_RECHARGE} - ${NBC_BALANCE_BEFORE_RECHARGE}, 2)
    Log    Calculated Recharge Amount: ${NBC_VALIDATE_AMOUNT_RECHARGE}
    Should Be Equal As Numbers    ${NBC_VALIDATE_AMOUNT_RECHARGE}    ${NBC_RECHARGE_AMOUNT}    0.01

# NBC Validate Reload Result
#     [Arguments]    ${NBC_BALANCE_BEFORE}    ${NBC_BALANCE_AFTER}    ${NBC_RECHARGE_AMOUNT}
#     # Convert values to numbers
#     ${NBC_BEFORE}=    Convert To Number    ${NBC_BALANCE_BEFORE}
#     ${NBC_AFTER}=     Convert To Number    ${NBC_BALANCE_AFTER}
#     ${NBC_AMOUNT}=    Convert To Number    ${NBC_RECHARGE_AMOUNT}
#     # Calculate difference
#     ${NBC_CALCULATED}=    Evaluate    round(${NBC_AFTER} - ${NBC_BEFORE}, 2)
#     # --- Logging (clean) ---
#     Log To Console    \nNBC MSISDN: ${NBC_PREPAID_MSISDN}
#     Log To Console    NBC Balance Before: ${NBC_BEFORE}
#     Log To Console    NBC Balance After: ${NBC_AFTER}
#     Log To Console    NBC Expected Recharge Amount: ${NBC_AMOUNT}
#     Log To Console    NBC Calculated Recharge Amount: ${NBC_CALCULATED}
#     # --- Validation ---
#     Should Not Be Equal    ${NBC_BEFORE}    ${NBC_AFTER}
#     Should Be Equal As Numbers    ${NBC_CALCULATED}    ${NBC_AMOUNT}    0.01
