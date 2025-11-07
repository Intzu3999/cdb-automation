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
Add Ons
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
    Click Element    //android.widget.Button[@text="loginCelcom_submit_button"]

#Enter Password
    Wait Until Element Is Visible    //android.widget.Image[@text="Company Logo"]    timeout=50s
    Element Should Be Visible    //android.widget.EditText[@resource-id="password"]    
    Input Text    //android.widget.EditText[@resource-id="password"]    ${PASSWORD}
    Click Element    //android.widget.Button[@resource-id="next"]
    Sleep    3s
    
#View Wallet
    Wait Until Element Is Visible    //android.widget.Button[@text="home_viewWallet_button"]    timeout=50s
    Click Element    //android.widget.Button[@text="home_viewWallet_button"]
    Sleep    5s 
    Click Element    //android.widget.Button[@text="bottomDrawer_close_button"]
    Sleep    5s

#Add Ons icon
    Wait Until Element Is Visible    //android.widget.Button[@text="iconTilesNavigation_AddOn_button"]    timeout=50s
    Click Element    //android.widget.Button[@text="iconTilesNavigation_AddOn_button"]
    Sleep    3s

#Validate MSISDN
    Wait Until Element Is Visible    //android.widget.TextView[@text="bottomDrawer_title_text"]    timeout=30s
    #Element Should Be Visible    //android.widget.EditText[@resource-id="mobileNo"]
    Input Text    //android.widget.EditText[@resource-id="mobileNo"]    601016078505
    Sleep    3s
    Click Element    //android.widget.Button[@text="bottomDrawer_primary_button"]
    Sleep    3s

#Click Choose Add Ons button
    Wait Until Element Is Visible    //android.widget.ListView/android.view.View    timeout=50s
    Element Should Be Visible    //android.view.View[@resource-id="layout-content"]/android.view.View[2]    timeout=30s
    Sleep    2s
    Click Element    //android.view.View[@resource-id="layout-content"]/android.view.View[2]
    Sleep    3s

# Select Add Ons
    #Wait Until Element Is Visible    //android.widget.TextView[@text="skeleton_headerTitle_text"]    timeout=50s
    Wait Until Element Is Visible    //android.widget.TextView[@text="newAddOns_InternetTitle_text"]    timeout=50s    
    #Element Should Be Visible    //android.widget.TextView[@text="newAddOns_InternetTitle_text"]    timeout=50s
    Sleep    3s
    Click Element    //android.view.View[@resource-id="1"]/android.view.View[1]/android.view.View
    Sleep    3s
    Click Element    //android.widget.Button[@text="skeleton_primary_button"]
    Sleep    3s

#Payment Due
    Wait Until Element Is Visible    //android.view.View[@resource-id="layout-content"]/android.view.View    timeout=50s
    Sleep    3s
    Click Element    //android.widget.Button[@text="skeleton_primary_button"]
    Sleep    3s

#Wallet Credential
    #Wait Until Page Contains    //android.widget.EditText[@resource-id="password"]    timeout=50s
    Wait Until Element Is Visible    //android.widget.EditText[@resource-id="password"]    timeout=50s
    Input Text    //android.widget.EditText[@resource-id="password"]    ${PIN}
    Sleep    2s
    Click Element    //android.widget.Button[@text="bottomDrawer_primary_button"]
    Sleep    2s
    Click Element    //android.widget.Button[@text="bottomDrawer_primary_button"]
    Sleep    3s

#Payable amount/confirm payment
    Wait Until Element Is Visible    //android.widget.TextView[@text="paymentMethods_amountTitle_text"]    timeout=50s
    Click Element    //android.view.View[@resource-id="layout-content"]/android.view.View/android.view.View[3]/android.view.View
    Sleep    2s
    #Wait Until Element Is Visible    //android.view.View[@resource-id="root"]/android.view.View/android.view.View[3]    timeout=30s
    Click Element    //android.widget.Button[@text="skeleton_primary_button"]
    Sleep    3s
    
#Order Submission success
    Wait Until Element Is Visible    //android.widget.TextView[@text="statusPage_title_text"]    timeout=50s
    Sleep    5s
    Click Element    //android.widget.Button[@text="statusPage_primary_button"]
    Sleep    3s
    
#Transaction View
    Wait Until Element Is Visible    //android.view.View[@resource-id="root"]/android.view.View/android.view.View[1]   timeout=50s
    Sleep    5s
    Click Element    //android.widget.Button[@text="skeleton_back_button"]
    sleep    2s
    Wait Until Element Is Visible    //android.widget.Image[@text="bottomNavigation_item0_icon"]    timeout=50s       
    Click Element    //android.widget.Image[@text="bottomNavigation_item0_icon"]
    Sleep    10s

#Back to Landing Page

#Open Wallet
    Wait Until Element Is Visible    //android.widget.Button[@text="home_viewWallet_button"]    timeout=50s
    Click Element    //android.widget.Button[@text="home_viewWallet_button"]
    Sleep    10s 
    Click Element    //android.widget.Button[@text="bottomDrawer_close_button"]
    Sleep    10s

#Open back Transaction Page after 20s
    Wait Until Element Is Visible    //android.widget.Image[@text="bottomNavigation_item3_icon"]    timeout=50s
    Click Element    //android.widget.Image[@text="bottomNavigation_item3_icon"]
    Sleep    2s
    Wait Until Element Is Visible    //android.widget.RadioButton[@text="Digi"]    timeout=50s
    Click Element    //android.widget.RadioButton[@text="Digi"]
    Sleep    2s
    Wait Until Element Is Visible    //android.widget.ListView/android.view.View[1]/android.view.View    timeout=50s
    Click Element    //android.widget.ListView/android.view.View[1]/android.view.View
    Sleep    10s
    Close Application