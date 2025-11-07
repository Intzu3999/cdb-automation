*** Settings ***
Documentation    This file to store test cases only

Resource    ../TestKeywords/NGCA-sharedKeywords.robot
Resource    ../TestKeywords/NGCA-AllKeywords.robot


*** Test Cases ***
Test Case 1: Register with Digi Number
    Open Ngca App
    Sleep    10 seconds
    Click Next Button at onboarding page
    Sleep    5 seconds
    Click Next Button at onboarding page
    Sleep    5 seconds
    Click Unlock Button
    Sleep    5 seconds
    Insert MSISDN Into Input Box    0104369420
    Sleep    5 seconds
    # U can input or changes msisdn number beside the input box  
    Click Request OTP Button
    Sleep    5 seconds
    Click Get started Button
    Sleep    30 seconds
    Insert Name Into Input Box    Amarudin
    Sleep    5 seconds 
    # U can input or changes value beside the input box  
    Next profile page 1
    Sleep    5 seconds
    Click Avatar By Index    8
    Sleep    5 seconds  
    # U can changes value bof the avatar by 1 - 9
    Next profile page 2
    Sleep    30 seconds        
    Close Ngca App