** Settings ***
Documentation    This file contains Others keywords for NGCA tests.

#Import
Resource          ../TestVariables/NGCA-AllVariable.Robot

*** Keywords ***
#OTP operation  
Click Get started Button
    [Documentation]    Click Next Button
    Log    Trying to tap: ${Get_Started}
    Wait Until Element Is Visible    ${Get_Started}    ${TIMEOUT} 
    Click Element    ${Get_Started}

#Profile page 1 operation
Insert Name Into Input Box
    [Arguments]    ${Input_Name}
    Click Element   ${Profile_Name}
    Input Text      ${Profile_Name}    ${Input_Name}
    Hide Keyboard

Next profile page 1
    [Documentation]    Click Next Button
    Log    Trying to tap: ${Profile_Next_1} 
    Wait Until Element Is Visible    ${Profile_Next_1}     ${TIMEOUT} 
    Click Element    ${Profile_Next_1} 

#Profile page 2 operation
Click Avatar By Index
    [Arguments]    ${index}
    ${element_id}=    Set Variable    ${AVATAR_BASE}${index}${AVATAR_SUFFIX}
    Log    Trying to click element: ${element_id}
    Wait Until Element Is Visible    ${element_id}    ${TIMEOUT} 
    Click Element    id=${element_id}

 Next profile page 2
    [Documentation]    Click Next Button
    Log    Trying to tap: ${Profile_Next_2} 
    Wait Until Element Is Visible    ${Profile_Next_2}     ${TIMEOUT} 
    Click Element    ${Profile_Next_2} 

#welcome page operation
Go To Next Onboarding Page
    [Arguments]    ${current_text}    ${next_text}    ${next_button}
    [Documentation]    Wait for current page text, click Next, then wait for next page text

    Log    Waiting for current onboarding page text: ${current_text}
    Wait Until Page Contains    ${current_text}    ${TIMEOUT}
    Capture Screenshot

    Log    Current page is loaded, waiting for Next button...
    Wait Until Element Is Visible    ${next_button}    ${TIMEOUT}
    Sleep    3s    # buffer for animations
    Click Element    ${next_button}

    Log    Waiting for next onboarding page text: ${next_text}
    Wait Until Page Contains    ${next_text}    ${TIMEOUT}

Click Third Page Unlock Button
    [Documentation]    Wait for onboarding page 3 after splash screen, then click Next
    Log    Waiting for third onboarding page text...
    Wait Until Page Contains    Step into the new experience today, created with you in mind.    ${TIMEOUT}

    Log    Third onboarding page is loaded, now clicking Unlock
    Wait Until Element Is Visible    ${Unlock}     ${TIMEOUT}
    Sleep    3s    # buffer for animations
    Click Element    ${Unlock} 

    Log    Waiting for Welcome page text...
    Wait Until Page Contains    Unlock the new      ${TIMEOUT}

Click Terms&Condition Button
    [Documentation]    Click Unlock Button
    Log    Trying to tap: ${T&C}
    Wait Until Element Is Visible    ${T&C}    ${TIMEOUT} 
    Click Element    ${T&C}

Click Privacy Policy Text
    [Documentation]    Click Unlock Button
    Log    Trying to tap: ${T&C}
    Wait Until Element Is Visible    ${T&C}    ${TIMEOUT} 
    Click Element    ${T&C}

# Insert MSISDN Into Input Box
#     [Arguments]    ${number}
#     Click Element    ${MSISDN_Box}
#     Input Text      ${MSISDN_Box}    ${number}
#     Hide Keyboard

Insert MSISDN Into Input Box
    [Arguments]    ${number}
    Wait Until Element Is Visible    ${MSISDN_Box}    ${TIMEOUT} 
    Log    Clicking MSISDN input box
    Click Element    ${MSISDN_Box}

    Log    Typing MSISDN: ${number}
    Input Text    ${MSISDN_Box}    ${number}

    Sleep    1s    # Allow time for the keyboard to stabilize
    Log    Hiding keyboard
    Run Keyword And Ignore Error    Hide Keyboard


Click Request OTP Button
    [Documentation]    Click Next Button
    Log    Trying to tap: ${OTP}
    Wait Until Element Is Visible    ${OTP}    ${TIMEOUT} 
    Click Element    ${OTP}

Click SSO Button
    [Documentation]    Click sso Button
    Log    Trying to tap: ${SSO}
    Wait Until Element Is Visible    ${SSO}    ${TIMEOUT} 
    Click Element    ${SSO}

#SSO and continue with email

#Continue with Email
Click Continue with email
    [Documentation]    Click Next Button
    Log    Trying to tap: ${CWE}
    Wait Until Element Is Visible    ${CWE}    ${TIMEOUT} 
    Click Element    ${CWE}  

Insert Email ID Into Input Box
    [Arguments]    ${CWE_ID}
    Wait Until Element Is Visible    ${CWE_Email}    ${TIMEOUT} 
    Click Element    ${CWE_Email} 
    Input Text       ${CWE_Email}    ${CWE_ID}  
    Press Keycode    66 
    Hide Keyboard 

Insert password ID Into Input Box
    [Arguments]    ${CWE_Lock}
    Wait Until Element Is Visible    ${CWE_Password}     ${TIMEOUT}
    Click Element    ${CWE_Password} 
    Input Text       ${CWE_Password}    ${CWE_Lock}
    Press Keycode    66 
    Hide Keyboard 

Click Submit Login With Email
    [Documentation]    Click Next Button
    Log    Trying to tap: ${CWE_Submit} 
    Wait Until Element Is Visible    ${CWE_Submit}     ${TIMEOUT} 
    Click Element    ${CWE_Submit}  


# Continue with Gmail
Click Gmail Icon
    [Documentation]    Click Next Button
    Log    Trying to tap: ${Gmail_Icon} 
    Wait Until Element Is Visible    ${Gmail_Icon}     ${TIMEOUT} 
    Click Element    ${Gmail_Icon}      
    
Switch To Gmail WebView
    Sleep    3s
    ${contexts}=    Get Contexts
    Log    Available Contexts: ${contexts}
    ${webview_context}=    Get First WebView Context    ${contexts}
    Switch To Context    ${webview_context}

Get First WebView Context
    [Arguments]    ${contexts}
    FOR    ${item}    IN    @{contexts}
        Run Keyword If    "${item}".startswith("WEBVIEW_")    Return From Keyword    ${item}
    END
    Fail    No WebView context found in: ${contexts} 

Switch To Gmail Native
    Switch To Context    ${Gmail_NATIVE_CONTEXT}

Select Gmail Account With Scroll
    [Arguments]    ${email}    ${max_scrolls}=10
    ${size}=      Get Window Size Fallback
    ${width}=     Set Variable    ${size["width"]}
    ${height}=    Set Variable    ${size["height"]}

    ${start_x}=   Evaluate    ${width} / 2
    ${start_y}=   Evaluate    ${height} * 0.8
    ${end_y}=     Evaluate    ${height} * 0.2

    ${xpath}=     Set Variable    //div[@data-email='${email}']

    FOR    ${index}    IN RANGE    ${max_scrolls}
        ${is_visible}=    Run Keyword And Return Status    Element Should Be Visible    xpath=${xpath}
        Run Keyword If    ${is_visible}    Exit For Loop
        Log    Scrolling down... Attempt ${index + 1}
        Swipe    ${start_x}    ${start_y}    ${start_x}    ${end_y}    1000
        Sleep    1s
    END

    Wait Until Element Is Visible    xpath=${xpath}    ${TIMEOUT}
    Click Element    xpath=${xpath}   
    
            
#Dashboard page 
Click Reload Button On Dashboard
    [Documentation]    Click Reload Button
    Log    Trying to tap: ${Reload_Button} 
    Wait Until Element Is Visible    ${Reload_Button}     ${TIMEOUT} 
    Click Element    ${Reload_Button} 

Click Service Tab Button On Dashboard
    [Documentation]    Click Reload Button
    Log    Trying to tap: ${Service_Tab} 
    Wait Until Element Is Visible    ${Service_Tab}     ${TIMEOUT} 
    Click Element    ${Service_Tab}    

Click PayBill Button On Dashboard
    [Documentation]    Click Reload Button
    Log    Trying to tap: ${Paybill_Button} 
    Wait Until Element Is Visible    ${Paybill_Button}     ${TIMEOUT} 
    Click Element    ${Paybill_Button}     

Click Setting Icon On Dashboard
    [Documentation]    Click Reload Button
    Log    Trying to tap: ${Setting_Icon}  
    Wait Until Element Is Visible    ${Setting_Icon}      ${TIMEOUT} 
    Click Element    ${Setting_Icon} 

Scroll To And Click Addon
    [Arguments]    ${max_scrolls}=10

    ${size}=      Get Window Size Fallback
    ${width}=     Set Variable    ${size["width"]}
    ${height}=    Set Variable    ${size["height"]}

    ${start_x}=   Evaluate    ${width} / 2
    ${start_y}=   Evaluate    ${height} * 0.70    # start above nav bar
    ${end_y}=     Evaluate    ${height} * 0.35    # stop near banner area

    FOR    ${index}    IN RANGE    ${max_scrolls}
        ${is_visible}=    Run Keyword And Return Status    Element Should Be Visible    ${Dashboard_Addon}
        Run Keyword If    ${is_visible}    Exit For Loop
        Log    Scrolling down... Attempt ${index + 1}
        Swipe    ${start_x}    ${start_y}    ${start_x}    ${end_y}    1000
        Sleep    1s
    END

    Element Should Be Visible    ${Dashboard_Addon}
    Click Element    ${Dashboard_Addon}


Click Home tab On Dashboard
    [Documentation]    Home tab
    Log    Trying to tap: ${Home_Tab}   
    Wait Until Element Is Visible    ${Home_Tab}       ${TIMEOUT} 
    Click Element    ${Home_Tab}  

Click Usage Icon on dashboard
    [Documentation]    Dashboard usage icon
    Log    Trying to tap: ${Usage_Icon}    
    Wait Until Element Is Visible    ${Usage_Icon}       ${TIMEOUT} 
    Click Element    ${Usage_Icon}  

#Usage page
Scroll to verify the add on is available
    [Arguments]    ${addon_text}

    ${size}=      Get Window Size Fallback
    ${width}=     Set Variable    ${size["width"]}
    ${height}=    Set Variable    ${size["height"]}

    ${start_x}=   Evaluate    ${width} / 2
    ${start_y}=   Evaluate    ${height} * 0.8
    ${end_y}=     Evaluate    ${height} * 0.2

    FOR    ${i}    IN RANGE    10
        ${is_visible}=    Run Keyword And Return Status    Page Should Contain Text    ${addon_text}
        Run Keyword If    ${is_visible}    Exit For Loop
        Swipe    ${start_x}    ${start_y}    ${start_x}    ${end_y}    800
    END

    Page Should Contain Text    ${addon_text}

#Setting page 
Tap Cogwheel
    [Documentation]    Tap on the cogwheel inside the profile image
    Tap With Positions    ${COGWHEEL_X}    ${COGWHEEL_Y}    1000
 
Scroll and tap LogOut
    [Arguments]    ${max_scrolls}=10

    ${size}=      Get Window Size Fallback
    ${width}=     Set Variable    ${size["width"]}
    ${height}=    Set Variable    ${size["height"]}

    ${start_x}=   Evaluate    ${width} / 2
    ${start_y}=   Evaluate    ${height} * 0.8
    ${end_y}=     Evaluate    ${height} * 0.2

    FOR    ${index}    IN RANGE    ${max_scrolls}
        ${is_visible}=    Run Keyword And Return Status    Element Should Be Visible    ${Log_Out}
        Run Keyword If    ${is_visible}    Exit For Loop
        Log    Scrolling down... Attempt ${index + 1}
        Swipe    ${start_x}    ${start_y}    ${start_x}    ${end_y}    1000
        Sleep    1s
    END

    Element Should Be Visible    ${Log_Out}
    Click Element    ${Log_Out}    
    

#Profile page
Swipe Edit profile page
    ${size}=    Get Window Size Fallback
    ${width}=   Set Variable    ${size["width"]}
    ${height}=  Set Variable    ${size["height"]}

    ${start_x}=    Evaluate    ${width} / 2
    ${start_y}=    Evaluate    ${height} * 0.8
    ${end_y}=      Evaluate    ${height} * 0.2

    Swipe    ${start_x}    ${start_y}    ${start_x}    ${end_y}    1000
    Sleep    5s   

Click profile page back button 
    [Documentation]    Click Reload Button
    Log    Trying to tap: ${ProfilePage_Back}  
    Wait Until Element Is Visible    ${ProfilePage_Back}      ${TIMEOUT} 
    Click Element    ${ProfilePage_Back}                   

#Reload page
Click Reload Amount With Scroll
    [Arguments]    ${email}    ${max_scrolls}=10
    ${size}=      Get Window Size Fallback
    ${width}=     Set Variable    ${size["width"]}
    ${height}=    Set Variable    ${size["height"]}

    ${start_x}=   Evaluate    ${width} / 2
    ${start_y}=   Evaluate    ${height} * 0.8
    ${end_y}=     Evaluate    ${height} * 0.2

    ${xpath}=     Set Variable    //div[@data-email='${email}']

    # ✅ Verify "Choose an account" heading is visible before starting scroll
    Wait Until Element Is Visible    xpath=//h1[contains(text(),"Choose an account")]    ${TIMEOUT}

    FOR    ${index}    IN RANGE    ${max_scrolls}
        ${is_visible}=    Run Keyword And Return Status    Element Should Be Visible    xpath=${xpath}
        Run Keyword If    ${is_visible}    Exit For Loop
        Log    Scrolling down... Attempt ${index + 1}
        Swipe    ${start_x}    ${start_y}    ${start_x}    ${end_y}    1000
        Sleep    1s
    END

    Wait Until Element Is Visible    xpath=${xpath}    ${TIMEOUT}
    Click Element    xpath=${xpath}


Click Reload Next button
    [Documentation]    Click next Button
    Log    Trying to tap: ${Reload_Next_Button}  
    Wait Until Element Is Visible    ${Reload_Next_Button}      ${TIMEOUT} 
    Click Element    ${Reload_Next_Button}  

Click Payment Method
    [Arguments]    ${payment_name}
    ${desc}=    Set Variable    cardSelect_${payment_name}_text
    Wait Until Element Is Visible    accessibility_id=${desc}    ${TIMEOUT}
    Click Element    accessibility_id=${desc} 

Turn Switch On If Off
    Wait Until Element Is Visible    class=android.widget.Switch    ${TIMEOUT}
    ${status}=    Get Element Attribute    class=android.widget.Switch    checked
    Run Keyword If    '${status}' == 'false'    Click Element    class=android.widget.Switch
    
# Switch state is typically stored in checked : ‘true' = ON,  'false' = OFF

# Online banking FPX page
Click on select bank
    [Documentation]    Scrolls until the ‘Select bank’ button is visible and clicks it

    ${size}=    Get Window Size Fallback
    ${width}=   Set Variable    ${size["width"]}
    ${height}=  Set Variable    ${size["height"]}

    ${start_x}=    Evaluate    ${width} / 2
    ${start_y}=    Evaluate    ${height} * 0.8
    ${end_y}=      Evaluate    ${height} * 0.2

    ${element_found}=    Run Keyword And Return Status    Element Should Be Visible    accessibility_id=Select bank

    WHILE    '${element_found}' == 'False'
        Log    Attempting Swipe...

        Swipe    ${start_x}    ${start_y}    ${start_x}    ${end_y}    1000
        Sleep    1s

        ${element_found}=    Run Keyword And Return Status    Element Should Be Visible    accessibility_id=Select bank
        Log    Element Found Status After Swipe: ${element_found}
    END

    Log    Element Found, ensuring it's ready to be clicked...

    Wait Until Element Is Visible    accessibility_id=Select bank    ${TIMEOUT} 
    Click Element    accessibility_id=Select bank

Click Payment Option
    [Arguments]    ${payment_name}
    ${accessibility_id}=    Set Variable    ${payment_name}
    Wait Until Element Is Visible    accessibility_id=${accessibility_id}    ${TIMEOUT}
    Click Element    accessibility_id=${accessibility_id}

Click OB Summary Next button
    [Documentation]    Click next Button
    Log    Trying to tap: ${Next_Button_OB}  
    Wait Until Element Is Visible    ${Next_Button_OB}      ${TIMEOUT} 
    Click Element    ${Next_Button_OB} 

Insert User ID Into FPX ID Box
    [Arguments]     ${Input_User_ID}
    Wait Until Element Is Visible    ${FPX_User_ID}    ${TIMEOUT}
    Click Element                    ${FPX_User_ID}
    Input Text                       ${FPX_User_ID}    ${Input_User_ID}
    Execute Script    mobile: hideKeyboard

Insert Password Into FPX Password Box
    [Arguments]     ${Input_User_Password}
    Wait Until Element Is Visible    ${FPX_User_Password}    ${TIMEOUT}
    Click Element                    ${FPX_User_Password}
    Input Text                       ${FPX_User_Password}    ${Input_User_Password}
    Execute Script    mobile: hideKeyboard  

Click SignIn Button at FPX page
    [Documentation]    Click next Button
    Log    Trying to tap: ${Input_User_Signin}   
    Wait Until Element Is Visible    ${Input_User_Signin}      ${TIMEOUT} 
    Click Element    ${Input_User_Signin}      

Click Confirm Button at FPX page
    [Documentation]    Click next Button
    Log    Trying to tap: ${User_FPX_Confirm}   
    Wait Until Element Is Visible    ${User_FPX_Confirm}      ${TIMEOUT} 
    Click Element    ${User_FPX_Confirm}       

Click Complete Button at FPX page
    [Documentation]    Click next Button
    Log    Trying to tap: ${User_FPX_Complete}   
    Wait Until Element Is Visible    ${User_FPX_Complete}      ${TIMEOUT} 
    Click Element    ${User_FPX_Complete}       

Click Print Button at FPX page
    [Documentation]    Click next Button
    Log    Trying to tap: ${User_FPX_Print}    
    Wait Until Element Is Visible    ${User_FPX_Print}       ${TIMEOUT} 
    Click Element    ${User_FPX_Print} 

# Reload for myself page    
Click Back to Home at Success reload page
    [Documentation]    Click next Button
    Log    Trying to tap: ${Reload_BTH}    
    Wait Until Element Is Visible    ${Reload_BTH}       ${TIMEOUT} 
    Click Element    ${Reload_BTH} 

Click Receipt at Success reload page
    [Documentation]    Click next Button
    Log    Trying to tap: ${Reload_Receipt}    
    Wait Until Element Is Visible    ${Reload_Receipt}       ${TIMEOUT} 
    Click Element    ${Reload_Receipt}     

Click Back to Home at Receipt page
    [Documentation]    Click next Button
    Log    Trying to tap: ${ViewReceipt_BTH}    
    Wait Until Element Is Visible    ${ViewReceipt_BTH}       ${TIMEOUT} 
    Click Element    ${ViewReceipt_BTH}

#All Service Page  
Scroll Until Reload History Is Visible and Click On It
    [Arguments]    ${max_scrolls}=10

    ${size}=      Get Window Size Fallback
    ${width}=     Set Variable    ${size["width"]}
    ${height}=    Set Variable    ${size["height"]}

    ${start_x}=   Evaluate    ${width} / 2
    ${start_y}=   Evaluate    ${height} * 0.8
    ${end_y}=     Evaluate    ${height} * 0.2

    FOR    ${index}    IN RANGE    ${max_scrolls}
        ${is_visible}=    Run Keyword And Return Status    Element Should Be Visible    ${Reload_History}
        Run Keyword If    ${is_visible}    Exit For Loop
        Log    Scrolling down... Attempt ${index + 1}
        Swipe    ${start_x}    ${start_y}    ${start_x}    ${end_y}    1000
        Sleep    1s
    END

    Log    Verifying Reload History is visible...
    Wait Until Element Is Visible    ${Reload_History}    ${TIMEOUT}
    Click Element    ${Reload_History}


Scroll Until Reload for others Is Visible and click on it
    [Arguments]    ${max_scrolls}=10

    ${size}=      Get Window Size Fallback
    ${width}=     Set Variable    ${size["width"]}
    ${height}=    Set Variable    ${size["height"]}

    ${start_x}=   Evaluate    ${width} / 2
    ${start_y}=   Evaluate    ${height} * 0.8
    ${end_y}=     Evaluate    ${height} * 0.2

    FOR    ${index}    IN RANGE    ${max_scrolls}
        ${is_visible}=    Run Keyword And Return Status    Element Should Be Visible    ${Reload_Others}
        Run Keyword If    ${is_visible}    Exit For Loop
        Log    Scrolling down... Attempt ${index + 1}
        Swipe    ${start_x}    ${start_y}    ${start_x}    ${end_y}    1000
        Sleep    1s
    END

    Element Should Be Visible    ${Reload_Others}
    Click Element    ${Reload_Others}


Click Bill payment history
    [Documentation]    Click next Button
    Log    Trying to tap: ${Bill_History}     
    Wait Until Element Is Visible    ${Bill_History}        ${TIMEOUT} 
    Click Element    ${Bill_History}     


Click PayBill For Others
    [Documentation]    Click next Button
    Log    Trying to tap: ${Paybill_Others}     
    Wait Until Element Is Visible    ${Paybill_Others}        ${TIMEOUT} 
    Click Element    ${Paybill_Others}   


Scroll Until Transaction history Is Visible and click on it
    [Arguments]    ${max_scrolls}=10

    ${size}=      Get Window Size Fallback
    ${width}=     Set Variable    ${size["width"]}
    ${height}=    Set Variable    ${size["height"]}

    ${start_x}=   Evaluate    ${width} / 2
    ${start_y}=   Evaluate    ${height} * 0.8
    ${end_y}=     Evaluate    ${height} * 0.2

    FOR    ${index}    IN RANGE    ${max_scrolls}
        ${is_visible}=    Run Keyword And Return Status    Element Should Be Visible    ${Trans_History}
        Run Keyword If    ${is_visible}    Exit For Loop
        Log    Scrolling down... Attempt ${index + 1}
        Swipe    ${start_x}    ${start_y}    ${start_x}    ${end_y}    1000
        Sleep    1s
    END

    Element Should Be Visible    ${Trans_History}
    Click Element    ${Trans_History}


Scroll Until MyPlan Is Visible And Click
    [Arguments]    ${max_scrolls}=10

    ${size}=      Get Window Size Fallback
    ${width}=     Set Variable    ${size["width"]}
    ${height}=    Set Variable    ${size["height"]}

    ${start_x}=   Evaluate    ${width} / 2
    ${start_y}=   Evaluate    ${height} * 0.8
    ${end_y}=     Evaluate    ${height} * 0.2

    # Try scrolling down
    FOR    ${index}    IN RANGE    ${max_scrolls}
        ${is_visible}=    Run Keyword And Return Status    Element Should Be Visible    ${MyPlan}
        Exit For Loop If    ${is_visible}
        Log    Scrolling down... Attempt ${index + 1}
        Swipe    ${start_x}    ${start_y}    ${start_x}    ${end_y}    1000
        Sleep    1s
    END

    # If not found after scrolling down, try scrolling up
    ${is_visible}=    Run Keyword And Return Status    Element Should Be Visible    ${MyPlan}
    Run Keyword If    not ${is_visible}    Log    Not found scrolling down, trying scroll up

    FOR    ${index}    IN RANGE    ${max_scrolls}
        ${is_visible}=    Run Keyword And Return Status    Element Should Be Visible    ${MyPlan}
        Exit For Loop If    ${is_visible}
        Log    Scrolling up... Attempt ${index + 1}
        Swipe    ${start_x}    ${end_y}    ${start_x}    ${start_y}    1000
        Sleep    1s
    END

    Element Should Be Visible    ${MyPlan}
    Click Element    ${MyPlan}


#Reload History page
Click First Reload History Entry
    Wait Until Element Is Visible    ${RELOAD_ENTRY_XPATH}    ${TIMEOUT}
    Click Element                    ${RELOAD_ENTRY_CONTAINER_XPATH}
        
# Reload for others page   
Insert Others MSISDN Into Number Box
    [Arguments]     ${Others_MSISDN} 
    Click Element   ${Reload_Input}
    Input Text      ${Reload_Input}    ${Others_MSISDN} 
    Execute Script    mobile: hideKeyboard 

Click Next Button Reload Others
    [Documentation]    Click next Button
    Log    Trying to tap: ${ReloadOthers_Next}    
    Wait Until Element Is Visible    ${ReloadOthers_Next}       ${TIMEOUT} 
    Click Element    ${ReloadOthers_Next}  


#Transaction history page
Search for transaction history
    [Arguments]    ${text}    ${max_scrolls}=10

    ${size}=      Get Window Size Fallback
    ${width}=     Set Variable    ${size["width"]}
    ${height}=    Set Variable    ${size["height"]}

    ${start_x}=   Evaluate    ${width} / 2
    ${start_y}=   Evaluate    ${height} * 0.8
    ${end_y}=     Evaluate    ${height} * 0.2

    ${locator}=   Set Variable    xpath=//android.widget.TextView[@text='${text}']

    FOR    ${index}    IN RANGE    ${max_scrolls}
        ${is_visible}=    Run Keyword And Return Status    Element Should Be Visible    ${locator}
        Run Keyword If    ${is_visible}    Exit For Loop
        Log    Scrolling down... Attempt ${index + 1}
        Swipe    ${start_x}    ${start_y}    ${start_x}    ${end_y}    1000
        Sleep    1s
    END

    Element Should Be Visible    ${locator}
    Click Element    ${locator}

#MyPlan Page
Click on internet subcription button at my plan page
    [Documentation]    Click next Button
    Log    Trying to tap: ${MyPlan_IS}    
    Wait Until Element Is Visible    ${MyPlan_IS}       ${TIMEOUT} 
    Click Element    ${MyPlan_IS}      
 
# Credit card page   
Click Next Button at card summary transaction
    [Documentation]    Click Unlock Button
    Log    Trying to tap: ${Card_Next_1}
    Wait Until Element Is Visible    ${Card_Next_1}    ${TIMEOUT} 
    Click Element    ${Card_Next_1}

Click Plus button
    [Documentation]    Click Unlock Button
    Log    Trying to tap: ${Plus_Button}
    Wait Until Element Is Visible    ${Plus_Button}    ${TIMEOUT} 
    Click Element    ${Plus_Button}

Store Payment ID
    Wait Until Element Is Visible    xpath=//android.widget.TextView[starts-with(@text, 'T000')]    timeout=15s
    ${payment_id}=    AppiumLibrary.Get Text    xpath=//android.widget.TextView[starts-with(@text, 'T000')]
    Should Not Be Empty    ${payment_id}    Payment ID not found!
    Set Global Variable    ${payment_id}
    Log    [INFO] Stored Global Payment ID: ${payment_id}


Insert Card Names
    [Arguments]     ${User_Name} 
    Click Element   ${Card_Name}
    Input Text      ${Card_Name}    ${User_Name} 
    Execute Script    mobile: hideKeyboard 

Insert Card Numbers
    [Arguments]     ${Card_Numbers} 
    Click Element   ${Card_No}
    Input Text      ${Card_No}    ${Card_Numbers} 
    Execute Script    mobile: hideKeyboard    

Insert CVV Numbers
    [Arguments]     ${Card_CVC} 
    Click Element   ${CVV2_No} 
    Input Text      ${CVV2_No}     ${Card_CVC} 
    Execute Script    mobile: hideKeyboard  

Click Month Expiry date dropdown 
    [Documentation]    Click Unlock Button
    Log    Trying to tap: ${Drop_Month}
    Wait Until Element Is Visible    ${Drop_Month}    ${TIMEOUT} 
    Click Element    ${Drop_Month}

Scroll month expiry date and select the month
    [Arguments]    ${max_scrolls}=10

    ${size}=      Get Window Size Fallback
    ${width}=     Set Variable    ${size["width"]}
    ${height}=    Set Variable    ${size["height"]}

    ${start_x}=   Evaluate    ${width} / 2
    ${start_y}=   Evaluate    ${height} * 0.8
    ${end_y}=     Evaluate    ${height} * 0.2

    FOR    ${index}    IN RANGE    ${max_scrolls}
        ${is_visible}=    Run Keyword And Return Status    Element Should Be Visible    ${Date_Month}
        Run Keyword If    ${is_visible}    Exit For Loop
        Log    Scrolling down... Attempt ${index + 1}
        Swipe    ${start_x}    ${start_y}    ${start_x}    ${end_y}    1000
        Sleep    1s
    END

    Element Should Be Visible    ${Date_Month}
    Click Element    ${Date_Month}
  
   
Click Years Expiry date dropdown 
    [Documentation]    Click Unlock Button
    Log    Trying to tap: ${Drop_Years}
    Wait Until Element Is Visible    ${Drop_Years}    ${TIMEOUT} 
    Click Element    ${Drop_Years}

Scroll Years expiry date and select the years
    [Arguments]    ${max_scrolls}=10

    ${size}=      Get Window Size Fallback
    ${width}=     Set Variable    ${size["width"]}
    ${height}=    Set Variable    ${size["height"]}

    ${start_x}=   Evaluate    ${width} / 2
    ${start_y}=   Evaluate    ${height} * 0.8
    ${end_y}=     Evaluate    ${height} * 0.2

    FOR    ${index}    IN RANGE    ${max_scrolls}
        ${is_visible}=    Run Keyword And Return Status    Element Should Be Visible    ${Date_Years}
        Run Keyword If    ${is_visible}    Exit For Loop
        Log    Scrolling down... Attempt ${index + 1}
        Swipe    ${start_x}    ${start_y}    ${start_x}    ${end_y}    1000
        Sleep    1s
    END

    Element Should Be Visible    ${Date_Years}
    Click Element    ${Date_Years}
    

Click Bank Selection dropdown 
    [Documentation]    Click Unlock Button
    Log    Trying to tap: ${Drop_Bank}
    Wait Until Element Is Visible    ${Drop_Bank}    ${TIMEOUT} 
    Click Element    ${Drop_Bank}


Scroll Bank and select Maybank
    [Arguments]    ${max_scrolls}=10

    ${size}=      Get Window Size Fallback
    ${width}=     Set Variable    ${size["width"]}
    ${height}=    Set Variable    ${size["height"]}

    ${start_x}=   Evaluate    ${width} / 2
    ${start_y}=   Evaluate    ${height} * 0.8
    ${end_y}=     Evaluate    ${height} * 0.2

    FOR    ${index}    IN RANGE    ${max_scrolls}
        ${is_visible}=    Run Keyword And Return Status    Element Should Be Visible    ${Bank_Type}
        Run Keyword If    ${is_visible}    Exit For Loop
        Log    Scrolling down... Attempt ${index + 1}
        Swipe    ${start_x}    ${start_y}    ${start_x}    ${end_y}    1000
        Sleep    1s
    END

    Element Should Be Visible    ${Bank_Type}
    Click Element    ${Bank_Type}
 

Tap T&C Checkbox
    Wait Until Element Is Visible    ${Bank_T&C}     ${TIMEOUT} 
    Click Element                    ${Bank_T&C}    

Click on proceed button on credit card details
    [Documentation]    Click Unlock Button
    Log    Trying to tap: ${Bank_Proceed} 
    Wait Until Element Is Visible    ${Bank_Proceed}     ${TIMEOUT} 
    Click Element    ${Bank_Proceed}      

#Paybill myself page  
Make Advance Payment Button 
    [Documentation]    Click make advance payment button
    Log    Trying to tap: ${Advance_Payment} 
    Wait Until Element Is Visible    ${Advance_Payment}     ${TIMEOUT} 
    Click Element    ${Advance_Payment}   

Insert Amount to pay Into Input Box
    [Arguments]    ${Paybill}
    Click Element    ${Total_Amount}
    Input Text      ${Total_Amount}    ${Paybill}   

Next Paybill
    [Documentation]    Click make advance payment button
    Log    Trying to tap: ${Paybill_Next}  
    Wait Until Element Is Visible    ${Paybill_Next}      ${TIMEOUT} 
    Click Element    ${Paybill_Next}    

Back To Home Paybill
    [Documentation]    Click back to home button to go back to dashboard
    Log    Trying to tap: ${PayBill_BTH}   
    Wait Until Element Is Visible    ${PayBill_BTH}       ${TIMEOUT} 
    Click Element    ${PayBill_BTH}     

Scroll And Select Number For Paybill Myself
    [Arguments]    ${phone_number}    ${max_scrolls}=10    ${TIMEOUT}=3s

    ${target_accessibility_id}=    Set Variable    cardSelect_${phone_number}_text

    ${size}=    Get Window Size Fallback
    ${width}=   Set Variable    ${size["width"]}
    ${height}=  Set Variable    ${size["height"]}

    ${start_x}=   Evaluate    ${width} / 2
    ${start_y}=   Evaluate    ${height} * 0.8
    ${end_y}=     Evaluate    ${height} * 0.2

    FOR    ${index}    IN RANGE    ${max_scrolls}
        ${is_visible}=    Run Keyword And Return Status
        ...    Wait Until Element Is Visible    accessibility_id=${target_accessibility_id}    ${TIMEOUT}
        Run Keyword If    ${is_visible}    Click Element    accessibility_id=${target_accessibility_id}
        Run Keyword If    ${is_visible}    Exit For Loop

        Log    Scrolling... Attempt ${index + 1}
        Swipe    ${start_x}    ${start_y}    ${start_x}    ${end_y}    1000
        Sleep    1s
    END

#Paybill others page 


#Paybill History page
Click First Bill Payment History Entry
    # Wait for the first visible bill payment entry
    Wait Until Element Is Visible    xpath=(//android.view.ViewGroup[contains(@content-desc, "flatList_Bill for")])[1]    10s

    # Click the container of the first bill payment item
    Click Element    xpath=(//android.view.ViewGroup[contains(@content-desc, "flatList_Bill for")])[1]/android.view.ViewGroup

#Transaction details page 
Swipe And to verify the transaction details
    ${size}=    Get Window Size Fallback
    ${width}=   Set Variable    ${size["width"]}
    ${height}=  Set Variable    ${size["height"]}

    ${start_x}=    Evaluate    ${width} / 2
    ${start_y}=    Evaluate    ${height} * 0.8
    ${end_y}=      Evaluate    ${height} * 0.2

    Swipe    ${start_x}    ${start_y}    ${start_x}    ${end_y}    1000
    Sleep    5s

#Credit card otp page    
Insert OTP into the msos code
    [Arguments]    ${otp_code}
    Wait Until Element Is Visible    ${MSOS_Code}    ${TIMEOUT} 
    Click Element    ${MSOS_Code} 
    Input Text       ${MSOS_Code}    ${otp_code}
    Execute Script    mobile: hideKeyboard 

Click submit button on OTP page
    [Documentation]    Click back to home button to go back to dashboard
    Log    Trying to tap: ${PayBill_BTH}   
    Wait Until Element Is Visible    ${PayBill_BTH}       ${TIMEOUT} 
    Click Element    ${PayBill_BTH}        


#Apps window 
Get Window Size Fallback
    ${driver}=    Get Library Instance    AppiumLibrary
    ${session}=   Call Method    ${driver._current_application()}    get_window_size
    RETURN      ${session}
   
#Screenshot 
Capture Screenshot
    ${folder}=    Set Variable    /Users/amarudinjamil/Desktop/Automation Screenshot
    Create Directory    ${folder}    # This will create it only if it doesn't exist
    ${filename}=    Set Variable    ${folder}/mobile_screen_${SCREENSHOT_INDEX}.png
    Log    Capturing screenshot: ${filename}
    Capture Page Screenshot    ${filename}
    ${SCREENSHOT_INDEX}=    Evaluate    ${SCREENSHOT_INDEX} + 1
    Set Suite Variable    ${SCREENSHOT_INDEX}

#Hide keyboard
Hide Keyboard 
    Press Keycode    4    

# Verify text
Verify Text
    [Arguments]    ${text}    ${timeout}=10s
    Log    🔍 Verifying text: "${text}"
    ${xpath}=    Set Variable    //android.widget.TextView[contains(@text, "${text}")]
    Wait Until Element Is Visible    ${xpath}    ${timeout}
    Element Should Be Visible        ${xpath}
    Log    ✅ Text verified: "${text}"

Verify Multiple Texts
    [Arguments]    @{texts}
    ${fail_count}=    Set Variable    0
    ${total}=    Get Length    ${texts}

    FOR    ${text}    IN    @{texts}
        ${result}=    Run Keyword And Ignore Error    Verify Text    ${text}
        ${short_text}=    Evaluate    '${text}' if len('${text}') < 50 else '${text}'[:50] + "..."    re
        Run Keyword If    '${result[0]}' == 'FAIL'
        ...    Log    ❌ Text not found: ${short_text} | ${result[1]}    WARN
        ...    Set Variable    ${fail_count}=    Evaluate    ${fail_count} + 1
        Run Keyword If    '${result[0]}' == 'PASS'    Log    ✅ Text found: ${short_text}
    END

    Run Keyword If    ${fail_count} == ${total}    Fail    ❌ All expected texts were not found!

#Add on page
Scroll And Click Tab By Text
    [Arguments]    ${tab_text}    ${max_scrolls}=5

    ${size}=      Get Window Size Fallback
    ${width}=     Set Variable    ${size["width"]}
    ${height}=    Set Variable    ${size["height"]}

    ${start_y}=   Evaluate    ${height} * 0.20    # y position where tabs are
    ${start_x}=   Evaluate    ${width} * 0.8      # start near right edge
    ${end_x}=     Evaluate    ${width} * 0.2      # swipe left

    FOR    ${index}    IN RANGE    ${max_scrolls}
        ${is_visible}=    Run Keyword And Return Status    Page Should Contain Element    xpath=//android.widget.TextView[@text="${tab_text}"]
        Run Keyword If    ${is_visible}    Exit For Loop
        Log    Side scrolling tabs... Attempt ${index + 1}
        Swipe    ${start_x}    ${start_y}    ${end_x}    ${start_y}    800
        Sleep    1s
    END

    Element Should Be Visible    xpath=//android.widget.TextView[@text="${tab_text}"]
    Click Element    xpath=//android.widget.TextView[@text="${tab_text}"]

Choose Add On With Scroll
    [Arguments]    ${Internetaddon}
    ${desc}=    Set Variable    cardSelect_${Internetaddon}_text

    ${size}=      Get Window Size Fallback
    ${width}=     Set Variable    ${size["width"]}
    ${height}=    Set Variable    ${size["height"]}

    ${start_x}=   Evaluate    ${width} / 2
    ${start_y}=   Evaluate    ${height} * 0.8
    ${end_y}=     Evaluate    ${height} * 0.2

    FOR    ${i}    IN RANGE    10
        ${is_visible}=    Run Keyword And Return Status    Element Should Be Visible    accessibility_id=${desc}
        Run Keyword If    ${is_visible}    Exit For Loop
        Swipe    ${start_x}    ${start_y}    ${start_x}    ${end_y}    800
    END

    Wait Until Element Is Visible    accessibility_id=${desc}    ${TIMEOUT}
    Click Element    accessibility_id=${desc}   

 
Add on Description page Next button
    [Documentation]    Click Next Button
    Log    Trying to tap: ${Addon_Next} 
    Wait Until Element Is Visible    ${Addon_Next}     ${TIMEOUT} 
    Click Element    ${Addon_Next}

Click back to home from successfull add on purchase
    [Documentation]    Click Next Button
    Log    Trying to tap: ${Addon_BTH} 
    Wait Until Element Is Visible    ${Addon_BTH}     ${TIMEOUT} 
    Click Element    ${Addon_BTH}    


#Confirmation page    
Select Add on Payment Type
    [Arguments]    ${method}
    ${element}=    Run Keyword If    '${method}' == 'charge'    Set Variable    ${CHARGE_TO_BILL}
    ...            ELSE IF    '${method}' == 'other'    Set Variable    ${OTHER_METHODS}
    Wait Until Element Is Visible    ${element}    ${TIMEOUT}
    Click Element    ${element}

Click To buy
    [Arguments]    ${method}
    ${element}=    Run Keyword If    '${method}' == 'BuyNow'    Set Variable    ${Addon_BuyNow}
    ...            ELSE IF    '${method}' == 'Next'    Set Variable    ${ConfirmPage_Next}
    Wait Until Element Is Visible    ${element}    ${TIMEOUT}
    Click Element    ${element}    

Confirm And Pay button
    [Documentation]    Click Confirm And Pay button if element exists, otherwise skip
    ${is_present}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${ConfirmAndPay}    ${TIMEOUT}
    IF    ${is_present}
        Log    Element found, clicking: ${ConfirmAndPay}
        Click Element    ${ConfirmAndPay}
    ELSE
        Log    Element not found after waiting ${TIMEOUT}, skipping click
    END

Already have add on
    [Documentation]    Click Next Button if element exists, otherwise skip
    ${is_present}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${Already_Have}    ${TIMEOUT}
    IF    ${is_present}
        Log    Element found, clicking: ${Already_Have}
        Click Element    ${Already_Have}
    ELSE
        Log    Element not found after waiting ${TIMEOUT}, skipping click
    END

    