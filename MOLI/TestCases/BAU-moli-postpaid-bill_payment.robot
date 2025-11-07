*** Settings ***
Documentation    This file only store testcases for BAU Moli Bill Payment

# Resource    ../MOLI-testSettings.robot
Resource    ../TestKeywords/all_keywords.robot

*** Test Cases ***

# DIGI BILL PAYMENT TEST CASES #
Test Case 1: Bill Payment Using Cash [DIGI]
    [Tags]    smoke    sanity    regression
    ${accessToken}    Generate Access Token BAU
    ${getSubscriberProfileBeforeResponse}    Get Subscriber Profile Before    ${accessToken}    ${BAU_DIGI_POSTPAID_MSISDN}
    ${getBillingInfoBeforeResponse}    Get Billing Info Before    ${accessToken}    ${BAU_DIGI_POSTPAID_MSISDN}
    ${performPostpaidBillPaymentSuccessResponse}    Post Perform Postpaid Bill Payment    ${accessToken}    ${BAU_DIGI_POSTPAID_MSISDN}    sourceChannel=NGCA    branchCode=R0001-B0001    paymentAmount=0.11    paymentMethodName=Cash    code=123    creditCardNumber=5105105105105100    operationType=1    telco=${DIGITELCO}
    ${getSubscriberProfileAfterResponse}    Get Subscriber Profile After    ${accessToken}    ${BAU_DIGI_POSTPAID_MSISDN}
    ${getBillingInfoAfterResponse}    Get Billing Info After    ${accessToken}    ${BAU_DIGI_POSTPAID_MSISDN}
    Validate Payment Amount Added or Reduced Correctly   ${getBillingInfoBeforeResponse}    ${performPostpaidBillPaymentSuccessResponse}    ${getBillingInfoAfterResponse}    
    Validate Postpaid Lifecycle Active    ${getSubscriberProfileBeforeResponse}    ${getSubscriberProfileAfterResponse}
    ${getBillPaymentHistoryResponse}    Get Bill Payment History    ${accessToken}    ${BAU_DIGI_POSTPAID_MSISDN}
    Validate Bill Payment History    ${performPostpaidBillPaymentSuccessResponse}    ${getBillPaymentHistoryResponse}
    Log Bill Payment Summary    ${BAU_DIGI_POSTPAID_MSISDN}    ${getSubscriberProfileBeforeResponse}    ${getBillingInfoBeforeResponse}    ${performPostpaidBillPaymentSuccessResponse}    ${getSubscriberProfileAfterResponse}    ${getBillingInfoAfterResponse}    ${getBillPaymentHistoryResponse}
Test Case 2: Bill Payment Using OnlineBanking [DIGI]
    [Tags]    sanity    regression
    ${accessToken}    Generate Access Token BAU
    ${getSubscriberProfileBeforeResponse}    Get Subscriber Profile Before    ${accessToken}    ${BAU_DIGI_POSTPAID_MSISDN}
    ${getBillingInfoBeforeResponse}    Get Billing Info Before    ${accessToken}    ${BAU_DIGI_POSTPAID_MSISDN}
    ${performPostpaidBillPaymentSuccessResponse}    Post Perform Postpaid Bill Payment    ${accessToken}    ${BAU_DIGI_POSTPAID_MSISDN}    sourceChannel=NGCA    branchCode=PSFPX    paymentAmount=0.12    paymentMethodName=OnlineBanking    code=1751    creditCardNumber=5105105105105100    operationType=1    telco=${DIGITELCO}
    ${getSubscriberProfileAfterResponse}    Get Subscriber Profile After    ${accessToken}    ${BAU_DIGI_POSTPAID_MSISDN}
    ${getBillingInfoAfterResponse}    Get Billing Info After    ${accessToken}    ${BAU_DIGI_POSTPAID_MSISDN}
    Validate Payment Amount Added or Reduced Correctly   ${getBillingInfoBeforeResponse}    ${performPostpaidBillPaymentSuccessResponse}    ${getBillingInfoAfterResponse}    
    Validate Postpaid Lifecycle Active    ${getSubscriberProfileBeforeResponse}    ${getSubscriberProfileAfterResponse}
    ${getBillPaymentHistoryResponse}    Get Bill Payment History    ${accessToken}    ${BAU_DIGI_POSTPAID_MSISDN}
    Validate Bill Payment History    ${performPostpaidBillPaymentSuccessResponse}    ${getBillPaymentHistoryResponse}
    Log Bill Payment Summary    ${BAU_DIGI_POSTPAID_MSISDN}    ${getSubscriberProfileBeforeResponse}    ${getBillingInfoBeforeResponse}    ${performPostpaidBillPaymentSuccessResponse}    ${getSubscriberProfileAfterResponse}    ${getBillingInfoAfterResponse}    ${getBillPaymentHistoryResponse}
Test Case 3: Bill Payment Using CreditCard - AMEX [DIGI]
    [Tags]    sanity    regression
    ${accessToken}    Generate Access Token BAU
    ${getSubscriberProfileBeforeResponse}    Get Subscriber Profile Before    ${accessToken}    ${BAU_DIGI_POSTPAID_MSISDN}
    ${getBillingInfoBeforeResponse}    Get Billing Info Before    ${accessToken}    ${BAU_DIGI_POSTPAID_MSISDN}
    ${performPostpaidBillPaymentSuccessResponse}    Post Perform Postpaid Bill Payment    ${accessToken}    ${BAU_DIGI_POSTPAID_MSISDN}    sourceChannel=NGCA    branchCode=PSFPX    paymentAmount=0.13    paymentMethodName=OnlineBanking    code=1751    creditCardNumber=5105105105105100    operationType=1    telco=${DIGITELCO}
    ${getSubscriberProfileAfterResponse}    Get Subscriber Profile After    ${accessToken}    ${BAU_DIGI_POSTPAID_MSISDN}
    ${getBillingInfoAfterResponse}    Get Billing Info After    ${accessToken}    ${BAU_DIGI_POSTPAID_MSISDN}
    Validate Payment Amount Added or Reduced Correctly   ${getBillingInfoBeforeResponse}    ${performPostpaidBillPaymentSuccessResponse}    ${getBillingInfoAfterResponse}    
    Validate Postpaid Lifecycle Active    ${getSubscriberProfileBeforeResponse}    ${getSubscriberProfileAfterResponse}
    ${getBillPaymentHistoryResponse}    Get Bill Payment History    ${accessToken}    ${BAU_DIGI_POSTPAID_MSISDN}
    Validate Bill Payment History    ${performPostpaidBillPaymentSuccessResponse}    ${getBillPaymentHistoryResponse}
    Log Bill Payment Summary    ${BAU_DIGI_POSTPAID_MSISDN}    ${getSubscriberProfileBeforeResponse}    ${getBillingInfoBeforeResponse}    ${performPostpaidBillPaymentSuccessResponse}    ${getSubscriberProfileAfterResponse}    ${getBillingInfoAfterResponse}    ${getBillPaymentHistoryResponse}
Test Case 4: Bill Payment Using CreditCard - MasterCard [DIGI]
    [Tags]    sanity    regression  
    ${accessToken}    Generate Access Token BAU
    ${getSubscriberProfileBeforeResponse}    Get Subscriber Profile Before    ${accessToken}    ${BAU_DIGI_POSTPAID_MSISDN}
    ${getBillingInfoBeforeResponse}    Get Billing Info Before    ${accessToken}    ${BAU_DIGI_POSTPAID_MSISDN}
    ${performPostpaidBillPaymentSuccessResponse}    Post Perform Postpaid Bill Payment    ${accessToken}    ${BAU_DIGI_POSTPAID_MSISDN}    sourceChannel=NGCA    branchCode=PSMBBCC    paymentAmount=0.14    paymentMethodName=MasterCard    code=1750    creditCardNumber=5105105105105100    operationType=1    telco=${DIGITELCO}
    ${getSubscriberProfileAfterResponse}    Get Subscriber Profile After    ${accessToken}    ${BAU_DIGI_POSTPAID_MSISDN}
    ${getBillingInfoAfterResponse}    Get Billing Info After    ${accessToken}    ${BAU_DIGI_POSTPAID_MSISDN}
    Validate Payment Amount Added or Reduced Correctly   ${getBillingInfoBeforeResponse}    ${performPostpaidBillPaymentSuccessResponse}    ${getBillingInfoAfterResponse}    
    Validate Postpaid Lifecycle Active    ${getSubscriberProfileBeforeResponse}    ${getSubscriberProfileAfterResponse}
    ${getBillPaymentHistoryResponse}    Get Bill Payment History    ${accessToken}    ${BAU_DIGI_POSTPAID_MSISDN}
    Validate Bill Payment History    ${performPostpaidBillPaymentSuccessResponse}    ${getBillPaymentHistoryResponse}
    Log Bill Payment Summary    ${BAU_DIGI_POSTPAID_MSISDN}    ${getSubscriberProfileBeforeResponse}    ${getBillingInfoBeforeResponse}    ${performPostpaidBillPaymentSuccessResponse}    ${getSubscriberProfileAfterResponse}    ${getBillingInfoAfterResponse}    ${getBillPaymentHistoryResponse}
Test Case 5: Bill Payment Using CreditCard - VISA [DIGI]
    [Tags]    sanity    regression
    ${accessToken}    Generate Access Token BAU
    ${getSubscriberProfileBeforeResponse}    Get Subscriber Profile Before    ${accessToken}    ${BAU_DIGI_POSTPAID_MSISDN}
    ${getBillingInfoBeforeResponse}    Get Billing Info Before    ${accessToken}    ${BAU_DIGI_POSTPAID_MSISDN}
    ${performPostpaidBillPaymentSuccessResponse}    Post Perform Postpaid Bill Payment    ${accessToken}    ${BAU_DIGI_POSTPAID_MSISDN}    sourceChannel=NGCA    branchCode=PSMBBCC    paymentAmount=0.15    paymentMethodName=VISA    code=1750    creditCardNumber=5105105105105100    operationType=1    telco=${DIGITELCO}
    ${getSubscriberProfileAfterResponse}    Get Subscriber Profile After    ${accessToken}    ${BAU_DIGI_POSTPAID_MSISDN}
    ${getBillingInfoAfterResponse}    Get Billing Info After    ${accessToken}    ${BAU_DIGI_POSTPAID_MSISDN}
    Validate Payment Amount Added or Reduced Correctly   ${getBillingInfoBeforeResponse}    ${performPostpaidBillPaymentSuccessResponse}    ${getBillingInfoAfterResponse}    
    Validate Postpaid Lifecycle Active    ${getSubscriberProfileBeforeResponse}    ${getSubscriberProfileAfterResponse}
    ${getBillPaymentHistoryResponse}    Get Bill Payment History    ${accessToken}    ${BAU_DIGI_POSTPAID_MSISDN}
    Validate Bill Payment History    ${performPostpaidBillPaymentSuccessResponse}    ${getBillPaymentHistoryResponse}
    Log Bill Payment Summary    ${BAU_DIGI_POSTPAID_MSISDN}    ${getSubscriberProfileBeforeResponse}    ${getBillingInfoBeforeResponse}    ${performPostpaidBillPaymentSuccessResponse}    ${getSubscriberProfileAfterResponse}    ${getBillingInfoAfterResponse}    ${getBillPaymentHistoryResponse}
Test Case 6: Bill Payment Using eWallet - TouchNGo [DIGI]
    [Tags]    sanity    regression
    ${accessToken}    Generate Access Token BAU
    ${getSubscriberProfileBeforeResponse}    Get Subscriber Profile Before    ${accessToken}    ${BAU_DIGI_POSTPAID_MSISDN}
    ${getBillingInfoBeforeResponse}    Get Billing Info Before    ${accessToken}    ${BAU_DIGI_POSTPAID_MSISDN}
    ${performPostpaidBillPaymentSuccessResponse}    Post Perform Postpaid Bill Payment    ${accessToken}    ${BAU_DIGI_POSTPAID_MSISDN}    sourceChannel=NGCA    branchCode=PSEWTnG    paymentAmount=0.16    paymentMethodName=TouchNGo    code=1752    creditCardNumber=5105105105105100    operationType=1    telco=${DIGITELCO}
    ${getSubscriberProfileAfterResponse}    Get Subscriber Profile After    ${accessToken}    ${BAU_DIGI_POSTPAID_MSISDN}
    ${getBillingInfoAfterResponse}    Get Billing Info After    ${accessToken}    ${BAU_DIGI_POSTPAID_MSISDN}
    Validate Payment Amount Added or Reduced Correctly   ${getBillingInfoBeforeResponse}    ${performPostpaidBillPaymentSuccessResponse}    ${getBillingInfoAfterResponse}    
    Validate Postpaid Lifecycle Active    ${getSubscriberProfileBeforeResponse}    ${getSubscriberProfileAfterResponse}
    ${getBillPaymentHistoryResponse}    Get Bill Payment History    ${accessToken}    ${BAU_DIGI_POSTPAID_MSISDN}
    Validate Bill Payment History    ${performPostpaidBillPaymentSuccessResponse}    ${getBillPaymentHistoryResponse}
    Log Bill Payment Summary    ${BAU_DIGI_POSTPAID_MSISDN}    ${getSubscriberProfileBeforeResponse}    ${getBillingInfoBeforeResponse}    ${performPostpaidBillPaymentSuccessResponse}    ${getSubscriberProfileAfterResponse}    ${getBillingInfoAfterResponse}    ${getBillPaymentHistoryResponse}
Test Case 7: Bill Payment Using eWallet - GrabPay [DIGI]
    [Tags]    sanity    regression  
    ${accessToken}    Generate Access Token BAU
    ${getSubscriberProfileBeforeResponse}    Get Subscriber Profile Before    ${accessToken}    ${BAU_DIGI_POSTPAID_MSISDN}
    ${getBillingInfoBeforeResponse}    Get Billing Info Before    ${accessToken}    ${BAU_DIGI_POSTPAID_MSISDN}
    ${performPostpaidBillPaymentSuccessResponse}    Post Perform Postpaid Bill Payment    ${accessToken}    ${BAU_DIGI_POSTPAID_MSISDN}    sourceChannel=NGCA    branchCode=PSEWGRBP    paymentAmount=0.17    paymentMethodName=GrabPay    code=1753    creditCardNumber=5105105105105100    operationType=1    telco=${DIGITELCO}
    ${getSubscriberProfileAfterResponse}    Get Subscriber Profile After    ${accessToken}    ${BAU_DIGI_POSTPAID_MSISDN}
    ${getBillingInfoAfterResponse}    Get Billing Info After    ${accessToken}    ${BAU_DIGI_POSTPAID_MSISDN}
    Validate Payment Amount Added or Reduced Correctly   ${getBillingInfoBeforeResponse}    ${performPostpaidBillPaymentSuccessResponse}    ${getBillingInfoAfterResponse}    
    Validate Postpaid Lifecycle Active    ${getSubscriberProfileBeforeResponse}    ${getSubscriberProfileAfterResponse}
    ${getBillPaymentHistoryResponse}    Get Bill Payment History    ${accessToken}    ${BAU_DIGI_POSTPAID_MSISDN}
    Validate Bill Payment History    ${performPostpaidBillPaymentSuccessResponse}    ${getBillPaymentHistoryResponse}
    Log Bill Payment Summary    ${BAU_DIGI_POSTPAID_MSISDN}    ${getSubscriberProfileBeforeResponse}    ${getBillingInfoBeforeResponse}    ${performPostpaidBillPaymentSuccessResponse}    ${getSubscriberProfileAfterResponse}    ${getBillingInfoAfterResponse}    ${getBillPaymentHistoryResponse}
Test Case 8: Bill Payment Using eWallet - ShopeePay [DIGI]
    [Tags]    sanity    regression
    ${accessToken}    Generate Access Token BAU
    ${getSubscriberProfileBeforeResponse}    Get Subscriber Profile Before    ${accessToken}    ${BAU_DIGI_POSTPAID_MSISDN}
    ${getBillingInfoBeforeResponse}    Get Billing Info Before    ${accessToken}    ${BAU_DIGI_POSTPAID_MSISDN}
    ${performPostpaidBillPaymentSuccessResponse}    Post Perform Postpaid Bill Payment    ${accessToken}    ${BAU_DIGI_POSTPAID_MSISDN}    sourceChannel=NGCA    branchCode=PSSHPE    paymentAmount=0.18    paymentMethodName=ShopeePay    code=1754    creditCardNumber=5105105105105100    operationType=1    telco=${DIGITELCO}
    ${getSubscriberProfileAfterResponse}    Get Subscriber Profile After    ${accessToken}    ${BAU_DIGI_POSTPAID_MSISDN}
    ${getBillingInfoAfterResponse}    Get Billing Info After    ${accessToken}    ${BAU_DIGI_POSTPAID_MSISDN}
    Validate Payment Amount Added or Reduced Correctly   ${getBillingInfoBeforeResponse}    ${performPostpaidBillPaymentSuccessResponse}    ${getBillingInfoAfterResponse}    
    Validate Postpaid Lifecycle Active    ${getSubscriberProfileBeforeResponse}    ${getSubscriberProfileAfterResponse}
    ${getBillPaymentHistoryResponse}    Get Bill Payment History    ${accessToken}    ${BAU_DIGI_POSTPAID_MSISDN}
    Validate Bill Payment History    ${performPostpaidBillPaymentSuccessResponse}    ${getBillPaymentHistoryResponse}
    Log Bill Payment Summary    ${BAU_DIGI_POSTPAID_MSISDN}    ${getSubscriberProfileBeforeResponse}    ${getBillingInfoBeforeResponse}    ${performPostpaidBillPaymentSuccessResponse}    ${getSubscriberProfileAfterResponse}    ${getBillingInfoAfterResponse}    ${getBillPaymentHistoryResponse}
Test Case 9: Bill Payment Using eWallet - Boost [DIGI]
    [Tags]    sanity    regression
    ${accessToken}    Generate Access Token BAU
    ${getSubscriberProfileBeforeResponse}    Get Subscriber Profile Before    ${accessToken}    ${BAU_DIGI_POSTPAID_MSISDN}
    ${getBillingInfoBeforeResponse}    Get Billing Info Before    ${accessToken}    ${BAU_DIGI_POSTPAID_MSISDN}
    ${performPostpaidBillPaymentSuccessResponse}    Post Perform Postpaid Bill Payment    ${accessToken}    ${BAU_DIGI_POSTPAID_MSISDN}    sourceChannel=NGCA    branchCode=PSSHPE    paymentAmount=0.19    paymentMethodName=Boost    code=1755    creditCardNumber=5105105105105100    operationType=1    telco=${DIGITELCO}
    ${getSubscriberProfileAfterResponse}    Get Subscriber Profile After    ${accessToken}    ${BAU_DIGI_POSTPAID_MSISDN}
    ${getBillingInfoAfterResponse}    Get Billing Info After    ${accessToken}    ${BAU_DIGI_POSTPAID_MSISDN}
    Validate Payment Amount Added or Reduced Correctly   ${getBillingInfoBeforeResponse}    ${performPostpaidBillPaymentSuccessResponse}    ${getBillingInfoAfterResponse}    
    Validate Postpaid Lifecycle Active    ${getSubscriberProfileBeforeResponse}    ${getSubscriberProfileAfterResponse}
    ${getBillPaymentHistoryResponse}    Get Bill Payment History    ${accessToken}    ${BAU_DIGI_POSTPAID_MSISDN}
    Validate Bill Payment History    ${performPostpaidBillPaymentSuccessResponse}    ${getBillPaymentHistoryResponse}
    Log Bill Payment Summary    ${BAU_DIGI_POSTPAID_MSISDN}    ${getSubscriberProfileBeforeResponse}    ${getBillingInfoBeforeResponse}    ${performPostpaidBillPaymentSuccessResponse}    ${getSubscriberProfileAfterResponse}    ${getBillingInfoAfterResponse}    ${getBillPaymentHistoryResponse}


# CELCOM BILL PAYMENT TEST CASES #
Test Case 10: Bill Payment Using Cash [CELCOM]
    [Tags]    smoke    sanity    regression
    ${accessToken}    Generate Access Token BAU    #note: https://celcomdigi.atlassian.net/browse/MOLI-2165
    ${getSubscriberProfileBeforeResponse}    Get Subscriber Profile Before    ${accessToken}    ${BAU_CELCOM_POSTPAID_MSISDN}
    ${getBillingInfoBeforeResponse}    Get Billing Info Before    ${accessToken}    ${BAU_CELCOM_POSTPAID_MSISDN}
    ${performPostpaidBillPaymentSuccessResponse}    Post Perform Postpaid Bill Payment    ${accessToken}    ${BAU_CELCOM_POSTPAID_MSISDN}    sourceChannel=NGCA    branchCode=R0001-B0001    paymentAmount=0.11    paymentMethodName=Cash    code=123    creditCardNumber=5105105105105100    operationType=1    telco=${CELCOMTELCO}
    ${getSubscriberProfileAfterResponse}    Get Subscriber Profile After    ${accessToken}    ${BAU_CELCOM_POSTPAID_MSISDN}
    ${getBillingInfoAfterResponse}    Get Billing Info After    ${accessToken}    ${BAU_CELCOM_POSTPAID_MSISDN}
    Validate Payment Amount Added or Reduced Correctly   ${getBillingInfoBeforeResponse}    ${performPostpaidBillPaymentSuccessResponse}    ${getBillingInfoAfterResponse}    
    Validate Postpaid Lifecycle Active    ${getSubscriberProfileBeforeResponse}    ${getSubscriberProfileAfterResponse}
    ${getBillPaymentHistoryResponse}    Get Bill Payment History    ${accessToken}    ${BAU_CELCOM_POSTPAID_MSISDN}
    # Validate Bill Payment History    ${performPostpaidBillPaymentSuccessResponse}    ${getBillPaymentHistoryResponse}
    Log Bill Payment Summary    ${BAU_CELCOM_POSTPAID_MSISDN}    ${getSubscriberProfileBeforeResponse}    ${getBillingInfoBeforeResponse}    ${performPostpaidBillPaymentSuccessResponse}    ${getSubscriberProfileAfterResponse}    ${getBillingInfoAfterResponse}    ${getBillPaymentHistoryResponse}
Test Case 11: Bill Payment Using OnlineBanking [CELCOM]
    [Tags]    sanity    regression
    ${accessToken}    Generate Access Token BAU
    ${getSubscriberProfileBeforeResponse}    Get Subscriber Profile Before    ${accessToken}    ${BAU_CELCOM_POSTPAID_MSISDN}
    ${getBillingInfoBeforeResponse}    Get Billing Info Before    ${accessToken}    ${BAU_CELCOM_POSTPAID_MSISDN}
    ${performPostpaidBillPaymentSuccessResponse}    Post Perform Postpaid Bill Payment    ${accessToken}    ${BAU_CELCOM_POSTPAID_MSISDN}    sourceChannel=NGCA    branchCode=PSFPX    paymentAmount=0.12    paymentMethodName=OnlineBanking    code=1751    creditCardNumber=5105105105105100    operationType=1    telco=${CELCOMTELCO}
    ${getSubscriberProfileAfterResponse}    Get Subscriber Profile After    ${accessToken}    ${BAU_CELCOM_POSTPAID_MSISDN}
    ${getBillingInfoAfterResponse}    Get Billing Info After    ${accessToken}    ${BAU_CELCOM_POSTPAID_MSISDN}
    Validate Payment Amount Added or Reduced Correctly   ${getBillingInfoBeforeResponse}    ${performPostpaidBillPaymentSuccessResponse}    ${getBillingInfoAfterResponse}    
    Validate Postpaid Lifecycle Active    ${getSubscriberProfileBeforeResponse}    ${getSubscriberProfileAfterResponse}
    ${getBillPaymentHistoryResponse}    Get Bill Payment History    ${accessToken}    ${BAU_CELCOM_POSTPAID_MSISDN}
    # Validate Bill Payment History    ${performPostpaidBillPaymentSuccessResponse}    ${getBillPaymentHistoryResponse}
    Log Bill Payment Summary    ${BAU_CELCOM_POSTPAID_MSISDN}    ${getSubscriberProfileBeforeResponse}    ${getBillingInfoBeforeResponse}    ${performPostpaidBillPaymentSuccessResponse}    ${getSubscriberProfileAfterResponse}    ${getBillingInfoAfterResponse}    ${getBillPaymentHistoryResponse}
Test Case 12: Bill Payment Using CreditCard - AMEX [CELCOM]
    [Tags]    sanity    regression
    ${accessToken}    Generate Access Token BAU
    ${getSubscriberProfileBeforeResponse}    Get Subscriber Profile Before    ${accessToken}    ${BAU_CELCOM_POSTPAID_MSISDN}
    ${getBillingInfoBeforeResponse}    Get Billing Info Before    ${accessToken}    ${BAU_CELCOM_POSTPAID_MSISDN}
    ${performPostpaidBillPaymentSuccessResponse}    Post Perform Postpaid Bill Payment    ${accessToken}    ${BAU_CELCOM_POSTPAID_MSISDN}    sourceChannel=NGCA    branchCode=PSFPX    paymentAmount=0.12    paymentMethodName=OnlineBanking    code=1751    creditCardNumber=5105105105105100    operationType=1    telco=${CELCOMTELCO}
    ${getSubscriberProfileAfterResponse}    Get Subscriber Profile After    ${accessToken}    ${BAU_CELCOM_POSTPAID_MSISDN}
    ${getBillingInfoAfterResponse}    Get Billing Info After    ${accessToken}    ${BAU_CELCOM_POSTPAID_MSISDN}
    Validate Payment Amount Added or Reduced Correctly   ${getBillingInfoBeforeResponse}    ${performPostpaidBillPaymentSuccessResponse}    ${getBillingInfoAfterResponse}    
    Validate Postpaid Lifecycle Active    ${getSubscriberProfileBeforeResponse}    ${getSubscriberProfileAfterResponse}
    ${getBillPaymentHistoryResponse}    Get Bill Payment History    ${accessToken}    ${BAU_CELCOM_POSTPAID_MSISDN}
    # Validate Bill Payment History    ${performPostpaidBillPaymentSuccessResponse}    ${getBillPaymentHistoryResponse}
    Log Bill Payment Summary    ${BAU_CELCOM_POSTPAID_MSISDN}    ${getSubscriberProfileBeforeResponse}    ${getBillingInfoBeforeResponse}    ${performPostpaidBillPaymentSuccessResponse}    ${getSubscriberProfileAfterResponse}    ${getBillingInfoAfterResponse}    ${getBillPaymentHistoryResponse}
Test Case 13: Bill Payment Using CreditCard - MasterCard [CELCOM]
    [Tags]    sanity    regression  
    ${accessToken}    Generate Access Token BAU
    ${getSubscriberProfileBeforeResponse}    Get Subscriber Profile Before    ${accessToken}    ${BAU_CELCOM_POSTPAID_MSISDN}
    ${getBillingInfoBeforeResponse}    Get Billing Info Before    ${accessToken}    ${BAU_CELCOM_POSTPAID_MSISDN}
    ${performPostpaidBillPaymentSuccessResponse}    Post Perform Postpaid Bill Payment    ${accessToken}    ${BAU_CELCOM_POSTPAID_MSISDN}    sourceChannel=NGCA    branchCode=PSMBBCC    paymentAmount=0.14    paymentMethodName=MasterCard    code=1750    creditCardNumber=5105105105105100    operationType=1    telco=${CELCOMTELCO}
    ${getSubscriberProfileAfterResponse}    Get Subscriber Profile After    ${accessToken}    ${BAU_CELCOM_POSTPAID_MSISDN}
    ${getBillingInfoAfterResponse}    Get Billing Info After    ${accessToken}    ${BAU_CELCOM_POSTPAID_MSISDN}
    Validate Payment Amount Added or Reduced Correctly   ${getBillingInfoBeforeResponse}    ${performPostpaidBillPaymentSuccessResponse}    ${getBillingInfoAfterResponse}    
    Validate Postpaid Lifecycle Active    ${getSubscriberProfileBeforeResponse}    ${getSubscriberProfileAfterResponse}
    ${getBillPaymentHistoryResponse}    Get Bill Payment History    ${accessToken}    ${BAU_CELCOM_POSTPAID_MSISDN}
    # Validate Bill Payment History    ${performPostpaidBillPaymentSuccessResponse}    ${getBillPaymentHistoryResponse}
    Log Bill Payment Summary    ${BAU_CELCOM_POSTPAID_MSISDN}    ${getSubscriberProfileBeforeResponse}    ${getBillingInfoBeforeResponse}    ${performPostpaidBillPaymentSuccessResponse}    ${getSubscriberProfileAfterResponse}    ${getBillingInfoAfterResponse}    ${getBillPaymentHistoryResponse}
Test Case 14: Bill Payment Using CreditCard - VISA [CELCOM]
    [Tags]    sanity    regression
    ${accessToken}    Generate Access Token BAU
    ${getSubscriberProfileBeforeResponse}    Get Subscriber Profile Before    ${accessToken}    ${BAU_CELCOM_POSTPAID_MSISDN}
    ${getBillingInfoBeforeResponse}    Get Billing Info Before    ${accessToken}    ${BAU_CELCOM_POSTPAID_MSISDN}
    ${performPostpaidBillPaymentSuccessResponse}    Post Perform Postpaid Bill Payment    ${accessToken}    ${BAU_CELCOM_POSTPAID_MSISDN}    sourceChannel=NGCA    branchCode=PSMBBCC    paymentAmount=0.15    paymentMethodName=VISA    code=1750    creditCardNumber=5105105105105100    operationType=1    telco=${CELCOMTELCO}
    ${getSubscriberProfileAfterResponse}    Get Subscriber Profile After    ${accessToken}    ${BAU_CELCOM_POSTPAID_MSISDN}
    ${getBillingInfoAfterResponse}    Get Billing Info After    ${accessToken}    ${BAU_CELCOM_POSTPAID_MSISDN}
    Validate Payment Amount Added or Reduced Correctly   ${getBillingInfoBeforeResponse}    ${performPostpaidBillPaymentSuccessResponse}    ${getBillingInfoAfterResponse}    
    Validate Postpaid Lifecycle Active    ${getSubscriberProfileBeforeResponse}    ${getSubscriberProfileAfterResponse}
    ${getBillPaymentHistoryResponse}    Get Bill Payment History    ${accessToken}    ${BAU_CELCOM_POSTPAID_MSISDN}
    # Validate Bill Payment History    ${performPostpaidBillPaymentSuccessResponse}    ${getBillPaymentHistoryResponse}
    Log Bill Payment Summary    ${BAU_CELCOM_POSTPAID_MSISDN}    ${getSubscriberProfileBeforeResponse}    ${getBillingInfoBeforeResponse}    ${performPostpaidBillPaymentSuccessResponse}    ${getSubscriberProfileAfterResponse}    ${getBillingInfoAfterResponse}    ${getBillPaymentHistoryResponse}
Test Case 15: Bill Payment Using eWallet - TouchNGo [CELCOM]
    [Tags]    sanity    regression
    ${accessToken}    Generate Access Token BAU
    ${getSubscriberProfileBeforeResponse}    Get Subscriber Profile Before    ${accessToken}    ${BAU_CELCOM_POSTPAID_MSISDN}
    ${getBillingInfoBeforeResponse}    Get Billing Info Before    ${accessToken}    ${BAU_CELCOM_POSTPAID_MSISDN}
    ${performPostpaidBillPaymentSuccessResponse}    Post Perform Postpaid Bill Payment    ${accessToken}    ${BAU_CELCOM_POSTPAID_MSISDN}    sourceChannel=NGCA    branchCode=PSEWTnG    paymentAmount=0.16    paymentMethodName=TouchNGo    code=1752    creditCardNumber=5105105105105100    operationType=1    telco=${CELCOMTELCO}
    ${getSubscriberProfileAfterResponse}    Get Subscriber Profile After    ${accessToken}    ${BAU_CELCOM_POSTPAID_MSISDN}
    ${getBillingInfoAfterResponse}    Get Billing Info After    ${accessToken}    ${BAU_CELCOM_POSTPAID_MSISDN}
    Validate Payment Amount Added or Reduced Correctly   ${getBillingInfoBeforeResponse}    ${performPostpaidBillPaymentSuccessResponse}    ${getBillingInfoAfterResponse}    
    Validate Postpaid Lifecycle Active    ${getSubscriberProfileBeforeResponse}    ${getSubscriberProfileAfterResponse}
    ${getBillPaymentHistoryResponse}    Get Bill Payment History    ${accessToken}    ${BAU_CELCOM_POSTPAID_MSISDN}
    # Validate Bill Payment History    ${performPostpaidBillPaymentSuccessResponse}    ${getBillPaymentHistoryResponse}
    Log Bill Payment Summary    ${BAU_CELCOM_POSTPAID_MSISDN}    ${getSubscriberProfileBeforeResponse}    ${getBillingInfoBeforeResponse}    ${performPostpaidBillPaymentSuccessResponse}    ${getSubscriberProfileAfterResponse}    ${getBillingInfoAfterResponse}    ${getBillPaymentHistoryResponse}
Test Case 16: Bill Payment Using eWallet - GrabPay [CELCOM]
    [Tags]    sanity    regression  
    ${accessToken}    Generate Access Token BAU
    ${getSubscriberProfileBeforeResponse}    Get Subscriber Profile Before    ${accessToken}    ${BAU_CELCOM_POSTPAID_MSISDN}
    ${getBillingInfoBeforeResponse}    Get Billing Info Before    ${accessToken}    ${BAU_CELCOM_POSTPAID_MSISDN}
    ${performPostpaidBillPaymentSuccessResponse}    Post Perform Postpaid Bill Payment    ${accessToken}    ${BAU_CELCOM_POSTPAID_MSISDN}    sourceChannel=NGCA    branchCode=PSEWGRBP    paymentAmount=0.17    paymentMethodName=GrabPay    code=1753    creditCardNumber=5105105105105100    operationType=1    telco=${CELCOMTELCO}
    ${getSubscriberProfileAfterResponse}    Get Subscriber Profile After    ${accessToken}    ${BAU_CELCOM_POSTPAID_MSISDN}
    ${getBillingInfoAfterResponse}    Get Billing Info After    ${accessToken}    ${BAU_CELCOM_POSTPAID_MSISDN}
    Validate Payment Amount Added or Reduced Correctly   ${getBillingInfoBeforeResponse}    ${performPostpaidBillPaymentSuccessResponse}    ${getBillingInfoAfterResponse}    
    Validate Postpaid Lifecycle Active    ${getSubscriberProfileBeforeResponse}    ${getSubscriberProfileAfterResponse}
    ${getBillPaymentHistoryResponse}    Get Bill Payment History    ${accessToken}    ${BAU_CELCOM_POSTPAID_MSISDN}
    # Validate Bill Payment History    ${performPostpaidBillPaymentSuccessResponse}    ${getBillPaymentHistoryResponse}
    Log Bill Payment Summary    ${BAU_CELCOM_POSTPAID_MSISDN}    ${getSubscriberProfileBeforeResponse}    ${getBillingInfoBeforeResponse}    ${performPostpaidBillPaymentSuccessResponse}    ${getSubscriberProfileAfterResponse}    ${getBillingInfoAfterResponse}    ${getBillPaymentHistoryResponse}
Test Case 17: Bill Payment Using eWallet - ShopeePay [CELCOM]
    [Tags]    sanity    regression
    ${accessToken}    Generate Access Token BAU
    ${getSubscriberProfileBeforeResponse}    Get Subscriber Profile Before    ${accessToken}    ${BAU_CELCOM_POSTPAID_MSISDN}
    ${getBillingInfoBeforeResponse}    Get Billing Info Before    ${accessToken}    ${BAU_CELCOM_POSTPAID_MSISDN}
    ${performPostpaidBillPaymentSuccessResponse}    Post Perform Postpaid Bill Payment    ${accessToken}    ${BAU_CELCOM_POSTPAID_MSISDN}    sourceChannel=NGCA    branchCode=PSSHPE    paymentAmount=0.18    paymentMethodName=ShopeePay    code=1754    creditCardNumber=5105105105105100    operationType=1    telco=${CELCOMTELCO}
    ${getSubscriberProfileAfterResponse}    Get Subscriber Profile After    ${accessToken}    ${BAU_CELCOM_POSTPAID_MSISDN}
    ${getBillingInfoAfterResponse}    Get Billing Info After    ${accessToken}    ${BAU_CELCOM_POSTPAID_MSISDN}
    Validate Payment Amount Added or Reduced Correctly   ${getBillingInfoBeforeResponse}    ${performPostpaidBillPaymentSuccessResponse}    ${getBillingInfoAfterResponse}    
    Validate Postpaid Lifecycle Active    ${getSubscriberProfileBeforeResponse}    ${getSubscriberProfileAfterResponse}
    ${getBillPaymentHistoryResponse}    Get Bill Payment History    ${accessToken}    ${BAU_CELCOM_POSTPAID_MSISDN}
    # Validate Bill Payment History    ${performPostpaidBillPaymentSuccessResponse}    ${getBillPaymentHistoryResponse}
    Log Bill Payment Summary    ${BAU_CELCOM_POSTPAID_MSISDN}    ${getSubscriberProfileBeforeResponse}    ${getBillingInfoBeforeResponse}    ${performPostpaidBillPaymentSuccessResponse}    ${getSubscriberProfileAfterResponse}    ${getBillingInfoAfterResponse}    ${getBillPaymentHistoryResponse}
Test Case 18: Bill Payment Using eWallet - Boost [CELCOM]
    [Tags]    sanity    regression
    ${accessToken}    Generate Access Token BAU
    ${getSubscriberProfileBeforeResponse}    Get Subscriber Profile Before    ${accessToken}    ${BAU_CELCOM_POSTPAID_MSISDN}
    ${getBillingInfoBeforeResponse}    Get Billing Info Before    ${accessToken}    ${BAU_CELCOM_POSTPAID_MSISDN}
    ${performPostpaidBillPaymentSuccessResponse}    Post Perform Postpaid Bill Payment    ${accessToken}    ${BAU_CELCOM_POSTPAID_MSISDN}    sourceChannel=NGCA    branchCode=PSSHPE    paymentAmount=0.19    paymentMethodName=Boost    code=1755    creditCardNumber=5105105105105100    operationType=1    telco=${CELCOMTELCO}
    ${getSubscriberProfileAfterResponse}    Get Subscriber Profile After    ${accessToken}    ${BAU_CELCOM_POSTPAID_MSISDN}
    ${getBillingInfoAfterResponse}    Get Billing Info After    ${accessToken}    ${BAU_CELCOM_POSTPAID_MSISDN}
    Validate Payment Amount Added or Reduced Correctly   ${getBillingInfoBeforeResponse}    ${performPostpaidBillPaymentSuccessResponse}    ${getBillingInfoAfterResponse}    
    Validate Postpaid Lifecycle Active    ${getSubscriberProfileBeforeResponse}    ${getSubscriberProfileAfterResponse}
    ${getBillPaymentHistoryResponse}    Get Bill Payment History    ${accessToken}    ${BAU_CELCOM_POSTPAID_MSISDN}
    # Validate Bill Payment History    ${performPostpaidBillPaymentSuccessResponse}    ${getBillPaymentHistoryResponse}
    Log Bill Payment Summary    ${BAU_CELCOM_POSTPAID_MSISDN}    ${getSubscriberProfileBeforeResponse}    ${getBillingInfoBeforeResponse}    ${performPostpaidBillPaymentSuccessResponse}    ${getSubscriberProfileAfterResponse}    ${getBillingInfoAfterResponse}    ${getBillPaymentHistoryResponse}



# # LIFECYCLE TEST CASES #
Test Case 19: Lifecycle Bill Payment Barred [DIGI]
    [Tags]    smoke    sanity    regression
    ${accessToken}    Generate Access Token BAU
    ${getSubscriberProfileBeforeResponse}    Get Subscriber Profile Before    ${accessToken}    ${BAU_DIGI_POSTPAID_MSISDN_BARRING}
    ${getBillingInfoBeforeResponse}    Get Billing Info Before    ${accessToken}    ${BAU_DIGI_POSTPAID_MSISDN}
    ${performPostpaidBillPaymentSuccessResponse}    Post Perform Postpaid Bill Payment    ${accessToken}    ${BAU_DIGI_POSTPAID_MSISDN}    sourceChannel=NGCA    branchCode=R0001-B0001    paymentAmount=0.11    paymentMethodName=Cash    code=123    creditCardNumber=5105105105105100    operationType=1    telco=${DIGITELCO}
    ${getSubscriberProfileAfterResponse}    Get Subscriber Profile After    ${accessToken}    ${BAU_DIGI_POSTPAID_MSISDN}
    ${getBillingInfoAfterResponse}    Get Billing Info After    ${accessToken}    ${BAU_DIGI_POSTPAID_MSISDN}
    Validate Payment Amount Added or Reduced Correctly   ${getBillingInfoBeforeResponse}    ${performPostpaidBillPaymentSuccessResponse}    ${getBillingInfoAfterResponse}    
    Validate Postpaid Lifecycle Updated From Barred To Active    ${getSubscriberProfileBeforeResponse}    ${getSubscriberProfileAfterResponse}
    ${getBillPaymentHistoryResponse}    Get Bill Payment History    ${accessToken}    ${BAU_DIGI_POSTPAID_MSISDN}
    Validate Bill Payment History    ${performPostpaidBillPaymentSuccessResponse}    ${getBillPaymentHistoryResponse}
    Log Bill Payment Summary    ${BAU_DIGI_POSTPAID_MSISDN}    ${getSubscriberProfileBeforeResponse}    ${getBillingInfoBeforeResponse}    ${performPostpaidBillPaymentSuccessResponse}    ${getSubscriberProfileAfterResponse}    ${getBillingInfoAfterResponse}    ${getBillPaymentHistoryResponse}
Test Case 20: Lifecycle Bill Payment Barred [CELCOM]
    [Tags]    smoke    sanity    regression
    ${accessToken}    Generate Access Token BAU
    ${getSubscriberProfileBeforeResponse}    Get Subscriber Profile Before    ${accessToken}    ${BAU_CELCOM_POSTPAID_MSISDN_BARRING}
    ${getBillingInfoBeforeResponse}    Get Billing Info Before    ${accessToken}    ${BAU_CELCOM_POSTPAID_MSISDN_BARRING}
    ${performPostpaidBillPaymentSuccessResponse}    Post Perform Postpaid Bill Payment    ${accessToken}    ${BAU_CELCOM_POSTPAID_MSISDN_BARRING}    sourceChannel=NGCA    branchCode=R0001-B0001    paymentAmount=0.11    paymentMethodName=Cash    code=123    creditCardNumber=5105105105105100    operationType=1    telco=${CELCOMTELCO}
    ${getSubscriberProfileAfterResponse}    Get Subscriber Profile After    ${accessToken}    ${BAU_CELCOM_POSTPAID_MSISDN_BARRING}
    ${getBillingInfoAfterResponse}    Get Billing Info After    ${accessToken}    ${BAU_CELCOM_POSTPAID_MSISDN_BARRING}
    Validate Payment Amount Added or Reduced Correctly   ${getBillingInfoBeforeResponse}    ${performPostpaidBillPaymentSuccessResponse}    ${getBillingInfoAfterResponse}    
    Validate Postpaid Lifecycle Updated From Barred To Active    ${getSubscriberProfileBeforeResponse}    ${getSubscriberProfileAfterResponse}
    ${getBillPaymentHistoryResponse}    Get Bill Payment History    ${accessToken}    ${BAU_CELCOM_POSTPAID_MSISDN_BARRING}
    # Validate Bill Payment History    ${performPostpaidBillPaymentSuccessResponse}    ${getBillPaymentHistoryResponse}
    Log Bill Payment Summary    ${BAU_CELCOM_POSTPAID_MSISDN_BARRING}    ${getSubscriberProfileBeforeResponse}    ${getBillingInfoBeforeResponse}    ${performPostpaidBillPaymentSuccessResponse}    ${getSubscriberProfileAfterResponse}    ${getBillingInfoAfterResponse}    ${getBillPaymentHistoryResponse}
Test Case 21: Lifecycle Bill Payment Suspended [DIGI]
    [Tags]    smoke    sanity    regression
    ${accessToken}    Generate Access Token BAU    #note: TBC why payment went through for suspended subscriber
    ${getSubscriberProfileBeforeResponse}    Get Subscriber Profile Before    ${accessToken}    ${BAU_DIGI_POSTPAID_MSISDN_SUSPENDED}
    ${getBillingInfoBeforeResponse}    Get Billing Info Before    ${accessToken}    ${BAU_DIGI_POSTPAID_MSISDN_SUSPENDED}
    ${performPostpaidBillPaymentUnsuccessResponse}    Post Perform Postpaid Bill Payment Negative    ${accessToken}    ${BAU_DIGI_POSTPAID_MSISDN_SUSPENDED}    sourceChannel=NGCA    branchCode=R0001-B0001    paymentAmount=0.11    paymentMethodName=Cash    code=123    creditCardNumber=5105105105105100    operationType=1    telco=${DIGITELCO}
    # ${getSubscriberProfileAfterResponse}    Get Subscriber Profile After    ${accessToken}    ${BAU_DIGI_POSTPAID_MSISDN_SUSPENDED}
    # ${getBillingInfoAfterResponse}    Get Billing Info After    ${accessToken}    ${BAU_DIGI_POSTPAID_MSISDN_SUSPENDED}
    # Validate Payment Amount Amount Unchanged   ${getBillingInfoBeforeResponse}    ${getBillingInfoAfterResponse}    
    # Validate Postpaid Lifecycle Suspended    ${getSubscriberProfileBeforeResponse}    ${getSubscriberProfileAfterResponse}
    # Log Bill Payment Summary Invalid    ${BAU_DIGI_POSTPAID_MSISDN_SUSPENDED}    ${getSubscriberProfileBeforeResponse}    ${getBillingInfoBeforeResponse}    ${getSubscriberProfileAfterResponse}    ${getBillingInfoAfterResponse}    ${performPostpaidBillPaymentUnsuccessResponse}    
Test Case 22: Lifecycle Bill Payment Suspended [CELCOM]
    [Tags]    smoke    sanity    regression
    ${accessToken}    Generate Access Token BAU    #note: TBC why payment went through for suspended subscriber
    ${getSubscriberProfileBeforeResponse}    Get Subscriber Profile Before    ${accessToken}    ${BAU_CELCOM_POSTPAID_MSISDN_SUSPENDED}
    ${getBillingInfoBeforeResponse}    Get Billing Info Before    ${accessToken}    ${BAU_CELCOM_POSTPAID_MSISDN_SUSPENDED}
    ${performPostpaidBillPaymentUnsuccessResponse}    Post Perform Postpaid Bill Payment Negative    ${accessToken}    ${BAU_CELCOM_POSTPAID_MSISDN_SUSPENDED}    sourceChannel=NGCA    branchCode=R0001-B0001    paymentAmount=0.11    paymentMethodName=Cash    code=123    creditCardNumber=5105105105105100    operationType=1    telco=${CELCOMTELCO}
    # ${getSubscriberProfileAfterResponse}    Get Subscriber Profile After    ${accessToken}    ${BAU_CELCOM_POSTPAID_MSISDN_SUSPENDED}
    # ${getBillingInfoAfterResponse}    Get Billing Info After    ${accessToken}    ${BAU_CELCOM_POSTPAID_MSISDN_SUSPENDED}
    # Validate Payment Amount Amount Unchanged   ${getBillingInfoBeforeResponse}    ${getBillingInfoAfterResponse}    
    # Validate Postpaid Lifecycle Suspended    ${getSubscriberProfileBeforeResponse}    ${getSubscriberProfileAfterResponse}
    # Log Bill Payment Summary Invalid    ${BAU_CELCOM_POSTPAID_MSISDN_SUSPENDED}    ${getSubscriberProfileBeforeResponse}    ${getBillingInfoBeforeResponse}    ${getSubscriberProfileAfterResponse}    ${getBillingInfoAfterResponse}    ${performPostpaidBillPaymentUnsuccessResponse}    
Test Case 23: Lifecycle Bill Payment Deactivated [DIGI]
    [Tags]    smoke    sanity    regression
    ${accessToken}    Generate Access Token BAU    #note: TBC pending test data
    ${getSubscriberProfileBeforeResponse}    Get Subscriber Profile Before    ${accessToken}    ${BAU_DIGI_POSTPAID_MSISDN_DEACTIVATED}
    ${getBillingInfoBeforeResponse}    Get Billing Info Before    ${accessToken}    ${BAU_DIGI_POSTPAID_MSISDN_SUSPENDED}
    # ${performPostpaidBillPaymentUnsuccessResponse}    Post Perform Postpaid Bill Payment Negative    ${accessToken}    ${BAU_DIGI_POSTPAID_MSISDN_SUSPENDED}    sourceChannel=NGCA    branchCode=R0001-B0001    paymentAmount=0.11    paymentMethodName=Cash    code=123    creditCardNumber=5105105105105100    operationType=1    telco=${DIGITELCO}
    # ${getSubscriberProfileAfterResponse}    Get Subscriber Profile After    ${accessToken}    ${BAU_DIGI_POSTPAID_MSISDN_SUSPENDED}
    # ${getBillingInfoAfterResponse}    Get Billing Info After    ${accessToken}    ${BAU_DIGI_POSTPAID_MSISDN_SUSPENDED}
    # Validate Payment Amount Amount Unchanged   ${getBillingInfoBeforeResponse}    ${getBillingInfoAfterResponse}    
    # Validate Postpaid Lifecycle Deactivated    ${getSubscriberProfileBeforeResponse}    ${getSubscriberProfileAfterResponse}
    # Log Bill Payment Summary Invalid    ${BAU_DIGI_POSTPAID_MSISDN_SUSPENDED}    ${getSubscriberProfileBeforeResponse}    ${getBillingInfoBeforeResponse}    ${getSubscriberProfileAfterResponse}    ${getBillingInfoAfterResponse}    ${performPostpaidBillPaymentUnsuccessResponse}    
Test Case 24: Lifecycle Bill Payment Deactivated [CELCOM]
    [Tags]    smoke    sanity    regression
    ${accessToken}    Generate Access Token BAU    #note: TBC pending test data
    ${getSubscriberProfileBeforeResponse}    Get Subscriber Profile Before    ${accessToken}    ${BAU_CELCOM_POSTPAID_MSISDN_DEACTIVATED}
#     ${getBillingInfoBeforeResponse}    Get Billing Info Before    ${accessToken}    ${BAU_CELCOM_POSTPAID_MSISDN_DEACTIVATED}
#     ${performPostpaidBillPaymentUnsuccessResponse}    Post Perform Postpaid Bill Payment Negative    ${accessToken}    ${BAU_CELCOM_POSTPAID_MSISDN_DEACTIVATED}    sourceChannel=NGCA    branchCode=R0001-B0001    paymentAmount=0.11    paymentMethodName=Cash    code=123    creditCardNumber=5105105105105100    operationType=1    telco=${CELCOMTELCO}
#     ${getSubscriberProfileAfterResponse}    Get Subscriber Profile After    ${accessToken}    ${BAU_CELCOM_POSTPAID_MSISDN_DEACTIVATED}
#     ${getBillingInfoAfterResponse}    Get Billing Info After    ${accessToken}    ${BAU_CELCOM_POSTPAID_MSISDN_DEACTIVATED}
#     Validate Payment Amount Amount Unchanged   ${getBillingInfoBeforeResponse}    ${getBillingInfoAfterResponse}    
#     Validate Postpaid Lifecycle Deactivated    ${getSubscriberProfileBeforeResponse}    ${getSubscriberProfileAfterResponse}
#     Log Bill Payment Summary Invalid    ${BAU_CELCOM_POSTPAID_MSISDN_DEACTIVATED}    ${getSubscriberProfileBeforeResponse}    ${getBillingInfoBeforeResponse}    ${getSubscriberProfileAfterResponse}    ${getBillingInfoAfterResponse}    ${performPostpaidBillPaymentUnsuccessResponse}    
Test Case 25: Validate Prepaid Lifecycle [DIGI]
    [Tags]    smoke    sanity    regression
    ${accessToken}    Generate Access Token BAU
    ${getSubscriberProfileBeforeResponse}    Get Subscriber Profile Before    ${accessToken}    ${BAU_DIGI_PREPAID_MSISDN}
    ${getSubscriberPrepaidBalanceBeforeResponse}    Get Prepaid Balance Before    ${accessToken}    ${BAU_DIGI_PREPAID_MSISDN}
    ${getBillingInfoBeforeResponse}    Get Billing Info Before    ${accessToken}    ${BAU_DIGI_PREPAID_MSISDN}    #note : passthrough API. DIGI returns response from CSG(having 0 balance bucket), CELCOM returns response from IGW(error)
    ${performPostpaidBillPaymentUnsuccessResponse}    Post Perform Postpaid Bill Payment Negative    ${accessToken}    ${BAU_DIGI_PREPAID_MSISDN}    sourceChannel=NGCA    branchCode=R0001-B0001    paymentAmount=0.11    paymentMethodName=Cash    code=123    creditCardNumber=5105105105105100    operationType=1    telco=${DIGITELCO}    #note : passthrough API. DIGI returns response from CSG(error), CELCOM returns response from IGW(allowed bill payment for prepaid, balance added to prepaid balance)
    ${getSubscriberProfileAfterResponse}    Get Subscriber Profile After    ${accessToken}    ${BAU_DIGI_PREPAID_MSISDN}
    ${getSubscriberPrepaidBalanceAfterResponse}    Get Prepaid Balance After    ${accessToken}    ${BAU_CELCOM_PREPAID_MSISDN}
    ${getBillingInfoAfterResponse}    Get Billing Info After    ${accessToken}    ${BAU_DIGI_PREPAID_MSISDN}
    Validate Prepaid Lifecycle    ${getSubscriberProfileBeforeResponse}    ${getSubscriberProfileAfterResponse}
    Log Bill Payment Summary Invalid    ${BAU_DIGI_PREPAID_MSISDN}    ${getSubscriberProfileBeforeResponse}    ${getSubscriberPrepaidBalanceBeforeResponse}    ${getBillingInfoBeforeResponse}    ${getSubscriberProfileAfterResponse}    ${getSubscriberPrepaidBalanceAfterResponse}    ${getBillingInfoAfterResponse}    ${performPostpaidBillPaymentUnsuccessResponse}   
Test Case 26: Validate Prepaid Lifecycle [CELCOM]
    [Tags]    smoke    sanity    regression
    ${accessToken}    Generate Access Token BAU
    ${getSubscriberProfileBeforeResponse}    Get Subscriber Profile Before    ${accessToken}    ${BAU_CELCOM_PREPAID_MSISDN}
    ${getSubscriberPrepaidBalanceBeforeResponse}    Get Prepaid Balance Before    ${accessToken}    ${BAU_CELCOM_PREPAID_MSISDN}
    ${getBillingInfoBeforeUnsuccessfulResponse}    Get Billing Info Before Negative    ${accessToken}    ${BAU_CELCOM_PREPAID_MSISDN}    #notes : passthrough API. DIGI returns response from CSG(having 0 balance bucket), CELCOM returns response from IGW(error)
    ${performPostpaidBillPaymentSuccessResponse}    Post Perform Postpaid Bill Payment    ${accessToken}    ${BAU_CELCOM_PREPAID_MSISDN}    sourceChannel=NGCA    branchCode=PSSHPE    paymentAmount=20.00    paymentMethodName=ShopeePay    code=1754    creditCardNumber=5105105105105100    operationType=1    telco=${CELCOMTELCO}    #note : passthrough API. DIGI returns response from CSG(error), CELCOM returns response from IGW(allowed bill payment for prepaid, balance added to prepaid balance)
    ${getSubscriberProfileAfterResponse}    Get Subscriber Profile After    ${accessToken}    ${BAU_CELCOM_PREPAID_MSISDN}
    ${getSubscriberPrepaidBalanceAfterResponse}    Get Prepaid Balance After    ${accessToken}    ${BAU_CELCOM_PREPAID_MSISDN}
    ${getBillingInfoAfterUnsuccessfulResponse}    Get Billing Info After Negative    ${accessToken}    ${BAU_CELCOM_PREPAID_MSISDN}
    Validate Reload Amount Correct From Bill Payment    ${getSubscriberPrepaidBalanceBeforeResponse}    ${performPostpaidBillPaymentSuccessResponse}    ${getSubscriberPrepaidBalanceAfterResponse}
    Validate Prepaid Lifecycle    ${getSubscriberProfileBeforeResponse}    ${getSubscriberProfileAfterResponse}
    # ${getBillPaymentHistoryResponse}    Get Bill Payment History    ${accessToken}    ${BAU_CELCOM_POSTPAID_MSISDN}
    # Validate Bill Payment History    ${performPostpaidBillPaymentSuccessResponse}    ${getBillPaymentHistoryResponse}    #note : should not exist in bill payment history
    ${getReloadHistoryResponse}    Get Reload History From Bill Payment  ${accessToken}  ${BAU_CELCOM_PREPAID_MSISDN}    ${performPostpaidBillPaymentSuccessResponse}
    Validate Reload History From Bill Payment    ${performPostpaidBillPaymentSuccessResponse}    ${getReloadHistoryResponse}    #note : should exist in reload history
    Log Bill Payment Summary II    ${BAU_CELCOM_PREPAID_MSISDN}    ${getSubscriberProfileBeforeResponse}    ${getSubscriberPrepaidBalanceBeforeResponse}    ${getBillingInfoBeforeUnsuccessfulResponse}    ${getSubscriberProfileAfterResponse}    ${getSubscriberPrepaidBalanceAfterResponse}    ${getBillingInfoAfterUnsuccessfulResponse}    ${performPostpaidBillPaymentSuccessResponse}    ${getReloadHistoryResponse}

Test Case 27: Bill Payment Postpaid [MAXIS]
    [Tags]    regression
    ${accessToken}    Generate Access Token BAU
    ${getSubscriberProfileNonCD}    Get Subscriber Profile NonCD    ${accessToken}    ${BAU_MAXIS_POSTPAID_MSISDN}
    Log Subscriber Invalid  ${BAU_MAXIS_POSTPAID_MSISDN}    ${getSubscriberProfileNonCD}
