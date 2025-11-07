*** Settings ***
Documentation    This file only store testcases for BAU Moli Reload

# Resource    ../MOLI-testSettings.robot
Resource    ../TestKeywords/all_keywords.robot

*** Test Cases ***

# DIGI RELOAD PINLESS TEST CASES #
Test Case 1 : Reload Pinless Using Cash [DIGI]
    [Tags]    smoke    sanity    regression
    ${accessToken}    Generate Access Token BAU
    ${getSubscriberProfileBeforeResponse}    Get Subscriber Profile Before    ${accessToken}    ${BAU_DIGI_PREPAID_MSISDN}
    ${getSubscriberPrepaidBalanceBeforeResponse}    Get Prepaid Balance Before    ${accessToken}    ${BAU_DIGI_PREPAID_MSISDN}
    ${performPrepaidReloadSuccessResponse}    Post Perform Prepaid Pinless Reload    ${accessToken}    ${BAU_DIGI_PREPAID_MSISDN}    paymentAmount=10.00    paymentMethod=Cash    sourceChannel=223
    ${getSubscriberProfileAfterResponse}    Get Subscriber Profile After    ${accessToken}    ${BAU_DIGI_PREPAID_MSISDN}
    ${getSubscriberPrepaidBalanceAfterResponse}    Get Prepaid Balance After    ${accessToken}    ${BAU_DIGI_PREPAID_MSISDN}
    Validate Reload Amount Correct    ${getSubscriberPrepaidBalanceBeforeResponse}    ${performPrepaidReloadSuccessResponse}    ${getSubscriberPrepaidBalanceAfterResponse}
    Validate Prepaid Lifecycle Active   ${getSubscriberProfileBeforeResponse}    ${getSubscriberProfileAfterResponse}
    ${getReloadHistoryResponse}    Get Reload History  ${accessToken}  ${BAU_DIGI_PREPAID_MSISDN}    ${performPrepaidReloadSuccessResponse}
    Validate Reload History    ${performPrepaidReloadSuccessResponse}    ${getReloadHistoryResponse}
    Log Reload Summary    ${BAU_DIGI_PREPAID_MSISDN}    ${getSubscriberProfileBeforeResponse}    ${getSubscriberPrepaidBalanceBeforeResponse}    ${performPrepaidReloadSuccessResponse}    ${getSubscriberProfileAfterResponse}    ${getSubscriberPrepaidBalanceAfterResponse}    ${getReloadHistoryResponse}
Test Case 2: Reload Pinless Using OnlineBanking [DIGI]
    [Tags]    sanity    regression
    ${accessToken}    Generate Access Token BAU
    ${getSubscriberProfileBeforeResponse}    Get Subscriber Profile Before    ${accessToken}    ${BAU_DIGI_PREPAID_MSISDN}
    ${getSubscriberPrepaidBalanceBeforeResponse}    Get Prepaid Balance Before    ${accessToken}    ${BAU_DIGI_PREPAID_MSISDN}
    ${performPrepaidReloadSuccessResponse}    Post Perform Prepaid Pinless Reload    ${accessToken}    ${BAU_DIGI_PREPAID_MSISDN}    paymentAmount=5.00    paymentMethod=OnlineBanking    sourceChannel=223
    ${getSubscriberProfileAfterResponse}    Get Subscriber Profile After    ${accessToken}    ${BAU_DIGI_PREPAID_MSISDN}
    ${getSubscriberPrepaidBalanceAfterResponse}    Get Prepaid Balance After    ${accessToken}    ${BAU_DIGI_PREPAID_MSISDN}
    Validate Reload Amount Correct    ${getSubscriberPrepaidBalanceBeforeResponse}    ${performPrepaidReloadSuccessResponse}    ${getSubscriberPrepaidBalanceAfterResponse}
    Validate Prepaid Lifecycle Active   ${getSubscriberProfileBeforeResponse}    ${getSubscriberProfileAfterResponse}
    ${getReloadHistoryResponse}    Get Reload History  ${accessToken}  ${BAU_DIGI_PREPAID_MSISDN}    ${performPrepaidReloadSuccessResponse}
    Validate Reload History    ${performPrepaidReloadSuccessResponse}    ${getReloadHistoryResponse}
    Log Reload Summary    ${BAU_DIGI_PREPAID_MSISDN}    ${getSubscriberProfileBeforeResponse}    ${getSubscriberPrepaidBalanceBeforeResponse}    ${performPrepaidReloadSuccessResponse}    ${getSubscriberProfileAfterResponse}    ${getSubscriberPrepaidBalanceAfterResponse}    ${getReloadHistoryResponse}
Test Case 3: Reload Pinless Using CreditCard - AMEX [DIGI]
    [Tags]    sanity    regression
    ${accessToken}    Generate Access Token BAU
    ${getSubscriberProfileBeforeResponse}    Get Subscriber Profile Before    ${accessToken}    ${BAU_DIGI_PREPAID_MSISDN}
    ${getSubscriberPrepaidBalanceBeforeResponse}    Get Prepaid Balance Before    ${accessToken}    ${BAU_DIGI_PREPAID_MSISDN}
    ${performPrepaidReloadSuccessResponse}    Post Perform Prepaid Pinless Reload    ${accessToken}    ${BAU_DIGI_PREPAID_MSISDN}    paymentAmount=5.00    paymentMethod=AMEX    sourceChannel=223
    ${getSubscriberProfileAfterResponse}    Get Subscriber Profile After    ${accessToken}    ${BAU_DIGI_PREPAID_MSISDN}
    ${getSubscriberPrepaidBalanceAfterResponse}    Get Prepaid Balance After    ${accessToken}    ${BAU_DIGI_PREPAID_MSISDN}
    Validate Reload Amount Correct    ${getSubscriberPrepaidBalanceBeforeResponse}    ${performPrepaidReloadSuccessResponse}    ${getSubscriberPrepaidBalanceAfterResponse}
    Validate Prepaid Lifecycle Active   ${getSubscriberProfileBeforeResponse}    ${getSubscriberProfileAfterResponse}
    ${getReloadHistoryResponse}    Get Reload History  ${accessToken}  ${BAU_DIGI_PREPAID_MSISDN}    ${performPrepaidReloadSuccessResponse}
    Validate Reload History    ${performPrepaidReloadSuccessResponse}    ${getReloadHistoryResponse}
    Log Reload Summary    ${BAU_DIGI_PREPAID_MSISDN}    ${getSubscriberProfileBeforeResponse}    ${getSubscriberPrepaidBalanceBeforeResponse}    ${performPrepaidReloadSuccessResponse}    ${getSubscriberProfileAfterResponse}    ${getSubscriberPrepaidBalanceAfterResponse}    ${getReloadHistoryResponse}
Test Case 4: Reload Pinless Using CreditCard - MasterCard [DIGI]
    [Tags]    sanity    regression
    ${accessToken}    Generate Access Token BAU
    ${getSubscriberProfileBeforeResponse}    Get Subscriber Profile Before    ${accessToken}    ${BAU_DIGI_PREPAID_MSISDN}
    ${getSubscriberPrepaidBalanceBeforeResponse}    Get Prepaid Balance Before    ${accessToken}    ${BAU_DIGI_PREPAID_MSISDN}
    ${performPrepaidReloadSuccessResponse}    Post Perform Prepaid Pinless Reload    ${accessToken}    ${BAU_DIGI_PREPAID_MSISDN}    paymentAmount=5.00    paymentMethod=MasterCard    sourceChannel=223
    ${getSubscriberProfileAfterResponse}    Get Subscriber Profile After    ${accessToken}    ${BAU_DIGI_PREPAID_MSISDN}
    ${getSubscriberPrepaidBalanceAfterResponse}    Get Prepaid Balance After    ${accessToken}    ${BAU_DIGI_PREPAID_MSISDN}
    Validate Reload Amount Correct    ${getSubscriberPrepaidBalanceBeforeResponse}    ${performPrepaidReloadSuccessResponse}    ${getSubscriberPrepaidBalanceAfterResponse}
    Validate Prepaid Lifecycle Active   ${getSubscriberProfileBeforeResponse}    ${getSubscriberProfileAfterResponse}
    ${getReloadHistoryResponse}    Get Reload History  ${accessToken}  ${BAU_DIGI_PREPAID_MSISDN}    ${performPrepaidReloadSuccessResponse}
    Validate Reload History    ${performPrepaidReloadSuccessResponse}    ${getReloadHistoryResponse}
    Log Reload Summary    ${BAU_DIGI_PREPAID_MSISDN}    ${getSubscriberProfileBeforeResponse}    ${getSubscriberPrepaidBalanceBeforeResponse}    ${performPrepaidReloadSuccessResponse}    ${getSubscriberProfileAfterResponse}    ${getSubscriberPrepaidBalanceAfterResponse}    ${getReloadHistoryResponse}
Test Case 5: Reload Pinless Using CreditCard - VISA [DIGI]
    [Tags]    sanity    regression
    ${accessToken}    Generate Access Token BAU
    ${getSubscriberProfileBeforeResponse}    Get Subscriber Profile Before    ${accessToken}    ${BAU_DIGI_PREPAID_MSISDN}
    ${getSubscriberPrepaidBalanceBeforeResponse}    Get Prepaid Balance Before    ${accessToken}    ${BAU_DIGI_PREPAID_MSISDN}
    ${performPrepaidReloadSuccessResponse}    Post Perform Prepaid Pinless Reload    ${accessToken}    ${BAU_DIGI_PREPAID_MSISDN}    paymentAmount=5.00    paymentMethod=VISA    sourceChannel=223
    ${getSubscriberProfileAfterResponse}    Get Subscriber Profile After    ${accessToken}    ${BAU_DIGI_PREPAID_MSISDN}
    ${getSubscriberPrepaidBalanceAfterResponse}    Get Prepaid Balance After    ${accessToken}    ${BAU_DIGI_PREPAID_MSISDN}
    Validate Reload Amount Correct    ${getSubscriberPrepaidBalanceBeforeResponse}    ${performPrepaidReloadSuccessResponse}    ${getSubscriberPrepaidBalanceAfterResponse}
    Validate Prepaid Lifecycle Active   ${getSubscriberProfileBeforeResponse}    ${getSubscriberProfileAfterResponse}
    ${getReloadHistoryResponse}    Get Reload History  ${accessToken}  ${BAU_DIGI_PREPAID_MSISDN}    ${performPrepaidReloadSuccessResponse}
    Validate Reload History    ${performPrepaidReloadSuccessResponse}    ${getReloadHistoryResponse}
    Log Reload Summary    ${BAU_DIGI_PREPAID_MSISDN}    ${getSubscriberProfileBeforeResponse}    ${getSubscriberPrepaidBalanceBeforeResponse}    ${performPrepaidReloadSuccessResponse}    ${getSubscriberProfileAfterResponse}    ${getSubscriberPrepaidBalanceAfterResponse}    ${getReloadHistoryResponse}
Test Case 6: Reload Pinless Using eWallet - TouchNGo [DIGI]
    [Tags]    sanity    regression
    ${accessToken}    Generate Access Token BAU
    ${getSubscriberProfileBeforeResponse}    Get Subscriber Profile Before    ${accessToken}    ${BAU_DIGI_PREPAID_MSISDN}
    ${getSubscriberPrepaidBalanceBeforeResponse}    Get Prepaid Balance Before    ${accessToken}    ${BAU_DIGI_PREPAID_MSISDN}
    ${performPrepaidReloadSuccessResponse}    Post Perform Prepaid Pinless Reload    ${accessToken}    ${BAU_DIGI_PREPAID_MSISDN}    paymentAmount=5.00    paymentMethod=TouchNGo    sourceChannel=223
    ${getSubscriberProfileAfterResponse}    Get Subscriber Profile After    ${accessToken}    ${BAU_DIGI_PREPAID_MSISDN}
    ${getSubscriberPrepaidBalanceAfterResponse}    Get Prepaid Balance After    ${accessToken}    ${BAU_DIGI_PREPAID_MSISDN}
    Validate Reload Amount Correct    ${getSubscriberPrepaidBalanceBeforeResponse}    ${performPrepaidReloadSuccessResponse}    ${getSubscriberPrepaidBalanceAfterResponse}
    Validate Prepaid Lifecycle Active   ${getSubscriberProfileBeforeResponse}    ${getSubscriberProfileAfterResponse}
    ${getReloadHistoryResponse}    Get Reload History  ${accessToken}  ${BAU_DIGI_PREPAID_MSISDN}    ${performPrepaidReloadSuccessResponse}
    Validate Reload History    ${performPrepaidReloadSuccessResponse}    ${getReloadHistoryResponse}
    Log Reload Summary    ${BAU_DIGI_PREPAID_MSISDN}    ${getSubscriberProfileBeforeResponse}    ${getSubscriberPrepaidBalanceBeforeResponse}    ${performPrepaidReloadSuccessResponse}    ${getSubscriberProfileAfterResponse}    ${getSubscriberPrepaidBalanceAfterResponse}    ${getReloadHistoryResponse}
Test Case 7: Reload Pinless Using eWallet - GrabPay [DIGI]
    [Tags]    sanity    regression
    ${accessToken}    Generate Access Token BAU
    ${getSubscriberProfileBeforeResponse}    Get Subscriber Profile Before    ${accessToken}    ${BAU_DIGI_PREPAID_MSISDN}
    ${getSubscriberPrepaidBalanceBeforeResponse}    Get Prepaid Balance Before    ${accessToken}    ${BAU_DIGI_PREPAID_MSISDN}
    ${performPrepaidReloadSuccessResponse}    Post Perform Prepaid Pinless Reload    ${accessToken}    ${BAU_DIGI_PREPAID_MSISDN}    paymentAmount=5.00    paymentMethod=GrabPay    sourceChannel=223
    ${getSubscriberProfileAfterResponse}    Get Subscriber Profile After    ${accessToken}    ${BAU_DIGI_PREPAID_MSISDN}
    ${getSubscriberPrepaidBalanceAfterResponse}    Get Prepaid Balance After    ${accessToken}    ${BAU_DIGI_PREPAID_MSISDN}
    Validate Reload Amount Correct    ${getSubscriberPrepaidBalanceBeforeResponse}    ${performPrepaidReloadSuccessResponse}    ${getSubscriberPrepaidBalanceAfterResponse}
    Validate Prepaid Lifecycle Active   ${getSubscriberProfileBeforeResponse}    ${getSubscriberProfileAfterResponse}
    ${getReloadHistoryResponse}    Get Reload History  ${accessToken}  ${BAU_DIGI_PREPAID_MSISDN}    ${performPrepaidReloadSuccessResponse}
    Validate Reload History    ${performPrepaidReloadSuccessResponse}    ${getReloadHistoryResponse}
    Log Reload Summary    ${BAU_DIGI_PREPAID_MSISDN}    ${getSubscriberProfileBeforeResponse}    ${getSubscriberPrepaidBalanceBeforeResponse}    ${performPrepaidReloadSuccessResponse}    ${getSubscriberProfileAfterResponse}    ${getSubscriberPrepaidBalanceAfterResponse}    ${getReloadHistoryResponse}
Test Case 8: Reload Pinless Using eWallet - ShopeePay [DIGI]
    [Tags]    regression
    ${accessToken}    Generate Access Token BAU
    ${getSubscriberProfileBeforeResponse}    Get Subscriber Profile Before    ${accessToken}    ${BAU_DIGI_PREPAID_MSISDN}
    ${getSubscriberPrepaidBalanceBeforeResponse}    Get Prepaid Balance Before    ${accessToken}    ${BAU_DIGI_PREPAID_MSISDN}
    ${performPrepaidReloadSuccessResponse}    Post Perform Prepaid Pinless Reload    ${accessToken}    ${BAU_DIGI_PREPAID_MSISDN}    paymentAmount=5.00    paymentMethod=ShopeePay    sourceChannel=223
    ${getSubscriberProfileAfterResponse}    Get Subscriber Profile After    ${accessToken}    ${BAU_DIGI_PREPAID_MSISDN}
    ${getSubscriberPrepaidBalanceAfterResponse}    Get Prepaid Balance After    ${accessToken}    ${BAU_DIGI_PREPAID_MSISDN}
    Validate Reload Amount Correct    ${getSubscriberPrepaidBalanceBeforeResponse}    ${performPrepaidReloadSuccessResponse}    ${getSubscriberPrepaidBalanceAfterResponse}
    Validate Prepaid Lifecycle Active   ${getSubscriberProfileBeforeResponse}    ${getSubscriberProfileAfterResponse}
    ${getReloadHistoryResponse}    Get Reload History  ${accessToken}  ${BAU_DIGI_PREPAID_MSISDN}    ${performPrepaidReloadSuccessResponse}
    Validate Reload History    ${performPrepaidReloadSuccessResponse}    ${getReloadHistoryResponse}
    Log Reload Summary    ${BAU_DIGI_PREPAID_MSISDN}    ${getSubscriberProfileBeforeResponse}    ${getSubscriberPrepaidBalanceBeforeResponse}    ${performPrepaidReloadSuccessResponse}    ${getSubscriberProfileAfterResponse}    ${getSubscriberPrepaidBalanceAfterResponse}    ${getReloadHistoryResponse}
Test Case 9: Reload Pinless Using eWallet - Boost [DIGI]
    [Tags]    regression
    ${accessToken}    Generate Access Token BAU
    ${getSubscriberProfileBeforeResponse}    Get Subscriber Profile Before    ${accessToken}    ${BAU_DIGI_PREPAID_MSISDN}
    ${getSubscriberPrepaidBalanceBeforeResponse}    Get Prepaid Balance Before    ${accessToken}    ${BAU_DIGI_PREPAID_MSISDN}
    ${performPrepaidReloadSuccessResponse}    Post Perform Prepaid Pinless Reload    ${accessToken}    ${BAU_DIGI_PREPAID_MSISDN}    paymentAmount=5.00    paymentMethod=Boost    sourceChannel=223
    ${getSubscriberProfileAfterResponse}    Get Subscriber Profile After    ${accessToken}    ${BAU_DIGI_PREPAID_MSISDN}
    ${getSubscriberPrepaidBalanceAfterResponse}    Get Prepaid Balance After    ${accessToken}    ${BAU_DIGI_PREPAID_MSISDN}
    Validate Reload Amount Correct    ${getSubscriberPrepaidBalanceBeforeResponse}    ${performPrepaidReloadSuccessResponse}    ${getSubscriberPrepaidBalanceAfterResponse}
    Validate Prepaid Lifecycle Active   ${getSubscriberProfileBeforeResponse}    ${getSubscriberProfileAfterResponse}
    ${getReloadHistoryResponse}    Get Reload History  ${accessToken}  ${BAU_DIGI_PREPAID_MSISDN}    ${performPrepaidReloadSuccessResponse}
    Validate Reload History    ${performPrepaidReloadSuccessResponse}    ${getReloadHistoryResponse}
    Log Reload Summary    ${BAU_DIGI_PREPAID_MSISDN}    ${getSubscriberProfileBeforeResponse}    ${getSubscriberPrepaidBalanceBeforeResponse}    ${performPrepaidReloadSuccessResponse}    ${getSubscriberProfileAfterResponse}    ${getSubscriberPrepaidBalanceAfterResponse}    ${getReloadHistoryResponse}



# CELCOM RELOAD PINLESS TEST CASES #
Test Case 10: Reload Pinless Using Cash [CELCOM]
    [Tags]    smoke    sanity    regression
    ${accessToken}    Generate Access Token BAU
    ${getSubscriberProfileBeforeResponse}    Get Subscriber Profile Before    ${accessToken}    ${BAU_CELCOM_PREPAID_MSISDN}
    ${getSubscriberPrepaidBalanceBeforeResponse}    Get Prepaid Balance Before    ${accessToken}    ${BAU_CELCOM_PREPAID_MSISDN}
    ${performPrepaidReloadSuccessResponse}    Post Perform Prepaid Pinless Reload    ${accessToken}    ${BAU_CELCOM_PREPAID_MSISDN}    paymentAmount=5.00    paymentMethod=Cash    sourceChannel=223
    ${getSubscriberProfileAfterResponse}    Get Subscriber Profile After    ${accessToken}    ${BAU_CELCOM_PREPAID_MSISDN}
    ${getSubscriberPrepaidBalanceAfterResponse}    Get Prepaid Balance After    ${accessToken}    ${BAU_CELCOM_PREPAID_MSISDN}
    Validate Reload Amount Correct    ${getSubscriberPrepaidBalanceBeforeResponse}    ${performPrepaidReloadSuccessResponse}    ${getSubscriberPrepaidBalanceAfterResponse}
    Validate Prepaid Lifecycle Active   ${getSubscriberProfileBeforeResponse}    ${getSubscriberProfileAfterResponse}
    ${getReloadHistoryResponse}    Get Reload History  ${accessToken}  ${BAU_CELCOM_PREPAID_MSISDN}    ${performPrepaidReloadSuccessResponse}
    Validate Reload History    ${performPrepaidReloadSuccessResponse}    ${getReloadHistoryResponse}
    Log Reload Summary    ${BAU_CELCOM_PREPAID_MSISDN}    ${getSubscriberProfileBeforeResponse}    ${getSubscriberPrepaidBalanceBeforeResponse}    ${performPrepaidReloadSuccessResponse}    ${getSubscriberProfileAfterResponse}    ${getSubscriberPrepaidBalanceAfterResponse}    ${getReloadHistoryResponse}
Test Case 11: Reload Pinless Using OnlineBanking [CELCOM]
    [Tags]    sanity    regression
    ${accessToken}    Generate Access Token BAU
    ${getSubscriberProfileBeforeResponse}    Get Subscriber Profile Before    ${accessToken}    ${BAU_CELCOM_PREPAID_MSISDN}
    ${getSubscriberPrepaidBalanceBeforeResponse}    Get Prepaid Balance Before    ${accessToken}    ${BAU_CELCOM_PREPAID_MSISDN}
    ${performPrepaidReloadSuccessResponse}    Post Perform Prepaid Pinless Reload    ${accessToken}    ${BAU_CELCOM_PREPAID_MSISDN}    paymentAmount=5.00    paymentMethod=OnlineBanking    sourceChannel=223
    ${getSubscriberProfileAfterResponse}    Get Subscriber Profile After    ${accessToken}    ${BAU_CELCOM_PREPAID_MSISDN}
    ${getSubscriberPrepaidBalanceAfterResponse}    Get Prepaid Balance After    ${accessToken}    ${BAU_CELCOM_PREPAID_MSISDN}
    Validate Reload Amount Correct    ${getSubscriberPrepaidBalanceBeforeResponse}    ${performPrepaidReloadSuccessResponse}    ${getSubscriberPrepaidBalanceAfterResponse}
    Validate Prepaid Lifecycle Active   ${getSubscriberProfileBeforeResponse}    ${getSubscriberProfileAfterResponse}
    ${getReloadHistoryResponse}    Get Reload History  ${accessToken}  ${BAU_CELCOM_PREPAID_MSISDN}    ${performPrepaidReloadSuccessResponse}
    Validate Reload History    ${performPrepaidReloadSuccessResponse}    ${getReloadHistoryResponse}
    Log Reload Summary    ${BAU_CELCOM_PREPAID_MSISDN}    ${getSubscriberProfileBeforeResponse}    ${getSubscriberPrepaidBalanceBeforeResponse}    ${performPrepaidReloadSuccessResponse}    ${getSubscriberProfileAfterResponse}    ${getSubscriberPrepaidBalanceAfterResponse}    ${getReloadHistoryResponse}
Test Case 12: Reload Pinless Using CreditCard - AMEX [CELCOM]
    [Tags]    sanity    regression
    ${accessToken}    Generate Access Token BAU
    ${getSubscriberProfileBeforeResponse}    Get Subscriber Profile Before    ${accessToken}    ${BAU_CELCOM_PREPAID_MSISDN}
    ${getSubscriberPrepaidBalanceBeforeResponse}    Get Prepaid Balance Before    ${accessToken}    ${BAU_CELCOM_PREPAID_MSISDN}
    ${performPrepaidReloadSuccessResponse}    Post Perform Prepaid Pinless Reload    ${accessToken}    ${BAU_CELCOM_PREPAID_MSISDN}    paymentAmount=5.00    paymentMethod=AMEX    sourceChannel=223
    ${getSubscriberProfileAfterResponse}    Get Subscriber Profile After    ${accessToken}    ${BAU_CELCOM_PREPAID_MSISDN}
    ${getSubscriberPrepaidBalanceAfterResponse}    Get Prepaid Balance After    ${accessToken}    ${BAU_CELCOM_PREPAID_MSISDN}
    Validate Reload Amount Correct    ${getSubscriberPrepaidBalanceBeforeResponse}    ${performPrepaidReloadSuccessResponse}    ${getSubscriberPrepaidBalanceAfterResponse}
    Validate Prepaid Lifecycle Active   ${getSubscriberProfileBeforeResponse}    ${getSubscriberProfileAfterResponse}
    ${getReloadHistoryResponse}    Get Reload History  ${accessToken}  ${BAU_CELCOM_PREPAID_MSISDN}    ${performPrepaidReloadSuccessResponse}
    Validate Reload History    ${performPrepaidReloadSuccessResponse}    ${getReloadHistoryResponse}
    Log Reload Summary    ${BAU_CELCOM_PREPAID_MSISDN}    ${getSubscriberProfileBeforeResponse}    ${getSubscriberPrepaidBalanceBeforeResponse}    ${performPrepaidReloadSuccessResponse}    ${getSubscriberProfileAfterResponse}    ${getSubscriberPrepaidBalanceAfterResponse}    ${getReloadHistoryResponse}
Test Case 13: Reload Pinless Using CreditCard - MasterCard [CELCOM]
    [Tags]    sanity    regression
    ${accessToken}    Generate Access Token BAU
    ${getSubscriberProfileBeforeResponse}    Get Subscriber Profile Before    ${accessToken}    ${BAU_CELCOM_PREPAID_MSISDN}
    ${getSubscriberPrepaidBalanceBeforeResponse}    Get Prepaid Balance Before    ${accessToken}    ${BAU_CELCOM_PREPAID_MSISDN}
    ${performPrepaidReloadSuccessResponse}    Post Perform Prepaid Pinless Reload    ${accessToken}    ${BAU_CELCOM_PREPAID_MSISDN}    paymentAmount=5.00    paymentMethod=MasterCard    sourceChannel=223
    ${getSubscriberProfileAfterResponse}    Get Subscriber Profile After    ${accessToken}    ${BAU_CELCOM_PREPAID_MSISDN}
    ${getSubscriberPrepaidBalanceAfterResponse}    Get Prepaid Balance After    ${accessToken}    ${BAU_CELCOM_PREPAID_MSISDN}
    Validate Reload Amount Correct    ${getSubscriberPrepaidBalanceBeforeResponse}    ${performPrepaidReloadSuccessResponse}    ${getSubscriberPrepaidBalanceAfterResponse}
    Validate Prepaid Lifecycle Active   ${getSubscriberProfileBeforeResponse}    ${getSubscriberProfileAfterResponse}
    ${getReloadHistoryResponse}    Get Reload History  ${accessToken}  ${BAU_CELCOM_PREPAID_MSISDN}    ${performPrepaidReloadSuccessResponse}
    Validate Reload History    ${performPrepaidReloadSuccessResponse}    ${getReloadHistoryResponse}
    Log Reload Summary    ${BAU_CELCOM_PREPAID_MSISDN}    ${getSubscriberProfileBeforeResponse}    ${getSubscriberPrepaidBalanceBeforeResponse}    ${performPrepaidReloadSuccessResponse}    ${getSubscriberProfileAfterResponse}    ${getSubscriberPrepaidBalanceAfterResponse}    ${getReloadHistoryResponse}
Test Case 14: Reload Pinless Using CreditCard - VISA [CELCOM]
    [Tags]    sanity    regression
    ${accessToken}    Generate Access Token BAU
    ${getSubscriberProfileBeforeResponse}    Get Subscriber Profile Before    ${accessToken}    ${BAU_CELCOM_PREPAID_MSISDN}
    ${getSubscriberPrepaidBalanceBeforeResponse}    Get Prepaid Balance Before    ${accessToken}    ${BAU_CELCOM_PREPAID_MSISDN}
    ${performPrepaidReloadSuccessResponse}    Post Perform Prepaid Pinless Reload    ${accessToken}    ${BAU_CELCOM_PREPAID_MSISDN}    paymentAmount=5.00    paymentMethod=VISA    sourceChannel=223
    ${getSubscriberProfileAfterResponse}    Get Subscriber Profile After    ${accessToken}    ${BAU_CELCOM_PREPAID_MSISDN}
    ${getSubscriberPrepaidBalanceAfterResponse}    Get Prepaid Balance After    ${accessToken}    ${BAU_CELCOM_PREPAID_MSISDN}
    Validate Reload Amount Correct    ${getSubscriberPrepaidBalanceBeforeResponse}    ${performPrepaidReloadSuccessResponse}    ${getSubscriberPrepaidBalanceAfterResponse}
    Validate Prepaid Lifecycle Active   ${getSubscriberProfileBeforeResponse}    ${getSubscriberProfileAfterResponse}
    ${getReloadHistoryResponse}    Get Reload History  ${accessToken}  ${BAU_CELCOM_PREPAID_MSISDN}    ${performPrepaidReloadSuccessResponse}
    Validate Reload History    ${performPrepaidReloadSuccessResponse}    ${getReloadHistoryResponse}
    Log Reload Summary    ${BAU_CELCOM_PREPAID_MSISDN}    ${getSubscriberProfileBeforeResponse}    ${getSubscriberPrepaidBalanceBeforeResponse}    ${performPrepaidReloadSuccessResponse}    ${getSubscriberProfileAfterResponse}    ${getSubscriberPrepaidBalanceAfterResponse}    ${getReloadHistoryResponse}
Test Case 15: Reload Pinless Using eWallet - TouchNGo [CELCOM]
    [Tags]    sanity    regression
    ${accessToken}    Generate Access Token BAU
    ${getSubscriberProfileBeforeResponse}    Get Subscriber Profile Before    ${accessToken}    ${BAU_CELCOM_PREPAID_MSISDN}
    ${getSubscriberPrepaidBalanceBeforeResponse}    Get Prepaid Balance Before    ${accessToken}    ${BAU_CELCOM_PREPAID_MSISDN}
    ${performPrepaidReloadSuccessResponse}    Post Perform Prepaid Pinless Reload    ${accessToken}    ${BAU_CELCOM_PREPAID_MSISDN}    paymentAmount=5.00    paymentMethod=TouchNGo    sourceChannel=223
    ${getSubscriberProfileAfterResponse}    Get Subscriber Profile After    ${accessToken}    ${BAU_CELCOM_PREPAID_MSISDN}
    ${getSubscriberPrepaidBalanceAfterResponse}    Get Prepaid Balance After    ${accessToken}    ${BAU_CELCOM_PREPAID_MSISDN}
    Validate Reload Amount Correct    ${getSubscriberPrepaidBalanceBeforeResponse}    ${performPrepaidReloadSuccessResponse}    ${getSubscriberPrepaidBalanceAfterResponse}
    Validate Prepaid Lifecycle Active   ${getSubscriberProfileBeforeResponse}    ${getSubscriberProfileAfterResponse}
    ${getReloadHistoryResponse}    Get Reload History  ${accessToken}  ${BAU_CELCOM_PREPAID_MSISDN}    ${performPrepaidReloadSuccessResponse}
    Validate Reload History    ${performPrepaidReloadSuccessResponse}    ${getReloadHistoryResponse}
    Log Reload Summary    ${BAU_CELCOM_PREPAID_MSISDN}    ${getSubscriberProfileBeforeResponse}    ${getSubscriberPrepaidBalanceBeforeResponse}    ${performPrepaidReloadSuccessResponse}    ${getSubscriberProfileAfterResponse}    ${getSubscriberPrepaidBalanceAfterResponse}    ${getReloadHistoryResponse}
Test Case 16: Reload Pinless Using eWallet - GrabPay [CELCOM]
    [Tags]    sanity    regression
    ${accessToken}    Generate Access Token BAU
    ${getSubscriberProfileBeforeResponse}    Get Subscriber Profile Before    ${accessToken}    ${BAU_CELCOM_PREPAID_MSISDN}
    ${getSubscriberPrepaidBalanceBeforeResponse}    Get Prepaid Balance Before    ${accessToken}    ${BAU_CELCOM_PREPAID_MSISDN}
    ${performPrepaidReloadSuccessResponse}    Post Perform Prepaid Pinless Reload    ${accessToken}    ${BAU_CELCOM_PREPAID_MSISDN}    paymentAmount=5.00    paymentMethod=GrabPay    sourceChannel=223
    ${getSubscriberProfileAfterResponse}    Get Subscriber Profile After    ${accessToken}    ${BAU_CELCOM_PREPAID_MSISDN}
    ${getSubscriberPrepaidBalanceAfterResponse}    Get Prepaid Balance After    ${accessToken}    ${BAU_CELCOM_PREPAID_MSISDN}
    Validate Reload Amount Correct    ${getSubscriberPrepaidBalanceBeforeResponse}    ${performPrepaidReloadSuccessResponse}    ${getSubscriberPrepaidBalanceAfterResponse}
    Validate Prepaid Lifecycle Active   ${getSubscriberProfileBeforeResponse}    ${getSubscriberProfileAfterResponse}
    ${getReloadHistoryResponse}    Get Reload History  ${accessToken}  ${BAU_CELCOM_PREPAID_MSISDN}    ${performPrepaidReloadSuccessResponse}
    Validate Reload History    ${performPrepaidReloadSuccessResponse}    ${getReloadHistoryResponse}
    Log Reload Summary    ${BAU_CELCOM_PREPAID_MSISDN}    ${getSubscriberProfileBeforeResponse}    ${getSubscriberPrepaidBalanceBeforeResponse}    ${performPrepaidReloadSuccessResponse}    ${getSubscriberProfileAfterResponse}    ${getSubscriberPrepaidBalanceAfterResponse}    ${getReloadHistoryResponse}
Test Case 17: Reload Pinless Using eWallet - ShopeePay [CELCOM]
    [Tags]    regression
    ${accessToken}    Generate Access Token BAU
    ${getSubscriberProfileBeforeResponse}    Get Subscriber Profile Before    ${accessToken}    ${BAU_CELCOM_PREPAID_MSISDN}
    ${getSubscriberPrepaidBalanceBeforeResponse}    Get Prepaid Balance Before    ${accessToken}    ${BAU_CELCOM_PREPAID_MSISDN}
    ${performPrepaidReloadSuccessResponse}    Post Perform Prepaid Pinless Reload    ${accessToken}    ${BAU_CELCOM_PREPAID_MSISDN}    paymentAmount=5.00    paymentMethod=ShopeePay    sourceChannel=223
    ${getSubscriberProfileAfterResponse}    Get Subscriber Profile After    ${accessToken}    ${BAU_CELCOM_PREPAID_MSISDN}
    ${getSubscriberPrepaidBalanceAfterResponse}    Get Prepaid Balance After    ${accessToken}    ${BAU_CELCOM_PREPAID_MSISDN}
    Validate Reload Amount Correct    ${getSubscriberPrepaidBalanceBeforeResponse}    ${performPrepaidReloadSuccessResponse}    ${getSubscriberPrepaidBalanceAfterResponse}
    Validate Prepaid Lifecycle Active   ${getSubscriberProfileBeforeResponse}    ${getSubscriberProfileAfterResponse}
    ${getReloadHistoryResponse}    Get Reload History  ${accessToken}  ${BAU_CELCOM_PREPAID_MSISDN}    ${performPrepaidReloadSuccessResponse}
    Validate Reload History    ${performPrepaidReloadSuccessResponse}    ${getReloadHistoryResponse}
    Log Reload Summary    ${BAU_CELCOM_PREPAID_MSISDN}    ${getSubscriberProfileBeforeResponse}    ${getSubscriberPrepaidBalanceBeforeResponse}    ${performPrepaidReloadSuccessResponse}    ${getSubscriberProfileAfterResponse}    ${getSubscriberPrepaidBalanceAfterResponse}    ${getReloadHistoryResponse}
Test Case 18: Reload Pinless Using eWallet - Boost [CELCOM]
    [Tags]    regression
    ${accessToken}    Generate Access Token BAU
    ${getSubscriberProfileBeforeResponse}    Get Subscriber Profile Before    ${accessToken}    ${BAU_CELCOM_PREPAID_MSISDN}
    ${getSubscriberPrepaidBalanceBeforeResponse}    Get Prepaid Balance Before    ${accessToken}    ${BAU_CELCOM_PREPAID_MSISDN}
    ${performPrepaidReloadSuccessResponse}    Post Perform Prepaid Pinless Reload    ${accessToken}    ${BAU_CELCOM_PREPAID_MSISDN}    paymentAmount=5.00    paymentMethod=Boost    sourceChannel=223
    ${getSubscriberProfileAfterResponse}    Get Subscriber Profile After    ${accessToken}    ${BAU_CELCOM_PREPAID_MSISDN}
    ${getSubscriberPrepaidBalanceAfterResponse}    Get Prepaid Balance After    ${accessToken}    ${BAU_CELCOM_PREPAID_MSISDN}
    Validate Reload Amount Correct    ${getSubscriberPrepaidBalanceBeforeResponse}    ${performPrepaidReloadSuccessResponse}    ${getSubscriberPrepaidBalanceAfterResponse}
    Validate Prepaid Lifecycle Active   ${getSubscriberProfileBeforeResponse}    ${getSubscriberProfileAfterResponse}
    ${getReloadHistoryResponse}    Get Reload History  ${accessToken}  ${BAU_CELCOM_PREPAID_MSISDN}    ${performPrepaidReloadSuccessResponse}
    Validate Reload History    ${performPrepaidReloadSuccessResponse}    ${getReloadHistoryResponse}
    Log Reload Summary    ${BAU_CELCOM_PREPAID_MSISDN}    ${getSubscriberProfileBeforeResponse}    ${getSubscriberPrepaidBalanceBeforeResponse}    ${performPrepaidReloadSuccessResponse}    ${getSubscriberProfileAfterResponse}    ${getSubscriberPrepaidBalanceAfterResponse}    ${getReloadHistoryResponse}



# LIFECYCLE TEST CASES #
Test Case 19: Lifecycle Reload Barred [DIGI]
    [Tags]    regression
    ${accessToken}    Generate Access Token BAU
    ${getSubscriberProfileBeforeResponse}    Get Subscriber Profile Before    ${accessToken}    ${BAU_DIGI_PREPAID_MSISDN_BARRING}
    ${getSubscriberPrepaidBalanceBeforeResponse}    Get Prepaid Balance Before    ${accessToken}    ${BAU_DIGI_PREPAID_MSISDN_BARRING}
    ${performPrepaidReloadSuccessResponse}    Post Perform Prepaid Pinless Reload    ${accessToken}    ${BAU_DIGI_PREPAID_MSISDN_BARRING}    paymentAmount=5.00    paymentMethod=Cash    sourceChannel=223
    ${getSubscriberProfileAfterResponse}    Get Subscriber Profile After    ${accessToken}    ${BAU_DIGI_PREPAID_MSISDN_BARRING}
    ${getSubscriberPrepaidBalanceAfterResponse}    Get Prepaid Balance After    ${accessToken}    ${BAU_DIGI_PREPAID_MSISDN_BARRING}
    Validate Reload Amount Correct    ${getSubscriberPrepaidBalanceBeforeResponse}    ${performPrepaidReloadSuccessResponse}    ${getSubscriberPrepaidBalanceAfterResponse}
    Validate Prepaid Lifecycle Updated From Barred To Active    ${getSubscriberProfileBeforeResponse}    ${getSubscriberProfileAfterResponse}
    ${getReloadHistoryResponse}    Get Reload History  ${accessToken}  ${BAU_DIGI_PREPAID_MSISDN_BARRING}    ${performPrepaidReloadSuccessResponse}
    Validate Reload History    ${performPrepaidReloadSuccessResponse}    ${getReloadHistoryResponse}
    Log Reload Summary    ${BAU_DIGI_PREPAID_MSISDN_BARRING}    ${getSubscriberProfileBeforeResponse}    ${getSubscriberPrepaidBalanceBeforeResponse}    ${performPrepaidReloadSuccessResponse}    ${getSubscriberProfileAfterResponse}    ${getSubscriberPrepaidBalanceAfterResponse}    ${getReloadHistoryResponse}
Test Case 20: Lifecycle Reload Barred [CELCOM]
    [Tags]    regression
    ${accessToken}    Generate Access Token BAU
    ${getSubscriberProfileBeforeResponse}    Get Subscriber Profile Before    ${accessToken}    ${BAU_CELCOM_PREPAID_MSISDN_BARRING}
    ${getSubscriberPrepaidBalanceBeforeResponse}    Get Prepaid Balance Before    ${accessToken}    ${BAU_CELCOM_PREPAID_MSISDN_BARRING}
    ${performPrepaidReloadSuccessResponse}    Post Perform Prepaid Pinless Reload    ${accessToken}    ${BAU_CELCOM_PREPAID_MSISDN_BARRING}    paymentAmount=5.00    paymentMethod=Cash    sourceChannel=223
    ${getSubscriberProfileAfterResponse}    Get Subscriber Profile After    ${accessToken}    ${BAU_CELCOM_PREPAID_MSISDN_BARRING}
    ${getSubscriberPrepaidBalanceAfterResponse}    Get Prepaid Balance After    ${accessToken}    ${BAU_CELCOM_PREPAID_MSISDN_BARRING}
    Validate Reload Amount Correct    ${getSubscriberPrepaidBalanceBeforeResponse}    ${performPrepaidReloadSuccessResponse}    ${getSubscriberPrepaidBalanceAfterResponse}
    Validate Prepaid Lifecycle Updated From Barred To Active   ${getSubscriberProfileBeforeResponse}    ${getSubscriberProfileAfterResponse}
    ${getReloadHistoryResponse}    Get Reload History  ${accessToken}  ${BAU_CELCOM_PREPAID_MSISDN_BARRING}    ${performPrepaidReloadSuccessResponse}
    Validate Reload History    ${performPrepaidReloadSuccessResponse}    ${getReloadHistoryResponse}
    Log Reload Summary    ${BAU_CELCOM_PREPAID_MSISDN_BARRING}    ${getSubscriberProfileBeforeResponse}    ${getSubscriberPrepaidBalanceBeforeResponse}    ${performPrepaidReloadSuccessResponse}    ${getSubscriberProfileAfterResponse}    ${getSubscriberPrepaidBalanceAfterResponse}    ${getReloadHistoryResponse}
Test Case 21: Lifecycle Reload Suspended [DIGI]
    [Tags]    regression
    ${accessToken}    Generate Access Token BAU
    ${getSubscriberProfileBeforeResponse}    Get Subscriber Profile Before    ${accessToken}    ${BAU_DIGI_PREPAID_MSISDN_SUSPENDED}
    ${getSubscriberPrepaidBalanceBeforeResponse}    Get Prepaid Balance Before    ${accessToken}    ${BAU_DIGI_PREPAID_MSISDN_SUSPENDED}
    ${performPrepaidReloadUnsuccessResponse}    Post Perform Prepaid Pinless Reload Negative    ${accessToken}    ${BAU_DIGI_PREPAID_MSISDN_SUSPENDED}    paymentAmount=5.00    paymentMethod=OnlineBanking    sourceChannel=223
    ${getSubscriberProfileAfterResponse}    Get Subscriber Profile After    ${accessToken}    ${BAU_DIGI_PREPAID_MSISDN_SUSPENDED}
    ${getSubscriberPrepaidBalanceAfterResponse}    Get Prepaid Balance After    ${accessToken}    ${BAU_DIGI_PREPAID_MSISDN_SUSPENDED}
    Validate Reload Amount Unchanged    ${getSubscriberPrepaidBalanceBeforeResponse}   ${getSubscriberPrepaidBalanceAfterResponse}
    Validate Prepaid Lifecycle Suspended    ${getSubscriberProfileBeforeResponse}    ${getSubscriberProfileAfterResponse}
    Log Reload Summary Invalid    ${BAU_DIGI_PREPAID_MSISDN}    ${getSubscriberProfileBeforeResponse}    ${getSubscriberPrepaidBalanceBeforeResponse}    ${getSubscriberProfileAfterResponse}    ${getSubscriberPrepaidBalanceAfterResponse}    ${performPrepaidReloadUnsuccessResponse}
Test Case 22: Lifecycle Reload Suspended [CELCOM]
    [Tags]    regression
    ${accessToken}    Generate Access Token BAU
    ${getSubscriberProfileBeforeResponse}    Get Subscriber Profile Before    ${accessToken}    ${BAU_CELCOM_PREPAID_MSISDN_SUSPENDED}
    ${getSubscriberPrepaidBalanceBeforeResponse}    Get Prepaid Balance Before    ${accessToken}    ${BAU_CELCOM_PREPAID_MSISDN_SUSPENDED}
    ${performPrepaidReloadUnsuccessResponse}    Post Perform Prepaid Pinless Reload Negative    ${accessToken}    ${BAU_CELCOM_PREPAID_MSISDN_SUSPENDED}    paymentAmount=5.00    paymentMethod=OnlineBanking    sourceChannel=223
    ${getSubscriberProfileAfterResponse}    Get Subscriber Profile After    ${accessToken}    ${BAU_CELCOM_PREPAID_MSISDN_SUSPENDED}
    ${getSubscriberPrepaidBalanceAfterResponse}    Get Prepaid Balance After    ${accessToken}    ${BAU_CELCOM_PREPAID_MSISDN_SUSPENDED}
    Validate Reload Amount Unchanged    ${getSubscriberPrepaidBalanceBeforeResponse}   ${getSubscriberPrepaidBalanceAfterResponse}
    Validate Prepaid Lifecycle Suspended    ${getSubscriberProfileBeforeResponse}    ${getSubscriberProfileAfterResponse}
    Log Reload Summary Invalid    ${BAU_CELCOM_PREPAID_MSISDN_SUSPENDED}    ${getSubscriberProfileBeforeResponse}    ${getSubscriberPrepaidBalanceBeforeResponse}    ${getSubscriberProfileAfterResponse}    ${getSubscriberPrepaidBalanceAfterResponse}    ${performPrepaidReloadUnsuccessResponse}
Test Case 23: Lifecycle Reload Deactivated [DIGI]
    [Tags]    regression
    ${accessToken}    Generate Access Token BAU
    ${getSubscriberProfileBeforeResponse}    Get Subscriber Profile Before    ${accessToken}    ${BAU_DIGI_PREPAID_MSISDN_DEACTIVATED}
    ${getSubscriberPrepaidBalanceBeforeResponse}    Get Prepaid Balance Before    ${accessToken}    ${BAU_DIGI_PREPAID_MSISDN_DEACTIVATED}
    ${performPrepaidReloadUnsuccessResponse}    Post Perform Prepaid Pinless Reload Negative    ${accessToken}    ${BAU_DIGI_PREPAID_MSISDN_DEACTIVATED}    paymentAmount=5.00    paymentMethod=OnlineBanking    sourceChannel=NGCA
    ${getSubscriberProfileAfterResponse}    Get Subscriber Profile After    ${accessToken}    ${BAU_DIGI_PREPAID_MSISDN_DEACTIVATED}
    ${getSubscriberPrepaidBalanceAfterResponse}    Get Prepaid Balance After    ${accessToken}    ${BAU_DIGI_PREPAID_MSISDN_DEACTIVATED}
    Validate Reload Amount Unchanged    ${getSubscriberPrepaidBalanceBeforeResponse}   ${getSubscriberPrepaidBalanceAfterResponse}
    Validate Prepaid Lifecycle Deactivated    ${getSubscriberProfileBeforeResponse}    ${getSubscriberProfileAfterResponse}
    Log Reload Summary Invalid    ${BAU_DIGI_PREPAID_MSISDN_DEACTIVATED}    ${getSubscriberProfileBeforeResponse}    ${getSubscriberPrepaidBalanceBeforeResponse}    ${getSubscriberProfileAfterResponse}    ${getSubscriberPrepaidBalanceAfterResponse}    ${performPrepaidReloadUnsuccessResponse}
# Test Case 24: Lifecycle Reload Deactivated [CELCOM] #note: no proper test data
#     ${accessToken}    Generate Access Token BAU
#     ${getSubscriberProfileBeforeResponse}    Get Subscriber Profile Before    ${accessToken}    ${BAU_CELCOM_PREPAID_MSISDN_DEACTIVATED}
#     ${getSubscriberPrepaidBalanceBeforeResponse}    Get Prepaid Balance Before    ${accessToken}    ${BAU_CELCOM_PREPAID_MSISDN_DEACTIVATED}
#     ${performPrepaidReloadUnsuccessResponse}    Post Perform Prepaid Pinless Reload Negative    ${accessToken}    ${BAU_CELCOM_PREPAID_MSISDN_DEACTIVATED}    paymentAmount=5.50    paymentMethod=OnlineBanking    sourceChannel=NGCA
#     ${getSubscriberProfileAfterResponse}    Get Subscriber Profile After    ${accessToken}    ${BAU_CELCOM_PREPAID_MSISDN_DEACTIVATED}
#     ${getSubscriberPrepaidBalanceAfterResponse}    Get Prepaid Balance After    ${accessToken}    ${BAU_CELCOM_PREPAID_MSISDN_DEACTIVATED}
#     Validate Reload Amount Unchanged    ${getSubscriberPrepaidBalanceBeforeResponse}   ${getSubscriberPrepaidBalanceAfterResponse}
#     Validate Prepaid Lifecycle Deactivated    ${getSubscriberProfileBeforeResponse}    ${getSubscriberProfileAfterResponse}
#     Log Reload Summary Invalid    ${BAU_CELCOM_PREPAID_MSISDN_DEACTIVATED}    ${getSubscriberProfileBeforeResponse}    ${getSubscriberPrepaidBalanceBeforeResponse}    ${getSubscriberProfileAfterResponse}    ${getSubscriberPrepaidBalanceAfterResponse}    ${performPrepaidReloadUnsuccessResponse}
Test Case 25: Reload Postpaid [DIGI]
    [Tags]    regression
    ${accessToken}    Generate Access Token BAU
    ${getSubscriberProfileBeforeResponse}    Get Subscriber Profile Before    ${accessToken}    ${BAU_DIGI_POSTPAID_MSISDN}
    ${getSubscriberPrepaidBalanceBeforeResponse}    Get Prepaid Balance Before    ${accessToken}    ${BAU_DIGI_POSTPAID_MSISDN}
    ${getBillingInfoBeforeResponse}    Get Billing Info Before    ${accessToken}    ${BAU_DIGI_POSTPAID_MSISDN}
    ${performPrepaidReloadUnsuccessResponse}    Post Perform Prepaid Pinless Reload Negative    ${accessToken}    ${BAU_DIGI_POSTPAID_MSISDN}    paymentAmount=5.00    paymentMethod=OnlineBanking    sourceChannel=NGCA
    ${getSubscriberProfileAfterResponse}    Get Subscriber Profile After    ${accessToken}    ${BAU_DIGI_POSTPAID_MSISDN}
    ${getSubscriberPrepaidBalanceAfterResponse}    Get Prepaid Balance After    ${accessToken}    ${BAU_DIGI_POSTPAID_MSISDN}
    ${getBillingInfoAfterResponse}    Get Billing Info After    ${accessToken}    ${BAU_DIGI_POSTPAID_MSISDN}
    Validate Postpaid Lifecycle    ${getSubscriberProfileBeforeResponse}    ${getSubscriberProfileAfterResponse}
    Log Reload Summary Invalid II    ${BAU_DIGI_PREPAID_MSISDN_DEACTIVATED}    ${getSubscriberProfileBeforeResponse}    ${getSubscriberPrepaidBalanceBeforeResponse}    ${getBillingInfoBeforeResponse}    ${getSubscriberProfileAfterResponse}    ${getSubscriberPrepaidBalanceAfterResponse}    ${getBillingInfoAfterResponse}    ${performPrepaidReloadUnsuccessResponse}
Test Case 26: Reload Postpaid [CELCOM]
    [Tags]    regression
    ${accessToken}    Generate Access Token BAU
    ${getSubscriberProfileBeforeResponse}    Get Subscriber Profile Before    ${accessToken}    ${BAU_CELCOM_POSTPAID_MSISDN}
    ${getSubscriberPrepaidBalanceBeforeResponse}    Get Prepaid Balance Before    ${accessToken}    ${BAU_CELCOM_POSTPAID_MSISDN}
    ${getBillingInfoBeforeResponse}    Get Billing Info Before    ${accessToken}    ${BAU_CELCOM_POSTPAID_MSISDN}
    ${performPrepaidReloadUnsuccessResponse}    Post Perform Prepaid Pinless Reload Negative    ${accessToken}    ${BAU_CELCOM_POSTPAID_MSISDN}    paymentAmount=5.00    paymentMethod=OnlineBanking    sourceChannel=NGCA
    ${getSubscriberProfileAfterResponse}    Get Subscriber Profile After    ${accessToken}    ${BAU_CELCOM_POSTPAID_MSISDN}
    ${getSubscriberPrepaidBalanceAfterResponse}    Get Prepaid Balance After    ${accessToken}    ${BAU_CELCOM_POSTPAID_MSISDN}
    ${getBillingInfoAfterResponse}    Get Billing Info After    ${accessToken}    ${BAU_CELCOM_POSTPAID_MSISDN}
    Validate Postpaid Lifecycle    ${getSubscriberProfileBeforeResponse}    ${getSubscriberProfileAfterResponse}
    Log Reload Summary Invalid III    ${BAU_CELCOM_PREPAID_MSISDN_DEACTIVATED}    ${getSubscriberProfileBeforeResponse}    ${getSubscriberPrepaidBalanceBeforeResponse}    ${getBillingInfoBeforeResponse}    ${getSubscriberProfileAfterResponse}    ${getSubscriberPrepaidBalanceAfterResponse}    ${getBillingInfoAfterResponse}    ${performPrepaidReloadUnsuccessResponse}
Test Case 27: Reload Prepaid [MAXIS]
    [Tags]    regression
    ${accessToken}    Generate Access Token BAU
    ${getSubscriberProfileNonCD}    Get Subscriber Profile NonCD    ${accessToken}    ${BAU_MAXIS_PREPAID_MSISDN}
    Log Subscriber Invalid  ${BAU_MAXIS_PREPAID_MSISDN}    ${getSubscriberProfileNonCD}
# Test Case : Reload Pinless with All Payment Methods
#     @{methods}=    Create List    Cash    CreditCard    eWallet    GrabPay    Boost    OnlineBanking    ShopeePay    TouchNGo    DebitCard    AMEXcard    VisaMasterCard    Cheque    FPX    BillingAdjustment    Bank    Autobilling    AutoTopup    Voucher    Wallet    PostalOrder    TelegraphicTransfer    Credit
#     FOR    ${method}    IN    @{methods}
#         Log    Testing payment method: ${method}
#         Get Access Token
#         Get Subscriber Profile
#         Get Prepaid Balance Before
#         Post Perform Prepaid Pinless Reload    ${method}
#         Get Prepaid Balance After
#         Validate Reload Amount Correct
#     END

Test Case 1: Reload Pinless Using Cash
    ${accessToken}    Generate Access Token BAU
    Get Subscriber Profile    ${accessToken}    ${BAU_PREPAID_MSISDN}
    ${BALANCE_BEFORE}    Get Prepaid Balance Before    ${accessToken}    ${BAU_PREPAID_MSISDN}
    Post Perform Prepaid Pinless Reload    accessToken=${accessToken}    phoneNo=${BAU_PREPAID_MSISDN}    rechargeAmount=1.5    paymentMethod=Cash
    ${BALANCE_AFTER}    Get Prepaid Balance After    ${accessToken}    ${BAU_PREPAID_MSISDN}
    Validate Reload Amount Correct    BALANCE_BEFORE=${BALANCE_BEFORE}    RECHARGE_AMOUNT=1.5    BALANCE_AFTER=${BALANCE_AFTER}
