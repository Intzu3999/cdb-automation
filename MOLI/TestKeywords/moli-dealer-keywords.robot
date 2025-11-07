
*** Settings ***
Documentation    This file only share dealer wallet keywords only

Resource    ../MOLI-testSettings.robot

*** Keywords ***
#=====================NBC Reload========================

NBC Check Dealer Wallet
    [Arguments]    ${NBC_accessToken}
    ${NBC_headers}=    Create Dictionary
    ...    Content-Type=application/json
    ...    Authorization=${NBC_accessToken}
    ${NBC_requestor}=    Create Dictionary
    ...    id=${NBC_WALLET_ID}
    ...    secret=${NBC_WALLET_SECRET}
    ${NBC_request_body}=    Create Dictionary
    ...    orgCode=${NBC_ORGANIZATION_CODE}
    ...    requestType=B
    ...    requestor=${NBC_requestor} 
    Create Session    dealerWalletSession    ${NBC_MOLI_BASE_URL}    headers=${NBC_headers}    verify=true
    ${NBC_response}=    POST On Session    dealerWalletSession    ${NBC_CHECK_DEAlER_BALANCE}    json=${NBC_request_body}
    Should Be Equal As Integers    ${NBC_response.status_code}    200
    RETURN    ${NBC_response.json()}

NBC Validate Dealer Wallet Deduction
    [Arguments]    ${NBC_WALLET_BEFORE}    ${NBC_WALLET_AFTER}    ${NBC_RELOAD_AMOUNT}
    Log    Wallet Balance Before: ${NBC_WALLET_BEFORE}
    Log    Wallet Balance After: ${NBC_WALLET_AFTER}
    ${before}=    Evaluate    float(${NBC_WALLET_BEFORE}[0])
    ${after}=     Evaluate    float(${NBC_WALLET_AFTER}[0])
    ${deducted}=  Evaluate    round(${before} - ${after}, 2)
    Log    Deducted From Wallet: ${deducted}
    Should Be Equal As Numbers    ${deducted}    ${NBC_RELOAD_AMOUNT}    0.01

