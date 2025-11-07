*** Settings ***
Documentation    Store reload keywords

# Import
Resource    ../NGOS-testSettings.robot

*** Keywords ***

Access NGOS Reload Page
    New Page    ${NGOS_STAGING_BASE_URL}${NGOS_RELOAD_PATH}    wait_until=domcontentloaded
    Resize Screen Size     
    Sleep    5s
    Take Screenshot

Verify NGOS Reload Page 1
    Check For Element Visibility        ${NGOS_CD_LOGO} 
    Check For Element Visibility        ${NGOS_SHOP_TEXT} 
    Check For Element Visibility        ${NGOS_LANGUAGE_BUTTON}    
    Check For Element Visibility        ${NGOS_RELOAD_MAIN_TEXT} 
    Check For Element Visibility        ${NGOS_SUBTEXT1} 
    Check For Element Visibility        ${NGOS_SUBTEXT2}                         
    Check For Element Visibility        ${NGOS_MOBILE_FIELD} 
    Check For Element Visibility        ${NGOS_SUBMIT_BUTTON} 
    Check For Element Visibility        ${NGOS_COPYRIGHT}
    Sleep    5s
    Take Screenshot


Verify Insert Invalid MSISDN
    Fill Text                 ${NGOS_MOBILE_FIELD}    ${INVALID_MSISDN}    
    Click                     ${NGOS_SUBMIT_BUTTON}
    Wait Visible & Hidden     ${CD_LOADING}
    Check For Element Visibility        ${NGOS_RELOAD_ERROR_MESSAGE}
    Sleep    2s
    Take Screenshot

Verify Insert Valid MSISDN
    Fill Text                 ${NGOS_MOBILE_FIELD}    ${PREPAID_MSISDN}
    Click                     ${NGOS_SUBMIT_BUTTON}
    Wait Visible & Hidden     ${CD_LOADING}
    Sleep    2s
    Take Screenshot

Verify NGOS Reload Page 2
    Check For Element Visibility        ${NGOS_CD_LOGO}  
    Check For Element Visibility        ${NGOS_SHOP_TEXT}
    Check For Element Visibility        ${NGOS_LANGUAGE_BUTTON}    
    Check For Element Visibility        ${NGOS_BANNER_FULL} 
    Check For Element Visibility        ${NGOS_BANNER_TYPE} 
    Check For Element Visibility        ${NGOS_BANNER_NUMBER} 
    Check For Element Visibility        ${NGOS_BANNER_TELCO}
    Check For Element Visibility        ${NGOS_RELOAD_TEXT} 
    Check For Element Visibility        ${NGOS_RELOAD_RM5} 
    Check For Element Visibility        ${NGOS_RELOAD_RM10} 
    Check For Element Visibility        ${NGOS_RELOAD_RM30} 
    Check For Element Visibility        ${NGOS_RELOAD_RM50} 
    Check For Element Visibility        ${NGOS_RELOAD_RM100}
    Check For Element Visibility        ${NGOS_RELOAD_INFO} 
    Check For Element Visibility        ${NGOS_TNC} 
    Check For Element Visibility        ${NGOS_PRICE_SUMMARY} 
    Check For Element Visibility        ${NGOS_RELOAD_PRICE} 
    Check For Element Visibility        ${NGOS_RELOAD_BUTTON}
    Check For Element Visibility        ${NGOS_COPYRIGHT}
    Sleep    2s
    Take Screenshot

    Click    ${NGOS_RELOAD_RM10}
    Sleep    1s

    Click    ${NGOS_RELOAD_RM30}
    Sleep    1s

    Click    ${NGOS_RELOAD_RM50}
    Sleep    1s

    Click    ${NGOS_RELOAD_RM100}
    Sleep    1s

    Click    ${NGOS_RELOAD_RM10}
    Sleep    1s
    
    Click    ${NGOS_RELOAD_BUTTON} 
    Check For Element Visibility  ${NGOS_RELOAD_PRICE} 
    Sleep   2s   
    Take Screenshot


Verify NGOS Success Page
    Check For Element Visibility     ${PYMTSUCCESS_TEXT1}     
    #Check Element Exactly Match     ${PYMTSUCCESS_TEXT2}    Your Reference ID is
    ${referenceId}    Get Text    ${PYMTSUCCESS_TEXT2}
    Should Contain    ${referenceId}                         Your Reference ID is
    # Get Element States       ${PYMTSUCCESS_TEXT2}   contains   visible   Your Reference ID is
    Check For Element Visibility    ${PYMTSUCCESS_DOWNLOADINFO}     
    Check For Element Visibility    ${PYMTSUCCESS_DOWNLOADBUTTON}    
    Check For Element Visibility    ${PYMTSUCCESS_PYMTINFO}    
    Check For Element Visibility    ${MAINPAGE_BUTTON}  
    Click                           ${PYMTSUCCESS_DOWNLOADBUTTON} 
    Scroll To                       ${MAINPAGE_BUTTON} 
    Sleep    2s
    Take Screenshot   
    
Verify NGOS Failed Page
    Check For Element Visibility     ${PYMTFAILED_IMG}     
    Check For Element Visibility     ${PYMTFAILED_TEXT1}     
    Check For Element Visibility     ${PYMTFAILED_TEXT2}     
    Check For Element Visibility     ${PYMTFAILED_RETRYBUTTON}     
    Sleep    2s
    Take Screenshot   
    Click                           ${PYMTFAILED_RETRYBUTTON} 
    Sleep    2s
    Take Screenshot


Click on Back Button and Click NO Transaction at NGPAY Page
    Click    ${NGPAY_PAGE_BACK_BUTTON}
    Check For Element Visibility   ${NGPAY_PAGE_POPUP_INFO}    
    Take Screenshot

    Check For Element Visibility    ${NGPAY_PAGE_POPUP_INFO}    
    Check For Element Visibility    ${NGPAY_PAGE_POPUP_TEXT}    
    Check For Element Visibility    ${NGPAY_PAGE_POPUP_YES_BUTTON}    
    Check For Element Visibility    ${NGPAY_PAGE_POPUP_NO_BUTTON} 
    Sleep    2s  
    Take Screenshot

    Click    ${NGPAY_PAGE_POPUP_NO_BUTTON}
    Sleep    2s
    Take Screenshot

Click on Back Button and Click YES Transaction at NGPAY Page
    Click    ${NGPAY_PAGE_BACK_BUTTON}
    Check For Element Visibility   ${NGPAY_PAGE_POPUP_INFO}    
    Take Screenshot

    Check For Element Visibility    ${NGPAY_PAGE_POPUP_INFO}    
    Check For Element Visibility    ${NGPAY_PAGE_POPUP_TEXT}    
    Check For Element Visibility    ${NGPAY_PAGE_POPUP_YES_BUTTON}    
    Check For Element Visibility    ${NGPAY_PAGE_POPUP_NO_BUTTON} 
    Sleep    2s  
    Take Screenshot

    Click    ${NGPAY_PAGE_POPUP_YES_BUTTON}
    Sleep    2s
    Take Screenshot

 


