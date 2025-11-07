*** Settings ***
Documentation    This file to store test cases only

Resource    ../TestKeywords/NGCA-sharedKeywords.robot
Resource    ../TestKeywords/NGCA-AllKeywords.robot


*** Test Cases ***
Test Case 1: Login using email login
    Open Ngca App
    Sleep    5 seconds
    Click Next Button at onboarding page
    Sleep    5 seconds
    Click Next Button at onboarding page
    Sleep    5 seconds
    Click Unlock Button
    Sleep    10 seconds
    Click SSO Button
    Sleep    5 seconds
    Click Continue with email
    Sleep    10 seconds
    Insert Email ID Into Input Box    ngca1880@gmail.com
    Sleep    10 seconds
    # U can input or changes email ID beside the input box     
    Insert password ID Into Input Box    Ngca@1234
    Sleep    10 seconds
    # U can input or changes Password ID beside the input box    
    Click Submit Login With Email
    Sleep    30 seconds
    Close Ngca App