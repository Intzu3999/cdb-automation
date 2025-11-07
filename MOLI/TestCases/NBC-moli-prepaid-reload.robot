*** Settings ***
Documentation    This file to store test cases only

# Resource    ../MOLI-testSettings.robot
Resource    ../TestKeywords/all_keywords.robot

*** Test Cases ***
Test Case 1: NBC Dealer Reload - Wallet Journey
    # Step 0: Generate Access Token
    ${NBC_accessToken}    Generate Access Token NBC
    # Step 1: Get Subscriber Profile before reload
    NBC Get Subscriber Profile    ${NBC_accessToken}    ${NBC_PREPAID_MSISDN}
    # Step 2: Get Prepaid Balance Before
    ${NBC_BALANCE_BEFORE}    NBC Get Prepaid Balance Before    ${NBC_accessToken}    ${NBC_PREPAID_MSISDN}
    Log To Console    \nBefore:${NBC_BALANCE_BEFORE}
    # Step 3: Check Recharge Eligibility
    ${NBC_ELIGIBILITY}    NBC Check Recharge Eligibility    ${NBC_accessToken}
    # Log    Recharge Eligibility Response: ${NBC_ELIGIBILITY}
    # Step 4: Get Dealer Wallet Balance Before
    ${NBC_WALLET_BEFORE}    NBC Check Dealer Wallet    ${NBC_accessToken}
    # Log To Console    Dealer Wallet Before: ${NBC_WALLET_BEFORE}
    # Step 5: Perform Dealer Reload
    ${NBC_RELOAD_RESPONSE}    NBC Peform Dealer Reload    ${NBC_accessToken}    NBC_reloadProductId=1350
    # Log    Reload Response: ${NBC_RELOAD_RESPONSE}
    # Step 6: Get Subscriber Profile after reload
    NBC Get Subscriber Profile    ${NBC_accessToken}    ${NBC_PREPAID_MSISDN}
    # Step 7: Get Prepaid Balance After
    ${NBC_BALANCE_AFTER}    NBC Get Prepaid Balance Before    ${NBC_accessToken}    ${NBC_PREPAID_MSISDN}
    Log To Console    \nAfter:${NBC_BALANCE_AFTER}
    # Step 8: Get Dealer Wallet Balance After
    ${NBC_WALLET_AFTER}    NBC Check Dealer Wallet    ${NBC_accessToken}
    # Log    Dealer Wallet After: ${NBC_WALLET_AFTER}
    # Step 9: Validate Subscriber Balance Increased
    NBC Validate Reload Amount    ${NBC_BALANCE_BEFORE}    ${NBC_BALANCE_AFTER}    ${NBC_RELOAD_AMOUNT}
    Log To Console    \nReload Amount:${NBC_RELOAD_AMOUNT}
    # Step 10: Validate Dealer Wallet Deduction
    # NBC Validate Dealer Wallet Deduction    ${NBC_WALLET_BEFORE}    ${NBC_WALLET_AFTER}    ${NBC_RELOAD_AMOUNT}
    # NBC Validate Reload Result   ${NBC_WALLET_BEFORE}    ${NBC_WALLET_AFTER}    ${NBC_RELOAD_AMOUNT}
