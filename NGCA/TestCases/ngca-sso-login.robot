*** Settings ***
Documentation    This file to store test cases only

Resource    ../TestKeywords/NGCA-sharedKeywords.robot
Resource    ../TestKeywords/NGCA-AllKeywords.robot


*** Test Cases ***
Test Case 1: Login using Gmail
    Open Ngca App
    Sleep    5 seconds
    Capture Screenshot
    Click Next Button at onboarding page
    Sleep    3 seconds
    Capture Screenshot
    Click Next Button at onboarding page
    Sleep    3 seconds
    Capture Screenshot
    Click Unlock Button
    Sleep    3 seconds
    Capture Screenshot
    Click SSO Button
    Sleep    3 seconds
    Capture Screenshot
    Click Gmail Icon
    Sleep    3 seconds
    Capture Screenshot
    Switch To Gmail WebView
    Sleep    5 seconds
    Capture Screenshot
    Select Gmail Account With Scroll    ngca1880@gmail.com
    Sleep    3 seconds
   # Value = ngca1880 - can be changes to another values for selection
    Capture Screenshot
    Switch To Gmail Native
    Sleep    30 seconds
    Capture Screenshot 
    Click Setting Icon On Dashboard
    Sleep    3 seconds 
    Capture Screenshot 
    Tap Cogwheel
    Sleep    3 seconds
    Capture Screenshot 
    Verify Multiple Texts
    ...    Edit Profile
    ...    Preferred Name
    ...    test
    ...    Linked Accounts
    ...    Google
    ...    ngca1880@gmail.com 
    ...    Use as contact email
    ...    Contact           
    Capture Screenshot
    Swipe Edit profile page
    Sleep    1 seconds 
    Verify Multiple Texts
    ...    Enter your preferred email address for receipts and communication.
    ...    TEST@celcomdigi.com  

    Capture Screenshot
    Sleep    3 seconds 
    Tap Cogwheel
    Sleep    3 seconds
    Capture Screenshot 
    Scroll and tap LogOut
    Sleep    3 seconds
    Capture Screenshot     
    Close Ngca App

    