*** Settings ***
Documentation    This file to store test cases only

Resource    ../TestKeywords/NGCA-sharedKeywords.robot
Resource    ../TestKeywords/NGCA-AllKeywords.robot


*** Test Cases ***
Test Case 1: Paybill for Myself DIGI
    Open Ngca App
    Sleep    3 seconds
    Capture Screenshot
    Click Next Button for onboarding page 1 and 2
    Sleep    2 seconds
    Capture Screenshot
    Sleep    3 seconds    
    Click Next Button for onboarding page 1 and 2
    Sleep    2 seconds
    Capture Screenshot
    Click Unlock Button
    Sleep    3 seconds
    Capture Screenshot
    Insert MSISDN Into Input Box    0148947420
    Sleep    2 seconds
    #Input or changes msisdn number beside the input box 
    Capture Screenshot
    Click Request OTP Button
    Sleep    2 seconds
    Capture Screenshot
    Click Get started Button
    Sleep    3 seconds
    Capture Screenshot
    Sleep    20 seconds 
    Capture Screenshot   
    Click PayBill Button On Dashboard
    Sleep    3 seconds
    Capture Screenshot
    Scroll And Select Number for paybill myself    0148947420
    Sleep    3 seconds   
    Capture Screenshot 
    Make Advance Payment Button 
    Sleep    3 seconds 
    Capture Screenshot   
    Insert Amount to pay Into Input Box    1000
    Sleep    3 seconds     
    Capture Screenshot
    # 100 = RM 1 
    Next Paybill
    Sleep    3 seconds    
    Capture Screenshot
    Click Payment Method    Online Banking
    Sleep    3 seconds 
    Capture Screenshot 
     # please put the following into test cases to choose payment method : Credit Card, Online Banking, e-Wallet
    Turn Switch On If Off
    Sleep    3 seconds  
    Capture Screenshot 
    Click Reload Next button
    Sleep    3 seconds  
    Capture Screenshot    
    Click on select bank
    Sleep    4 seconds 
    Capture Screenshot  
    Click Payment Option    Maybank2U
    Sleep    4 seconds 
    Capture Screenshot     
     # please put the following into test cases to choose Online banking type : Maybank2U, HSBC Bank B2B Do not use, Affin Bank
    Click OB Summary Next button
    Sleep    4 seconds    
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
    Click Confirm Button at FPX page
    Sleep    10 seconds      
    Capture Screenshot  
    Sleep    5 seconds  
    Capture Screenshot   
    Back To Home Paybill
    Sleep    3 seconds
    Capture Screenshot    
    Click Service Tab Button On Dashboard
    Sleep    3 seconds 
    Capture Screenshot   
    Click Bill payment history
    Sleep    3 seconds  
    Capture Screenshot                         
    Click First Bill Payment History Entry
    Sleep    3 seconds 
    Capture Screenshot
    Swipe And to verify the transaction details 
    Sleep    2 seconds
    Capture Screenshot   
    Close Ngca App