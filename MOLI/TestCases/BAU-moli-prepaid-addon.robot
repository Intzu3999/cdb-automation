*** Settings ***
Documentation    This file only store testcases for BAU Moli Prepaid AddOn

# Resource    ../MOLI-testSettings.robot
Resource    ../TestKeywords/all_keywords.robot

*** Test Cases ***
Test Case 1: Subscribe Internet Addon [DIGI Prepaid]
    [Documentation]    This test case ensures addon 5G39-55GB_UL Internet is correctly subscribed/unsubscribed
    ${accessToken}=    Generate Access Token BAU
    Get Subscriber Profile Before    ${accessToken}    ${BAU_DIGI_PREPAID_MSISDN}
    ${returnStatusBefore}    ${returnTypeBefore}    ${returnTerminationDateBefore}    Get Subscriber Profile Before    ${accessToken}    ${BAU_DIGI_PREPAID_MSISDN}
    ${internetOffers}    Get Account Usage Internet    ${accessToken}    ${BAU_DIGI_PREPAID_MSISDN}
    Check And Subscribe-Unsubscribe Addon Prepaid Digi    ${accessToken}    ${BAU_DIGI_PREPAID_MSISDN}    ${internetOffers}

Test Case 2: Subscribe Internet Addon [Celcom Prepaid]
    [Documentation]    This test case ensures addon 5G39-55GB_UL Internet is correctly subscribed/unsubscribed
    ${accessToken}=    Generate Access Token BAU
    Get Subscriber Profile    ${accessToken}    ${BAU_CELCOM_PREPAID_MSISDN}
    ${internetOffers}    Get Account Usage Internet    ${accessToken}    ${BAU_CELCOM_PREPAID_MSISDN}
    Check And Subscribe-Unsubscribe Addon Prepaid Celcom    ${accessToken}    ${BAU_CELCOM_PREPAID_MSISDN}    ${internetOffers}