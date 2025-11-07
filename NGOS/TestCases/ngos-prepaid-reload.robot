*** Settings ***
Documentation    This file only to store test cases
Test Teardown   Close Browser

#Import
Resource        ../TestKeywords/ngos-allKeywords.robot

*** Test Cases ***

Test Case 1: Open NGOS Reload Page and Access
    Launch New Browser                browserName=chromium    headlessBoolean=false
    Access NGOS Reload Page
    Resize Screen Size

Test Case 2: Verify Insert Invalid MSISDN
    Launch New Browser                browserName=chromium    headlessBoolean=false
    Access NGOS Reload Page
    Resize Screen Size
    Verify NGOS Reload Page 1
    Verify Insert Invalid MSISDN
    Refresh Current Page 

Test Case 3: NGOS Reload -Cancel at NGPAY Page
    Launch New Browser                browserName=chromium    headlessBoolean=false
    Access NGOS Reload Page
    Resize Screen Size
    Verify NGOS Reload Page 1
    Verify Insert Valid MSISDN        
    Verify NGOS Reload Page 2
    Validate NGPAY Page
    Click on Back Button and Click YES Transaction at NGPAY Page
    Verify NGOS Failed Page

Test Case 4: NGOS Reload Journey RM10
    Launch New Browser                browserName=chromium    headlessBoolean=false
    Access NGOS Reload Page
    Resize Screen Size
    Verify NGOS Reload Page 1
    Verify Insert Valid MSISDN        
    Verify NGOS Reload Page 2
    Validate NGPAY Page
    Click on Back Button and Click NO Transaction at NGPAY Page
    Perform Payment Method Selection
    Online Banking Selection
    FPX Simulator Page 1
    FPX Simulator Page 2
    Verify NGOS Success Page
    #Mock Payment Page
    #Mark Payment As Success

    # Verify Insert Invalid number  INVALID_NUMBER=${INVALID_MSISDN}
    # Verify Insert valid number    VALID_NUMBER=${PREPAID_MSISDN}

#     CREDIT_CARD                   ${NGOS_CARDNAME}      ${CC_CARDAMEX}      ${CC_CVCAMEX}       ${CC_EX_MONTH}      ${CC_EX_YEARS}
#     TAC Page
#     NGOS Success Page
