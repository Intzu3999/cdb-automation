*** Settings ***
Documentation    Store sharing keywords

#Import
Resource    ../NGOS-testSettings.robot

*** Keywords ***
Validate NGPAY Page
    Check For Element Visibility   ${NGPAY_PAGE_BACK_BUTTON}
    Check For Element Visibility   ${NGPAY_TIMER}
    Check For Element Visibility   ${NGPAY_PAGE_TITLE}
    Check For Element Visibility   ${NGPAY_PAGE_SUBTITLE}
    Check For Element Visibility   ${NGPAY_PAGE_AMOUNT} 
    Check For Element Visibility   ${NGPAY_PAY_TO} 
    Check For Element Visibility   ${NGPAY_PAYMENT_OF} 
    Check For Element Visibility   ${NGPAY_REFERNCE_NUMBER}  
    Sleep    2s
    Take Screenshot    

Perform Payment Method Selection
    Scroll To            ${NGPAY_PAYNOW_BUTTON}
    Check For Element Visibility   ${NGPAY_PAYMENT_METHOD_TEXT}    
    Check For Element Visibility   ${NGPAY_PAYMENT_EWALLET} 
    Check For Element Visibility   ${NGPAY_PAYMENT_CREDIT_CARD} 
    Check For Element Visibility   ${NGPAY_PAYMENT_ONLINE_BANKING} 
    Sleep    2s  
    Take Screenshot 

    Sleep    2s   
    Click    ${NGPAY_PAYMENT_EWALLET}  
    Sleep    2s 
    Click    ${NGPAY_PAYMENT_CREDIT_CARD}     
    Sleep    2s
    Click    ${NGPAY_PAYMENT_ONLINE_BANKING}      
    Sleep    2s
    Click    ${NGPAY_PAYMENT_BNPL}      
    Sleep    2s
    Click    ${NGPAY_PAYMENT_ONLINE_BANKING}      
    Sleep    2s
    Take Screenshot

Online Banking Selection
    Click    ${NGPAY_FPX_DROPDOWN}
    Check For Element Visibility    ${NGPAY_MAYBANK2U}       
    Check For Element Visibility    ${NGPAY_AFFINBANK}        
    Click    ${NGPAY_MAYBANK2U}
    Sleep    2s
    Check For Element Visibility    ${NGPAY_PAYNOW_BUTTON}    
    Click    ${NGPAY_PAYNOW_BUTTON}
    Sleep    2s
    Take Screenshot

#Mock Payment Page
    #Check For Element Visibility   ${NGPAY_ONLINEBANKING_TEXT1}  
    #Check For Element Visibility   ${NGPAY_ONLINEBANKING_SUBTEXT1}  
    #Check For Element Visibility   ${NGPAY_ONLINEBANKING_AMOUNT}  
    #Check For Element Visibility   ${NGPAY_ONLINEBANKING_PYMTMETHOD}  
    #Check For Element Visibility   ${NGPAY_ONLINEBANKING_METHOD}  
    #Check For Element Visibility   ${NGPAY_ONLINEBANKING_SUCCESS}  
    #Check For Element Visibility   ${NGPAY_ONLINEBANKING_FAILED}  
    #Sleep    2s
    #Take Screenshot

    #Click   ${NGPAY_ONLINEBANKING_SUCCESS} 
    #Sleep   3s

#Mark Payment As Success
    # prepare a handler for the NEXT dialog shown by the page
    #Handle Future Dialogs    action=accept
    #Click    text=Success          # this click triggers the confirm pop-up
    #${msg}=    Get Dialog Message  # message from the handled dialog
    #Should Be Equal    ${msg}    Are you sure to mark this payment as Success?
    
    #Handle Future Dialogs    action=accept
    #Click    \#alerts
    #Take Screenshot

FPX Simulator Page 1
    Check For Element Visibility   ${FPX_BANK_SIMULATOR}    
    Check For Element Visibility   ${FPX_LOGIN_USERNAME}    
    Check For Element Visibility   ${FPX_LOGIN_PASSWORD}    
    Check For Element Visibility   ${FPX_SIGNIN_BUTTON}     
    Fill Text    ${FPX_LOGIN_USERNAME}    ${FPX_USERNAME}
    Fill Text    ${FPX_LOGIN_PASSWORD}    ${FPX_PASSWORD}
    Click        ${FPX_SIGNIN_BUTTON}
    Sleep    5s
    Take Screenshot

FPX Simulator Page 2    
    Check For Element Visibility      ${ACCOUNT_SELECTION}     
    Check For Element Visibility      ${FPX_CONFIRM_BUTTON}    
    Check For Element Visibility      ${FPX_CANCEL2_BUTTON}    
    Check For Element Visibility      ${ACCOUNT_SELECTION}    
    Check For Element Visibility      ${FPX_TRXN_INFO}   
    Take Screenshot    
    Click                             ${FPX_CONFIRM_BUTTON}
    Sleep    20s
    Take Screenshot  


#Handle Future Dialog
    #[Arguments]    ${action}
    # TODO: implement keyword "Handle Future Dialog".
    #Fail    Not Implemented


#Get Dialog Message
    # TODO: implement keyword "Get Dialog Message".
    #Fail    Not Implemented

