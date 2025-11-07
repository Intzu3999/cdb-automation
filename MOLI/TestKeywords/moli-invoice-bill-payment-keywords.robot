*** Settings ***
Documentation    This file only share invoice bill payment keywords only

Resource    ../MOLI-testSettings.robot

*** Keywords ***

Post Perform Postpaid Bill Payment
    [Arguments]    ${accessToken}    ${phoneNo}    ${sourceChannel}    ${branchCode}    ${paymentAmount}    ${paymentMethodName}    ${code}    ${creditCardNumber}    ${operationType}    ${telco}
    ${headers}=    Create Dictionary    Content-Type=application/json    Authorization=${accessToken}
    &{paymentMethod}=    Create Dictionary    code=${code}    name=${paymentMethodName}
    ${query}=    Create Dictionary
    ...    msisdn=${phoneNo}
    ...    sourceChannel=${sourceChannel}
    ...    branchCode=${branchCode}
    ...    amount=${paymentAmount}
    ...    paymentMethod=${paymentMethod}
    ...    creditCardNumber=${creditCardNumber}
    ...    operationType=${operationType}
    #Sent Request    
    Create Session    performPostpaidBillPayment   ${BAU_MOLI3_BASE_URL}    headers=${headers}    verify=true
    ${response}=    POST On Session    performPostpaidBillPayment    ${GET_INVOICE_BILLING_PATH}${GET_INVOICE_BILLING_PATH3}${telco}    json=${query}
    Should Be Equal As Numbers    ${response.status_code}    200
    #Store Response
    ${performPostpaidBillPaymentSuccessResponse}=    Set Variable    ${response.json()}
    RETURN   ${performPostpaidBillPaymentSuccessResponse}

Post Perform Postpaid Bill Payment Negative
    [Arguments]    ${accessToken}    ${phoneNo}    ${sourceChannel}    ${branchCode}    ${paymentAmount}    ${paymentMethodName}    ${code}    ${creditCardNumber}    ${operationType}    ${telco}
    ${headers}=    Create Dictionary    Content-Type=application/json    Authorization=${accessToken}
    &{paymentMethod}=    Create Dictionary    code=${code}    name=${paymentMethodName}
    ${query}=    Create Dictionary
    ...    msisdn=${phoneNo}
    ...    sourceChannel=${sourceChannel}
    ...    branchCode=${branchCode}
    ...    amount=${paymentAmount}
    ...    paymentMethod=${paymentMethod}
    ...    creditCardNumber=${creditCardNumber}
    ...    operationType=${operationType}
    #Sent Request    
    Create Session    performPostpaidBillPayment   ${BAU_MOLI3_BASE_URL}    headers=${headers}    verify=true
    ${response}=    POST On Session    performPostpaidBillPayment    ${GET_INVOICE_BILLING_PATH}${GET_INVOICE_BILLING_PATH3}${telco}    json=${query}    expected_status=any
    Should Not Be Equal As Numbers    ${response.status_code}    200
    #Store Response
    ${performPostpaidBillPaymentUnsuccessResponse}=    Set Variable    ${response.json()}
    RETURN   ${performPostpaidBillPaymentUnsuccessResponse}

Validate Payment Amount Added or Reduced Correctly
    [Arguments]    ${getBillingInfoBeforeResponse}    ${performPostpaidBillPaymentSuccessResponse}    ${getBillingInfoAfterResponse}
    ${advanceBeforeList}=    Get Value From Json    ${getBillingInfoBeforeResponse}    $.balances.advancePayment
    ${advanceAfterList}=     Get Value From Json    ${getBillingInfoAfterResponse}    $.balances.advancePayment
    ${overdueBeforeList}=    Get Value From Json    ${getBillingInfoBeforeResponse}    $.balances.overdueAmount
    ${overdueAfterList}=     Get Value From Json    ${getBillingInfoAfterResponse}    $.balances.overdueAmount
    ${outstandingBeforeList}=    Get Value From Json    ${getBillingInfoBeforeResponse}    $.balances.outstandingAmount
    ${outstandingAfterList}=     Get Value From Json    ${getBillingInfoAfterResponse}    $.balances.outstandingAmount
    ${unbilledBeforeList}=    Get Value From Json    ${getBillingInfoBeforeResponse}    $.balances.unbilledAmount
    ${unbilledAfterList}=     Get Value From Json    ${getBillingInfoAfterResponse}    $.balances.unbilledAmount
    ${paymentAmtList}=    Get Value From Json    ${performPostpaidBillPaymentSuccessResponse}    $.paymentAmount
    #Extract the first element from each list
    ${advanceBefore}=    Get From List    ${advanceBeforeList}    0
    ${advanceAfter}=    Get From List    ${advanceAfterList}    0
    ${overdueBefore}=    Get From List    ${overdueBeforeList}    0
    ${overdueAfter}=    Get From List    ${overdueAfterList}    0
    ${outstandingBefore}=    Get From List     ${outstandingBeforeList}    0
    ${outstandingAfter}=     Get From List     ${outstandingAfterList}    0
    ${unbilledBefore}=    Get From List     ${unbilledBeforeList}    0
    ${unbilledAfter}=     Get From List     ${unbilledAfterList}    0
    ${paymentAmt}=    Get From List    ${paymentAmtList}    0
    #Calculate difference and validate
    #Case 1: Payment goes to Outstanding first
    IF    ${paymentAmt} > 0
        IF    ${paymentAmt} <= ${outstandingBefore}
            ${expectedOutstanding}=    Evaluate    round(${outstandingBefore} - ${paymentAmt}, 2)
            Should Be Equal As Numbers    ${outstandingAfter}   ${expectedOutstanding}
            Should Be Equal As Numbers    ${overdueAfter}   ${overdueBefore}
            Should Be Equal As Numbers   ${unbilledAfter}  ${unbilledBefore}
            Should Be Equal As Numbers   ${advanceAfter}   ${advanceBefore}
            Log    Case 1a: Payment deducted from Outstanding only
        ELSE
            ${remain}=    Evaluate    round(${paymentAmt} - ${outstandingBefore}, 2)
            Should Be Equal As Numbers    ${outstandingAfter}   0.0
            #Apply remaining to Overdue
            IF    ${remain} <= ${overdueBefore}
                ${expectedOverdue}=    Evaluate    round(${overdueBefore} - ${remain}, 2)
                Should Be Equal As Numbers   ${overdueAfter}   ${expectedOverdue}
                Should Be Equal As Numbers   ${unbilledAfter}  ${unbilledBefore}
                Should Be Equal As Numbers   ${advanceAfter}   ${advanceBefore}
                Log    Case 1b: Cleared Outstanding, deducted Overdue
            ELSE
                ${remain2}=    Evaluate    round(${remain} - ${overdueBefore}, 2)
                Should Be Equal As Numbers   ${overdueAfter}   0.0
                #Apply to Unbilled
                IF    ${remain2} <= ${unbilledBefore}
                    ${expectedUnbilled}=    Evaluate    round(${unbilledBefore} - ${remain2}, 2)
                    Should Be Equal As Numbers    ${unbilledAfter}   ${expectedUnbilled}
                    Should Be Equal As Numbers   ${advanceAfter}   ${advanceBefore}
                    Log    Case 1c: Cleared Outstanding + Overdue, deducted Unbilled
                ELSE
                    ${remain3}=    Evaluate    round(${remain2} - ${unbilledBefore}, 2)
                    Should Be Equal As Numbers    ${unbilledAfter}   0.0
                    ${expectedAdvance}=    Evaluate    round(${advanceBefore} + ${remain3}, 2)
                    Should Be Equal As Numbers   ${advanceAfter}   ${expectedAdvance}
                    Log    Case 1d: Cleared Outstanding + Overdue + Unbilled, remainder to Advance
                END
            END
        END

    ELSE IF    ${overdueBefore} > 0
        #Case 2: No Outstanding, pay Overdue
        IF    ${paymentAmt} <= ${overdueBefore}
            ${expectedOverdue}=    Evaluate    round(${overdueBefore} - ${paymentAmt}, 2)
            Should Be Equal As Numbers    ${overdueAfter}   ${expectedOverdue}
            Should Be Equal As Numbers    ${unbilledAfter}  ${unbilledBefore}
            Should Be Equal As Numbers   ${advanceAfter}   ${advanceBefore}
            Log    Case 2a: Payment deducted from Overdue only
        ELSE
            ${remain}=    Evaluate    round(${paymentAmt} - ${overdueBefore}, 2)
            Should Be Equal As Numbers   ${overdueAfter}   0.0
            #Apply to Unbilled
            IF    ${remain} <= ${unbilledBefore}
                ${expectedUnbilled}=    Evaluate    round(${unbilledBefore} - ${remain}, 2)
                Should Be Equal As Numbers   ${unbilledAfter}   ${expectedUnbilled}
                Should Be Equal As Numbers   ${advanceAfter}   ${advanceBefore}
                Log    Case 2b: Cleared Overdue, deducted Unbilled
            ELSE
                ${remain2}=    Evaluate    round(${remain} - ${unbilledBefore}, 2)
                Should Be Equal As Numbers   ${unbilledAfter}   0.0
                ${expectedAdvance}=    Evaluate    round(${advanceBefore} + ${remain2}, 2)
                Should Be Equal As Numbers    ${advanceAfter}   ${expectedAdvance}
                Log    Case 2c: Cleared Overdue + Unbilled, remainder to Advance
            END
        END

    ELSE IF    ${unbilledBefore} > 0
        #Case 3: No Outstanding/Overdue, pay Unbilled
        IF    ${payment} <= ${unbilledBef}
            ${expectedUnbilled}=    Evaluate    round(${unbilledBef} - ${payment}, 2)
            Should Be Equal As Numbers   ${unbilledAft}   ${expectedUnbilled}
            Should Be Equal As Numbers   ${advanceAfter}   ${advanceBefore}
            Log    Case 3a: Payment deducted from Unbilled only
        ELSE
            ${remain}=    Evaluate    round(${paymentAmt} - ${unbilledBefore}, 2)
            Should Be Equal As Numbers   ${unbilledAfter}   0.0
            ${expectedAdvance}=    Evaluate    round(${advanceBefore} + ${remain}, 2)
            Should Be Equal As Numbers   ${advanceAfter}   ${expectedAdvance}
            Log    Case 3b: Cleared Unbilled, remainder to Advance
        END

    ELSE
        #Case 4: No balances, all to Advance
        ${expectedAdvance}=    Evaluate    round(${advanceBefore} + ${paymentAmt}, 2)
        Should Be Equal As Numbers    ${advanceAfter}   ${expectedAdvance}
        Log    Case 4: Payment fully added to Advance
    END

Validate Payment Amount Amount Unchanged
    [Arguments]    ${getBillingInfoBeforeResponse}    ${getBillingInfoAfterResponse}
    ${advanceBeforeList}=    Get Value From Json    ${getBillingInfoBeforeResponse}    $.balances.advancePayment
    ${advanceAfterList}=     Get Value From Json    ${getBillingInfoAfterResponse}    $.balances.advancePayment
    ${overdueBeforeList}=    Get Value From Json    ${getBillingInfoBeforeResponse}    $.balances.overdueAmount
    ${overdueAfterList}=     Get Value From Json    ${getBillingInfoAfterResponse}    $.balances.overdueAmount
    ${outstandingBeforeList}=    Get Value From Json    ${getBillingInfoBeforeResponse}    $.balances.outstandingAmount
    ${outstandingAfterList}=     Get Value From Json    ${getBillingInfoAfterResponse}    $.balances.outstandingAmount
    ${unbilledBeforeList}=    Get Value From Json    ${getBillingInfoBeforeResponse}    $.balances.unbilledAmount
    ${unbilledAfterList}=     Get Value From Json    ${getBillingInfoAfterResponse}    $.balances.unbilledAmount
    #Extract the first element from each list
    ${advanceBefore}=    Get From List    ${advanceBeforeList}    0
    ${advanceAfter}=    Get From List    ${advanceAfterList}    0
    ${overdueBefore}=    Get From List    ${overdueBeforeList}    0
    ${overdueAfter}=    Get From List    ${overdueAfterList}    0
    ${outstandingBefore}=    Get From List     ${outstandingBeforeList}    0
    ${outstandingAfter}=     Get From List     ${outstandingAfterList}    0
    ${unbilledBefore}=    Get From List     ${unbilledBeforeList}    0
    ${unbilledAfter}=     Get From List     ${unbilledAfterList}    0
    #Calculate difference
    ${expectedPaymentAdvance}=    Evaluate    format(float(${advanceAfter}) - float(${advanceBefore}), ".2f")
    Should Be Equal As Numbers    ${expectedPaymentAdvance}   0.00
    ${expectedPaymentOverdue}=    Evaluate    format(float(${overdueAfter}) - float(${overdueBefore}), ".2f")
    Should Be Equal As Numbers    ${expectedPaymentOverdue}   0.00
    ${expectedPaymentOutstanding}=    Evaluate    format(float(${outstandingAfter}) - float(${outstandingBefore}), ".2f")
    Should Be Equal As Numbers    ${expectedPaymentOutstanding}   0.00
    ${expectedPaymentUnbilled}=    Evaluate    format(float(${unbilledAfter}) - float(${unbilledBefore}), ".2f")
    Should Be Equal As Numbers    ${expectedPaymentOverdue}   0.00
    Should Be Equal    ${advanceBefore}    ${advanceAfter}
    Should Be Equal    ${overdueBefore}    ${overdueAfter}
    Should Be Equal    ${outstandingBefore}    ${outstandingAfter}
    Should Be Equal    ${unbilledBefore}    ${unbilledAfter}

Validate Postpaid Lifecycle Active
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
    # Validate Termination Date remains at longest 2099-12-31T23:59:59 for POSTPAID
    Should Be Equal As Strings    ${terminationDateBefore}    ${terminationDateAfter}    

Validate Postpaid Lifecycle Updated From Barred To Active
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
    # Validate Termination Date remains at longest 2099-12-31T23:59:59 for POSTPAID
    Should Be Equal As Strings    ${terminationDateBefore}    ${terminationDateAfter}    

Validate Postpaid Lifecycle Suspended
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

Validate Postpaid Lifecycle Deactivated
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

Validate Prepaid Lifecycle
    [Arguments]    ${getSubscriberProfileBeforeResponse}    ${getSubscriberProfileAfterResponse}
    ${typeBeforeList}=    Get Value From Json    ${getSubscriberProfileBeforeResponse}    $.type
    ${typeAfterList}=    Get Value From Json    ${getSubscriberProfileAfterResponse}    $.type
    #Extract the first element from each list
    ${typeBefore}=    Get From List    ${typeBeforeList}    0
    ${typeAfter}=     Get From List    ${typeAfterList}     0
    # Validate type is Postpaid
    Should Be Equal As Strings    ${typeBefore}    PREPAID
    Should Be Equal As Strings    ${typeAfter}     PREPAID
    # Validate type remains
    Should Be Equal As Strings    ${typeBefore}    ${typeAfter}

Log Bill Payment Summary
    [Arguments]        ${phoneNo}    ${getSubscriberProfileBeforeResponse}    ${getBillingInfoBeforeResponse}    ${performPostpaidBillPaymentSuccessResponse}    ${getSubscriberProfileAfterResponse}    ${getBillingInfoAfterResponse}    ${getBillPaymentHistoryResponse}     
    ${typeList}=    Get Value From Json    ${getSubscriberProfileBeforeResponse}    $.type
    ${statusBeforeList}=    Get Value From Json    ${getSubscriberProfileBeforeResponse}    $.status
    ${statusAfterList}=    Get Value From Json    ${getSubscriberProfileAfterResponse}    $.status
    ${terminationDateBeforeList}=    Get Value From Json    ${getSubscriberProfileBeforeResponse}    $.characteristic.lifeCycleInfo.terminationDate
    ${terminationDateAfterList}=    Get Value From Json    ${getSubscriberProfileAfterResponse}    $.characteristic.lifeCycleInfo.terminationDate
    ${advanceBeforeList}=    Get Value From Json    ${getBillingInfoBeforeResponse}    $.balances.advancePayment
    ${advanceAfterList}=     Get Value From Json    ${getBillingInfoAfterResponse}    $.balances.advancePayment
    ${overdueBeforeList}=    Get Value From Json    ${getBillingInfoBeforeResponse}    $.balances.overdueAmount
    ${overdueAfterList}=     Get Value From Json    ${getBillingInfoAfterResponse}    $.balances.overdueAmount
    ${outstandingBeforeList}=    Get Value From Json    ${getBillingInfoBeforeResponse}    $.balances.outstandingAmount
    ${outstandingAfterList}=     Get Value From Json    ${getBillingInfoAfterResponse}    $.balances.outstandingAmount
    ${unbilledBeforeList}=    Get Value From Json    ${getBillingInfoBeforeResponse}    $.balances.unbilledAmount
    ${unbilledAfterList}=     Get Value From Json    ${getBillingInfoAfterResponse}    $.balances.unbilledAmount
    ${txnIdList}=    Get Value From Json    ${performPostpaidBillPaymentSuccessResponse}    $.transactionId
    ${paymentAmtList}=    Get Value From Json    ${performPostpaidBillPaymentSuccessResponse}    $.paymentAmount
    ${txnDateList}=        Get Value From Json    ${getBillPaymentHistoryResponse}    $.paymentHistory[*].transactionDate
    ${amountList}=         Get Value From Json    ${getBillPaymentHistoryResponse}    $.paymentHistory[*].value.amount
    #Extract the first element from each list
    ${type}=    Get From List    ${typeList}    0
    ${statusBefore}=    Get From List    ${statusBeforeList}    0
    ${statusAfter}=     Get From List    ${statusAfterList}     0
    ${terminationDateBefore}=    Get From List    ${terminationDateBeforeList}    0
    ${terminationDateAfter}=     Get From List    ${terminationDateAfterList}     0
    ${advanceBefore}=    Get From List    ${advanceBeforeList}    0
    ${advanceAfter}=    Get From List    ${advanceAfterList}    0
    ${overdueBefore}=    Get From List    ${overdueBeforeList}    0
    ${overdueAfter}=    Get From List    ${overdueAfterList}    0
    ${outstandingBefore}=    Get From List     ${outstandingBeforeList}    0
    ${outstandingAfter}=     Get From List     ${outstandingAfterList}    0
    ${unbilledBefore}=    Get From List     ${unbilledBeforeList}    0
    ${unbilledAfter}=     Get From List     ${unbilledAfterList}    0
    ${txnId}=    Get From List    ${txnIdList}    0
    ${paymentAmt}=    Get From List    ${paymentAmtList}    0
    ${txnDate}=    Get From List    ${txnDateList}    0

    Log To Console    \n========== 📌 BILL PAYMENT SUMMARY ==========
    Log To Console    MSISDN: ${phoneNo}
    Log To Console    Type: ${type}
    Log To Console    Txn Date: ${txnDate}
    Log To Console    Txn ID: ${txnId}
    Log To Console    Total Payment: ${paymentAmt}
    Log To Console    Status Before: ${statusBefore}
    Log To Console    Status After: ${statusAfter}
    Log To Console    Expiry Before: ${terminationDateBefore}
    Log To Console    Expiry After: ${terminationDateAfter}
    Log To Console    \nGet Postpaid Billing
    Log To Console    [Bef] Advance Payment: ${advanceBefore} | Overdue Payment: ${overdueBefore} | Outstanding Payment: ${outstandingBefore} | Unbilled Payment: ${unbilledBefore}
    Log To Console    [Aft] Advance Payment: ${advanceAfter} | Overdue Payment: ${overdueAfter} | Outstanding Payment: ${outstandingAfter} | Unbilled Payment: ${unbilledAfter}
    Log To Console    ============================================\n

Log Bill Payment Summary II
    [Arguments]    ${phoneNo}    ${getSubscriberProfileBeforeResponse}    ${getSubscriberPrepaidBalanceBeforeResponse}    ${getBillingInfoBeforeUnsuccessfulResponse}    ${getSubscriberProfileAfterResponse}    ${getSubscriberPrepaidBalanceAfterResponse}    ${getBillingInfoAfterUnsuccessfulResponse}    ${performPostpaidBillPaymentSuccessResponse}    ${getReloadHistoryResponse}   
    ${typeList}=    Get Value From Json    ${getSubscriberProfileBeforeResponse}    $.type
    ${statusBeforeList}=    Get Value From Json    ${getSubscriberProfileBeforeResponse}    $.status
    ${statusAfterList}=    Get Value From Json    ${getSubscriberProfileAfterResponse}    $.status
    ${terminationDateBeforeList}=    Get Value From Json    ${getSubscriberProfileBeforeResponse}    $.characteristic.lifeCycleInfo.terminationDate
    ${terminationDateAfterList}=    Get Value From Json    ${getSubscriberProfileAfterResponse}    $.characteristic.lifeCycleInfo.terminationDate
    ${balanceBeforeList}=    Get Value From Json    ${getSubscriberPrepaidBalanceBeforeResponse}    $.prepaidBalance.main[0].amount
    ${balanceAfterList}=    Get Value From Json    ${getSubscriberPrepaidBalanceAfterResponse}    $.prepaidBalance.main[0].amount
    ${errorList}=    Get Value From Json    ${getBillingInfoBeforeUnsuccessfulResponse}    $.error
    ${serviceList}=    Get Value From Json    ${getBillingInfoBeforeUnsuccessfulResponse}    $.service
    ${messageList}=      Get Value From Json    ${getBillingInfoBeforeUnsuccessfulResponse}    $.message
    ${sourceCodeList}=        Get Value From Json    ${getBillingInfoBeforeUnsuccessfulResponse}    $.source.code
    ${sourceDescList}=         Get Value From Json    ${getBillingInfoBeforeUnsuccessfulResponse}    $.source.description
    ${sourceReasonList}=         Get Value From Json    ${getBillingInfoBeforeUnsuccessfulResponse}    $.source.reason
    ${error2List}=    Get Value From Json    ${getBillingInfoAfterUnsuccessfulResponse}    $.error
    ${service2List}=    Get Value From Json    ${getBillingInfoAfterUnsuccessfulResponse}    $.service
    ${message2List}=      Get Value From Json    ${getBillingInfoAfterUnsuccessfulResponse}    $.message
    ${sourceCode2List}=        Get Value From Json    ${getBillingInfoAfterUnsuccessfulResponse}    $.source.code
    ${sourceDesc2List}=         Get Value From Json    ${getBillingInfoAfterUnsuccessfulResponse}    $.source.description
    ${sourceReason2List}=         Get Value From Json    ${getBillingInfoAfterUnsuccessfulResponse}    $.source.reason
    ${txnIdList}=    Get Value From Json    ${performPostpaidBillPaymentSuccessResponse}    $.transactionId
    ${paymentAmtList}=    Get Value From Json    ${performPostpaidBillPaymentSuccessResponse}    $.paymentAmount
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
    ${error}=    Get From List    ${errorList}    0
    ${service}=    Get From List    ${serviceList}    0
    ${message}=    Get From List    ${messageList}      0
    ${sourceCode}=    Get From List    ${sourceCodeList}    0
    ${sourceDesc}=    Get From List    ${sourceDescList}    0
    ${sourceReason}=    Get From List    ${sourceReasonList}    0
    ${error2}=    Get From List    ${error2List}    0
    ${service2}=    Get From List    ${service2List}    0
    ${message2}=    Get From List    ${message2List}      0
    ${sourceCode2}=    Get From List    ${sourceCode2List}    0
    ${sourceDesc2}=    Get From List    ${sourceDesc2List}    0
    ${sourceReason2}=    Get From List    ${sourceReason2List}    0
    ${txnId}=    Get From List    ${txnIdList}    0
    ${paymentAmt}=      Get From List    ${paymentAmtList}      0
    ${txnDate}=    Get From List    ${txnDateList}    0
    ${amount}=    Get From List    ${amountList}    0
    ${taxAmount}=    Get From List    ${taxAmountList}    0


    Log To Console    \n========== 📌 BILL PAYMENT SUMMARY ==========
    Log To Console    MSISDN: ${phoneNo}
    Log To Console    Type: ${type}
    Log To Console    Txn Date: ${txnDate}
    Log To Console    Txn ID: ${txnId}
    Log To Console    Amount: ${amount}
    Log To Console    Tax Amount: ${taxAmount}
    Log To Console    Total Reload (Amount + Tax): ${paymentAmt}
    Log To Console    Status Before: ${statusBefore}
    Log To Console    Status After: ${statusAfter}
    Log To Console    Expiry Before: ${terminationDateBefore}
    Log To Console    Expiry After: ${terminationDateAfter}
    Log To Console    \nGet Prepaid Balance 
    Log To Console    [Bef] Balance: ${balanceBefore}
    Log To Console    [Aft] Balance: ${balanceAfter}
    Log To Console    \nGet Postpaid Billing
    Log To Console    [Bef] Error: ${error} | Service: ${service} | Message: ${message} | Source Code: ${sourceCode} | Source Description: ${sourceDesc} | Source Reason: ${sourceReason}
    Log To Console    [Aft] Error: ${error2} | Service: ${service2} | Message: ${message2} | Source Code: ${sourceCode2} | Source Description: ${sourceDesc2} | Source Reason: ${sourceReason2}
    Log To Console    \nPostpaid Bill Payment Successful but credited to Prepaid Balance
    Log To Console    ============================================\n

Log Bill Payment Summary Invalid
    [Arguments]        ${phoneNo}    ${getSubscriberProfileBeforeResponse}    ${getSubscriberPrepaidBalanceBeforeResponse}    ${getBillingInfoBeforeResponse}    ${getSubscriberProfileAfterResponse}    ${getSubscriberPrepaidBalanceAfterResponse}    ${getBillingInfoAfterResponse}    ${performPostpaidBillPaymentUnsuccessResponse}   
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
    ${errorList}=    Get Value From Json    ${performPostpaidBillPaymentUnsuccessResponse}    $.error
    ${serviceList}=    Get Value From Json    ${performPostpaidBillPaymentUnsuccessResponse}    $.service
    ${messageList}=      Get Value From Json    ${performPostpaidBillPaymentUnsuccessResponse}    $.message
    ${sourceCodeList}=        Get Value From Json    ${performPostpaidBillPaymentUnsuccessResponse}    $.source.code
    ${sourceDescList}=         Get Value From Json    ${performPostpaidBillPaymentUnsuccessResponse}    $.source.description
    ${sourceReasonList}=         Get Value From Json    ${performPostpaidBillPaymentUnsuccessResponse}    $.source.reason
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
    ${error}=    Get From List    ${errorList}    0
    ${service}=    Get From List    ${serviceList}    0
    ${message}=    Get From List    ${messageList}      0
    ${sourceCode}=    Get From List    ${sourceCodeList}    0
    ${sourceDesc}=    Get From List    ${sourceDescList}    0
    ${sourceReason}=    Get From List    ${sourceReasonList}    0

    Log To Console    \n========== 📌 BILL PAYMENT SUMMARY ==========
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
    Log To Console    \nPostpaid Bill Payment Unsuccessful
    Log To Console    Error: ${error} | Service: ${service} | Message: ${message} | Source Code: ${sourceCode}
    Log To Console    Source Description: ${sourceDesc} | Source Reason: ${sourceReason}
    Log To Console    ============================================\n

