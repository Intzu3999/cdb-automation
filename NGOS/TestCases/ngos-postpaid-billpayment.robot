*** Settings ***
Documentation    This file only to store test cases
Test Teardown   Close Browser

#Import
Resource        ../TestKeywords/ngos-allKeywords.robot

*** Test Cases ***

Test Case : NGOS PayBill Online Banking
    # Check Balance Using API
    # Get Customer
    Launch New Browser                browserName=chromium    headlessBoolean=false
    Open NGOS Bill Payment Page 1
    NGOS Perform Bill Payment
    VIA ONLINE_BANKING            ${MAYBANK2U_PATH}
    NGOS Success Page

# Test Case : NGOS PayBill Credit Card
#     Launch a new browser
#     Access NGOS Bill Payment Page 1
#     NGOS Perform Bill Payment
#     CREDIT_CARD                   ${NGOS_CARDNAME}      ${CC_CARDAMEX}      ${CC_CVCAMEX}       ${CC_EX_MONTH}      ${CC_EX_YEARS}
#     # TAC Page
#     # NGOS Success Page

# Test Case : TAC TABLE
#     Open New Browser
#     TAC Page