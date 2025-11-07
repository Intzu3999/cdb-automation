*** Settings ***
Library    AppiumLibrary
Resource   ../TestVariables/NGSA-VariablesAP.robot

*** Variables ***
${REMOTE_URL}       http://127.0.0.1:4723
${PLATFORM_NAME}    Android
${DEVICE_NAME}      Pixel_6
${BROWSER_NAME}     Chrome
${AUTOMATION_NAME}  UiAutomator2    
# ${APP_PACKAGE}      com.android.chrome
# ${APP_ACTIVITY}     com.google.android.apps.chrome.Main

# --- RUN THIS ---
# emulator -avd Pixel_6
# appium --allow-insecure=chromium:chromedriver_autodownload 


*** Test Cases ***
Reload
    # Open browser (using Appium mobile Chrome)
    Open Application    remote_url=http://127.0.0.1:4723
    ...    platformName=Android
    ...    automationName=UiAutomator2
    ...    appPackage=com.celcomdigi.ngsa
    ...    appActivity=.MainActivity

#Enter Dealer ID
    Wait Until Element Is Visible    //android.widget.Image[@text="logo"]    timeout=50s
    Element Should Be Visible    //android.widget.EditText[@resource-id="User_Id"]
    Input Text    //android.widget.EditText[@resource-id="User_Id"]    ${USERNAME}
    Sleep    2s
    Wait Until Element Is Visible    //android.widget.Button[@text="loginCelcom_submit_button"]    timeout=30s
    Click Element    //android.widget.Button[@text="loginCelcom_submit_button"]

#Enter Password
    Wait Until Element Is Visible    //android.widget.Image[@text="Company Logo"]    timeout=50s
    Element Should Be Visible    //android.widget.EditText[@resource-id="password"]    
    Input Text    //android.widget.EditText[@resource-id="password"]    ${PASSWORD}
    Click Element    //android.widget.Button[@resource-id="next"]
    
#View Wallet
    Wait Until Element Is Visible    //android.widget.Button[@text="home_viewWallet_button"]    timeout=50s
    Click Element    //android.widget.Button[@text="home_viewWallet_button"]
    Sleep    5s 
    Wait Until Element Is Visible    //android.widget.Button[@text="bottomDrawer_close_button"]    timeout=30s
    Click Element    //android.widget.Button[@text="bottomDrawer_close_button"]
    Sleep    3s

# Reload icon
    Wait Until Element Is Visible    //android.widget.Button[@text="iconTilesNavigation_Reload_button"]    timeout=30s
    Click Element    //android.widget.Button[@text="iconTilesNavigation_Reload_button"]   

# Validate MSISDN
    Wait Until Element Is Visible    //android.widget.TextView[@text="bottomDrawer_title_text"]    timeout=30s
    Element Should Be Visible    //android.widget.EditText[@resource-id="mobileNo"]
    Input Text    //android.widget.EditText[@resource-id="mobileNo"]    ${PrepaidMSISDN}
    Sleep    4s
    Wait Until Element Is Visible    //android.widget.Button[@text="bottomDrawer_primary_button"]    timeout=30s
    Sleep    3s
    Click Element    //android.widget.Button[@text="bottomDrawer_primary_button"]
    Sleep    3s

# Click Reload button
    Wait Until Element Is Visible    //android.widget.TextView[@text="skeleton_headerTitle_text"]    timeout=50s
    Element Should Be Visible    //android.widget.Button[@text="skeleton_primary_button"]
    Sleep    3s
    Wait Until Element Is Visible    //android.widget.Button[@text="skeleton_primary_button"]    timeout=30s
    Sleep    3s
    Click Element    //android.widget.Button[@text="skeleton_primary_button"]
    Sleep    3s

# Select Deno (other amount)
    Wait Until Element Is Visible    //android.widget.TextView[@text="reloadSelection_otherAmountTitle_text"]    timeout=50s
    Element Should Be Visible    //android.widget.EditText[@resource-id="otherAmount"]    timeout=50s
    Input Text    //android.widget.EditText[@resource-id="otherAmount"]    12
    Sleep    5s
    Click Element    //android.widget.Button[@text="skeleton_primary_button"]
    Sleep    3s

# Select Deno (RM5)
    # Wait Until Element Is Visible    //android.widget.TextView[@text="skeleton_headerTitle_text"]    timeout=50s
    # Element Should Be Visible    //android.view.View[@resource-id="layout-content"]/android.view.View[1]/android.view.View    timeout=50s    
    # #Element Should Be Visible    //android.view.View[@resource-id="layout-content"]/android.view.View[1]/android.view.View/android.view.View
    # Click Element    //android.view.View[@resource-id="layout-content"]/android.view.View[1]/android.view.View
    # Sleep    3s
    # Click Element    //android.widget.Button[@text="skeleton_primary_button"]

# Payment Summary
    Wait Until Element Is Visible    //android.widget.TextView[@text="skeleton_headerTitle_text"]    timeout=50s
    Sleep    3s
    Wait Until Element Is Visible    //android.widget.Button[@text="skeleton_primary_button"]    timeout=30s
    Click Element    //android.widget.Button[@text="skeleton_primary_button"]
    Sleep    3s

# Wallet Credential
    #Wait Until Page Contains    //android.widget.EditText[@resource-id="password"]    timeout=50s
    Wait Until Element Is Visible    //android.widget.EditText[@resource-id="password"]    timeout=50s
    Input Text    //android.widget.EditText[@resource-id="password"]    ${PIN}
    Sleep    2s
    Wait Until Element Is Visible    //android.widget.Button[@text="bottomDrawer_primary_button"]    timeout=50s
    Click Element    //android.widget.Button[@text="bottomDrawer_primary_button"]
    Sleep    3s

# Payable amount
    Wait Until Element Is Visible    //android.widget.Button[@text="skeleton_primary_button"]    timeout=50s
    Wait Until Element Is Visible    //android.view.View[@resource-id="layout-content"]/android.view.View/android.view.View[2]/android.view.View    timeout=50s
    Click Element    //android.widget.Button[@text="skeleton_primary_button"]
    Sleep    3s
    
#Reload success
    Wait Until Element Is Visible    //android.widget.TextView[@text="statusPage_title_text"]    timeout=50s
    # //android.widget.Button[@text="statusPage_primary_button"]
    Sleep    5s
    Click Element    //android.view.View[@resource-id="root"]/android.view.View/android.view.View[3]
    Sleep    3s
    
#Reopen Main Page
    Wait Until Element Is Visible    //android.widget.Button[@text="home_viewWallet_button"]    timeout=50s
    Click Element    //android.widget.Button[@text="home_viewWallet_button"]
    Sleep    5s 
    Wait Until Element Is Visible    //android.widget.Button[@text="bottomDrawer_close_button"]    timeout=30s
    Click Element    //android.widget.Button[@text="bottomDrawer_close_button"]
    Sleep    3s

#Reload icon
    Wait Until Element Is Visible    //android.widget.Button[@text="iconTilesNavigation_Reload_button"]    timeout=30s
    Click Element    //android.widget.Button[@text="iconTilesNavigation_Reload_button"]   
    Sleep    3s

#Validate MSISDN
    Wait Until Element Is Visible    //android.widget.TextView[@text="bottomDrawer_title_text"]    timeout=30s
    Element Should Be Visible    //android.widget.EditText[@resource-id="mobileNo"]
    Input Text    //android.widget.EditText[@resource-id="mobileNo"]    601012001030
    Sleep    2s
    Click Element    //android.widget.Button[@text="bottomDrawer_primary_button"]
    Sleep    4s
    Close Application
