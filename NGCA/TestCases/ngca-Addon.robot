*** Settings ***
Documentation    This file to store test cases only

Resource    ../TestKeywords/NGCA-sharedKeywords.robot
Resource    ../TestKeywords/NGCA-AllKeywords.robot

*** Test Cases ***
Test Case 1: Addon one-time pass
    Open Ngca App
    Go To Next Onboarding Page
    ...    Join us on an exciting journey of growth and endless possibilities, built for you and with you.
    ...    Redefining your experience us. Explore personalised features, exclusive customers benefits, smart services and limitless possibilities.
    ...    ${NEXT_BUTTON_PAGE}
    Go To Next Onboarding Page
    ...    Redefining your experience us. Explore personalised features, exclusive customers benefits, smart services and limitless possibilities.
    ...    Step into the new
    ...    ${NEXT_BUTTON_PAGE}    
    Click Third Page Unlock Button
    Click SSO Button
    Click Gmail Icon
    Switch To Gmail WebView
    Select Gmail Account With Scroll    ngca1880@gmail.com
    # Value = ngca1880 - can be changes to another values for selection
    Switch To Gmail Native
    Sleep    30 seconds
    Scroll To And Click Addon
    Sleep    3 seconds      
    Scroll And Click Tab By Text    One-Time Pass
    Sleep    3 seconds 
    Choose Add On With Scroll       2999GB Internet Pass (5G+4G)
    Sleep    3 seconds
    Add on Description page Next button
    Sleep    3 seconds
    Select Add on Payment Type        charge
    Sleep    3 seconds
    Click To buy        BuyNow
    Sleep    3 seconds
    Confirm And Pay button
    Sleep    20 seconds
    # Already have add on
    # Sleep    3 seconds
    # Confirm And Pay button
    # Sleep    3 seconds
    Click back to home from successfull add on purchase
    Sleep    3 seconds
    Click Service Tab Button On Dashboard
    Sleep    3 seconds
    Scroll Until Transaction history Is Visible and click on it
    Sleep    5 seconds
    Search for transaction history        2999GB Internet Pass_(5G+4G) Postpaid
    Sleep    5 second
    Swipe And to verify the transaction details 
    Sleep    5 seconds
    Go Back
    Go Back
    Sleep    5 seconds
    Scroll Until MyPlan Is Visible And Click
    Sleep    10 seconds
    Click on internet subcription button at my plan page
    Sleep    10 seconds
    Go Back
    Go Back
    Click Home tab On Dashboard
    Sleep    5 seconds
    Click Usage Icon on dashboard
    Sleep    10 seconds
    Scroll to verify the add on is available        2999GB Internet Pass_(5G+4G) Postpaid
    Sleep    10 seconds
    Go Back
    Sleep    3 seconds
    Click Setting Icon On Dashboard
    Sleep    2 seconds
    Scroll and tap LogOut
    Sleep    2 seconds
    Close Ngca App


