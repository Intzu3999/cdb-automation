*** Settings ***
Documentation    Store bill payment keywords

#Import
Resource    ../NGOS-testSettings.robot

*** Keywords ***

Access a new browser
    Open Browser    about:blank    chromium    headless=false

Open NGOS Bill Payment Page 1
    New Page                    ${NGOS_STAGING_BASE_URL}${NGOS_BILLPAYMENT_URL}    wait_until=domcontentloaded
    Sleep    5
    Resize Screen Size
    Wait For Elements State     ${NGOS_MOBILE_FIELD}        visible

NGOS Perform Bill Payment
    Fill Text                   ${NGOS_MOBILE_FIELD}        ${POSTPAID_MSISDN}
    Take Screenshot
    Sleep    5
    Wait For Elements State     ${NGOS_SUBMIT_BUTTON}        enabled             timeout=50s
    Click                       ${NGOS_SUBMIT_BUTTON}
    Wait For Elements State     ${NGOS_BILL_AMOUNT_FIELD}    visible
    Fill Text                   ${NGOS_BILL_AMOUNT_FIELD}    ${BILL_AMOUNT}
    Sleep    5
    Wait For Elements State     ${NGOS_BILLPAY_BUTTON1}      enabled
    Take Screenshot
    Click                       ${NGOS_BILLPAY_BUTTON1}
    Sleep    15

VIA ONLINE_BANKING
    [Arguments]                 ${BANK_NAME}
    Wait For Load State
    Select BANK                 ${BANK_NAME}
    Sleep    5
    Take Screenshot
    Click                       ${PAYMENT_PROCEED_BUTTON}
    Wait Visible & Hidden       ${PAYMENT_LOADER_PATH}
    Wait For Elements State     ${OB_USERNAME_PATH}     visible
    Fill Text                   ${OB_USERNAME_PATH}     ${OB_USERNAME}
    Fill Text                   ${OB_PASSWORD_PATH}     ${OB_PASSWORD}
    Sleep    5
    Take Screenshot
    Click Until Visible         ${OB_SUBMIT_BUTTON}     ${OB_SELECT_SAVING_ACCOUNT_PATH}
    Click Until Visible         ${OB_CONFIRM_BUTTON}    ${OB_SUCCESS_PAYMENT_DEDUCT_PATH}
    Sleep    5
    Click                       ${OB_CONTINUE_TRANSACTION_PATH}

NGOS Success Page
    Wait For Elements State     ${NGOS_SUCCESS_PAGE_PATH}    visible            timeout=50s
    Wait For Elements State     ${NGOS_RECEIPT_BUTTON}       visible            timeout=50s
    Click                       ${NGOS_RECEIPT_BUTTON}
    Sleep    10s
    Take Screenshot