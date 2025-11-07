*** Settings ***
Documentation    This file to store test cases only

Resource    ../TestKeywords/NGCA-sharedKeywords.robot
Resource    ../TestKeywords/NGCA-AllKeywords.robot


*** Test Cases ***
Test Case 1: Reload for Myself DIGI
    Open Ngca App
    Verify Multiple Texts
    ...    Welcome to
    ...    Next-Gen
    ...    Connectivity
    ...    Experience a seamless world of possibilities as we merge into something bigger and better. Join us!
    Click Next Button for onboarding page 1 and 2
    Sleep    3 seconds
    Verify Multiple Texts
    ...    Your
    ...    Telco
    ...    Way
    ...    It's all about you – discover tailor-made features that redefine your digital journey.
    Sleep    2 seconds  
    Capture Screenshot  
    Click Next Button for onboarding page 1 and 2
    Sleep    3 seconds
    Capture Screenshot
    Verify Multiple Texts
    ...    Unleash the Power of 
    ...    of your telco
    ...    Unlock seamless access to services, exclusive deals, and more. Stay connected like never before with our new app.      
    Click Unlock Button
    Sleep    3 seconds
    Capture Screenshot
    Insert MSISDN Into Input Box    0104367388
    Sleep    2 seconds
    Capture Screenshot
     #Input or changes msisdn value beside the input box
    Click Request OTP Button
    Sleep    3 seconds
    Capture Screenshot
    Click Get started Button
    Sleep    3 seconds
    Capture Screenshot
    Sleep    20 seconds 
    Capture Screenshot   
    Click Reload Button On Dashboard
    Sleep    2 seconds
    Capture Screenshot
    Click Reload Amount With Scroll    RM 5
    Sleep    2 seconds
    Capture Screenshot
     # please use the following for reload amount : RM 5, RM 10, RM 30, RM 50, RM 100     
    Click Reload Next button
    Sleep    2 seconds    
    Capture Screenshot
    Click Payment Method    Online Banking
    Sleep    2 seconds  
    Capture Screenshot
     # please put the following into test cases to choose payment method : Credit Card, Online Banking, e-Wallet
    Turn Switch On If Off
    Sleep    2 seconds
    Capture Screenshot   
    Click Reload Next button
    Sleep    3 seconds  
    Capture Screenshot    
    Click on select bank
    Sleep    3 seconds
    Capture Screenshot   
    Click Payment Option    Maybank2U
    Sleep    2 seconds  
    Capture Screenshot    
     # please put the following into test cases to choose Online banking type : Maybank2U, HSBC Bank B2B Do not use, Affin Bank
    Click OB Summary Next button
    Sleep    2 seconds  
    Capture Screenshot  
    Insert User ID Into FPX ID Box    1234
    Sleep    2 seconds 
    Capture Screenshot     
     # U can changes or input new username beside the FPX ID Box
    Insert Password Into FPX Password Box    1234
    Sleep    2 seconds 
    Capture Screenshot     
     # U can changes or input new Password beside the FPX ID Box  
    Click SignIn Button at FPX page
    Sleep    4 seconds
    Capture Screenshot
    Click Confirm Button at FPX page
    Sleep    4 seconds    
    Capture Screenshot  
    Sleep    5 seconds    
    Capture Screenshot 
    Click Receipt at Success reload page
    Sleep    3 seconds    
    Capture Screenshot
    Click Back to Home at Receipt page
    Sleep    3 seconds 
    Capture Screenshot
    Click Service Tab Button On Dashboard
    Sleep    3 seconds  
    Capture Screenshot  
    Scroll Until Reload History Is Visible and click on it
    Sleep    3 seconds   
    Capture Screenshot                        
    Click First Reload History Entry
    Sleep    3 seconds 
    Capture Screenshot
    Swipe And to verify the transaction details  
    Capture Screenshot  
    Close Ngca App

Test Case 2: Reload for Myself Celcom
    Open Ngca App
    Verify Multiple Texts
    ...    Welcome to
    ...    Next-Gen
    ...    Connectivity
    ...    Experience a seamless world of possibilities as we merge into something bigger and better. Join us!
    Click Next Button at onboarding page
    Sleep    3 seconds
    Verify Multiple Texts
    ...    Your
    ...    Telco
    ...    Way
    ...    It's all about you – discover tailor-made features that redefine your digital journey.
    Sleep    2 seconds  
    Capture Screenshot  
    Click Next Button at onboarding page
    Sleep    3 seconds
    Capture Screenshot
    Verify Multiple Texts
    ...    Unleash the Power of 
    ...    of your telco
    ...    Unlock seamless access to services, exclusive deals, and more. Stay connected like never before with our new app.      
    Click Unlock Button
    Sleep    3 seconds
    Capture Screenshot
    Insert MSISDN Into Input Box    0104367388
    Sleep    2 seconds
    Capture Screenshot
     #Input or changes msisdn value beside the input box
    Click Request OTP Button
    Sleep    3 seconds
    Capture Screenshot
    Click Get started Button
    Sleep    3 seconds
    Capture Screenshot
    Sleep    20 seconds 
    Capture Screenshot   
    Click Reload Button On Dashboard
    Sleep    2 seconds
    Capture Screenshot
    Click Reload Amount With Scroll    RM 5
    Sleep    2 seconds
    Capture Screenshot
     # please use the following for reload amount : RM 5, RM 10, RM 30, RM 50, RM 100     
    Click Reload Next button
    Sleep    2 seconds    
    Capture Screenshot
    Click Payment Method    Online Banking
    Sleep    2 seconds  
    Capture Screenshot
     # please put the following into test cases to choose payment method : Credit Card, Online Banking, e-Wallet
    Turn Switch On If Off
    Sleep    2 seconds
    Capture Screenshot   
    Click Reload Next button
    Sleep    3 seconds  
    Capture Screenshot    
    Click on select bank
    Sleep    3 seconds
    Capture Screenshot   
    Click Payment Option    Maybank2U
    Sleep    2 seconds  
    Capture Screenshot    
     # please put the following into test cases to choose Online banking type : Maybank2U, HSBC Bank B2B Do not use, Affin Bank
    Click OB Summary Next button
    Sleep    2 seconds  
    Capture Screenshot  
    Insert User ID Into FPX ID Box    1234
    Sleep    2 seconds 
    Capture Screenshot     
     # U can changes or input new username beside the FPX ID Box
    Insert Password Into FPX Password Box    1234
    Sleep    2 seconds 
    Capture Screenshot     
     # U can changes or input new Password beside the FPX ID Box  
    Click SignIn Button at FPX page
    Sleep    4 seconds
    Capture Screenshot
    Click Confirm Button at FPX page
    Sleep    4 seconds    
    Capture Screenshot  
    Sleep    5 seconds    
    Capture Screenshot 
    Click Receipt at Success reload page
    Sleep    3 seconds    
    Capture Screenshot
    Click Back to Home at Receipt page
    Sleep    3 seconds 
    Capture Screenshot
    Click Service Tab Button On Dashboard
    Sleep    3 seconds  
    Capture Screenshot  
    Scroll Until Reload History Is Visible and click on it
    Sleep    3 seconds   
    Capture Screenshot                        
    Click First Reload History Entry
    Sleep    3 seconds 
    Capture Screenshot
    Swipe And to verify the transaction details  
    Capture Screenshot  
    Close Ngca App

