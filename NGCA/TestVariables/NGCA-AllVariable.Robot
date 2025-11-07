*** Settings ***
Documentation     This file contains all variable for NGCA tests.

Resource          ../NGCA-testSettings.robot 

*** Variables ***
#Otp Variable
${Get_Started}              accessibility_id=otpModal_verifyOtp_button
${Resend_OTP}               accessibility_id=otpModal_resendOtp_text

#Profile setup 1 Variable 
${Profile_Name}            accessibility_id=profileSetup_profileName_input
${Profile_Back}            accessibility_id=profileSetup_back_button
${Profile_Next_1}          accessibility_id=profileSetup_next_button

#Profile setup 2 Variable 
${Profile2_Back}            accessibility_id=profileSetup_back_button
${AVATAR_BASE}              profileSetup_avatar_
${AVATAR_SUFFIX}            _image
${Profile_Next_2}           accessibility_id=profileSetup_next_button

#Welcome page Variable
${NEXT_BUTTON_Page}         accessibility_id=onboarding_next_button
${Unlock}                   accessibility_id=onboarding_loginWithCelcomDigi_button
${MSISDN_Box}               accessibility_id=login_enterMisdnNumber_input
${T&C}                      accessibility_id=login_tncTitle2_text                 #can be used for SSO Term&Condition
${Privacy}                  accessibility_id=login_tncTitle4_text                 #can be used for SSO Privacy
${OTP}                      accessibility_id=login_requestOtp_button
${SSO}                      accessibility_id=login_singleSignOn_button

#SSO and continue with email
${CWE}                      accessibility_id=login_loginWithEmail_button
${CWE_Email}                //android.widget.EditText[@resource-id="username"]
${CWE_Password}             //android.widget.EditText[@resource-id="password"]
${CWE_Submit}               //android.widget.Button[@resource-id="kc-login"]
${Gmail_Icon}               accessibility_id=login_googleLogin_button
${Gmail_WEBVIEW_CONTEXT}    WEBVIEW_com.android.chrome
${Gmail_NATIVE_CONTEXT}     NATIVE_APP

#Dashboard Variable
${Reload_Button}            accessibility_id=Reload
${Reload_Next_Button}       accessibility_id=__button
${Service_Tab}              accessibility_id=Services 
${Paybill_Button}           accessibility_id=Pay Bill
${Setting_Icon}             accessibility_id=home_settinIcon_button
${Dashboard_Addon}          accessibility_id=Add-ons
${Home_Tab}                 accessibility_id=Home
${Usage_Icon}               accessibility_id=Usage  

#Setting page Variable
${COGWHEEL_X}               238
${COGWHEEL_Y}               638
${Log_Out}                  accessibility_id=accountProfile_profileLogout_button

#Edit Profile page Variable
${ProfilePage_Back}          accessibility_id=_back_button

#OB summary transaction and fpx page
${Next_Button_OB}           //android.widget.Button[@resource-id="proceed"]
${FPX_User_ID}              //android.widget.EditText[@resource-id="userId"]
${FPX_User_Password}        //android.widget.EditText[@resource-id="password"]
${Input_User_Signin}        //android.widget.Button[@text="Sign in"]
${Input_User_Cancel}        //android.widget.Button[@text="Cancel"]
${User_FPX_Confirm}         //android.widget.Button[@text="Confirm"]
${User_FPX_Print}           id=btnBack
${User_FPX_Complete}        //android.widget.Button[@text="Click Here to Complete Your Transaction"]


#Reload for myself page
${Reload_BTH}               accessibility_id=Back to Home
${Reload_Receipt}           accessibility_id=View Receipt 
${Reload_AddEmail}          //android.widget.TextView[@text="Add Email to Contact Email"]
${ViewReceipt_BTH}          accessibility_id=Back to Home
${RELOAD_ENTRY_XPATH}       xpath=(//android.view.ViewGroup[contains(@content-desc, "flatList_Reload for")])[1]
${RELOAD_ENTRY_CONTAINER_XPATH}    xpath=(//android.view.ViewGroup[contains(@content-desc, "flatList_Reload for")])[1]/android.view.ViewGroup

#All Service Page
${Reload_History}          accessibility_id=Reload History
${Reload_Others}           accessibility_id=Reload for Others
${Bill_History}            accessibility_id=Bill Payment History
${Paybill_Others}          accessibility_id=Pay Bill for Others
${Trans_History}           accessibility_id=Transaction History
${MyPlan}                  accessibility_id=My Plan

#Reload for others page
${Reload_Input}           accessibility_id=__input
${ReloadOthers_Next}      accessibility_id=__button

#MyPlan Page
${MyPlan_IS}              accessibility_id=Internet Subscription

#Credit card page
${Card_Next_1}            //android.widget.Button[@resource-id="proceed"]
${Card_Name}              //android.widget.ListView/android.view.View[4]/android.widget.EditText
${Card_No}                //android.widget.EditText[@resource-id="CCNo"]
${CVV2_No}                //android.widget.ListView/android.view.View[6]/android.widget.EditText
${Drop_Month}             //android.view.View[@text="--"]
${Drop_Years}             //android.view.View[@text="----"]
${Date_Month}             //android.widget.CheckedTextView[@resource-id="android:id/text1" and @text="12"]
${Date_Years}             //android.widget.CheckedTextView[@resource-id="android:id/text1" and @text="2028"] 
${Drop_Bank}              //android.view.View[@resource-id="CCBank"] 
${Bank_Type}              //android.widget.CheckedTextView[@resource-id="android:id/text1" and @text="Maybank"]
${Bank_T&C}               //android.widget.CheckBox[@resource-id="AcceptTC"] 
${Bank_Proceed}           //android.widget.Button[@text="» Proceed"]
${Plus_Button}            //android.widget.Image[@resource-id="cnt_icon_summary"]
${PAYMENT_ID_SELECTOR}    //android.widget.TextView[@text and starts-with(@text, 'T000')]

#Credit card webview otp
${MERCHANT_ID_INPUT}      //input[@name="merchantAccId"]
${SEARCH_BUTTON}          //button[2]
${OTP_RESULT}             //div[@id="__next"]/div[1]/div[3]/div[1]/p[6]

#Credit card Apps otp
${MSOS_Code}              //android.widget.EditText
${OTP_Submit}             //android.widget.TextView[@text="Submit"]
${OTP_Resend}             //android.widget.TextView[@text="Resend Code"]
${OTP_Cancel}             //android.widget.TextView[@text="Cancel"]


# Chrome Capabilities
${CHROME_PACKAGE}         com.android.chrome
${CHROME_ACTIVITY}        com.google.android.apps.chrome.Main
${OTP_URL}                https://mbbmgatebeta.maybank.com/otp-listing

#Paybill Page
${Advance_Payment}        accessibility_id=__button
${Total_Amount}           accessibility_id=totalAmount_payMyself_input
${Paybill_Next}           accessibility_id=payMyself_btnText_button
${PayBill_BTH}            accessibility_id=Back to Home

#Addon page
${Addon_Next}           accessibility_id=__button
${Addon_BTH}            accessibility_id=Back to Home

#Confirmation page
${CHARGE_TO_BILL}         accessibility_id=Charge\nto bill
${OTHER_METHODS}          accessibility_id=Other\nMethods
${Addon_BuyNow}           accessibility_id=__button
${ConfirmPage_Next}       accessibility_id=__button
${ConfirmAndPay}          accessibility_id=Confirm & Pay
${Already_Have}           accessibility_id=Confirm

#Wait until elements visible 
${TIMEOUT}                30s

#Screenshot 
${SCREENSHOT_INDEX}        1
    