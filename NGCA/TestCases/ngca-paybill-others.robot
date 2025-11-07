*** Settings ***
Documentation    This file to store test cases only

Resource    ../TestKeywords/NGCA-sharedKeywords.robot
Resource    ../TestKeywords/NGCA-AllKeywords.robot


*** Test Cases ***
01. Open NGCA App
    [Tags]   Open
    Open Ngca App
    Sleep    3 seconds

02. Wait For Page to load and view
    [Tags]   Step 1
    Sleep    3 seconds

03. Click Next Button
    [Tags]   Step 2
    Click Next Button at onboarding page
    Sleep    3 seconds
    Capture Screenshot

04. Click Next Button
    [Tags]   Step 3
    Click Next Button at onboarding page
    Sleep    3 seconds
    Capture Screenshot

05. Click Unlock Button
    [Tags]   Step 4
    Click Unlock Button
    Sleep    3 seconds

06. Input Msisdn
    [Tags]   Step 5
    Insert MSISDN Into Input Box    0148947420
    Sleep    10 seconds
    #Input or changes msisdn number beside the input box 

07. Request OTP
    [Tags]   Step 6
    Click Request OTP Button
    Sleep    10 seconds

08. Click Get started Button
    [Tags]   Step 7
    Click Get started Button
    Sleep    10 seconds

09. Wait For Page to load and view dashboard
    [Tags]   Step 8
    Sleep    15 seconds    

10. Click service tab to go to all service page
    [Tags]   Step 9
    Click Service Tab Button On Dashboard
    Sleep    10 seconds   

11. Click Pay bill for others button
    [Tags]   Step 9
    Click PayBill For Others
    Sleep    10 seconds        

12. Input others MSISDN to mobile number box
    [Tags]   Step 10
    Insert MSISDN Into Input Box   0133001523
    Sleep    10 seconds 

13. Click next button in paybill others page
    [Tags]   Step 14
    Click Next Button Reload Others
    Sleep    10 seconds      
 
13. Input amount in amount to pay box
    [Tags]   Step 11
    Insert Amount to pay Into Input Box    1000
    Sleep    10 seconds     

14. Click paybill to move next to payment option page
    [Tags]   Step 12
    Next Paybill
    Sleep    10 seconds    

15. Select Payment method
    [Tags]   Step 13
    Click Payment Method    Online Banking
    Sleep    10 seconds  

     # please put the following into test cases to choose payment method : Credit Card, Online Banking, e-Wallet

16. Switch ON the email me my receipt toggle
    [Tags]   Step 14
    Turn Switch On If Off
    Sleep    10 seconds   

17. Click Next button at Payment method page 
    [Tags]   Step 15
    Click Reload Next button
    Sleep    10 seconds      

18. Scrolls and select bank
    [Tags]   Step 16
    Click on select bank
    Sleep    10 seconds   

19. select bank type
    [Tags]   Step 17
    Click Payment Option    Maybank2U
    Sleep    10 seconds      

     # please put the following into test cases to choose Online banking type : Maybank2U, HSBC Bank B2B Do not use, Affin Bank


20. select next button on online banking 
    [Tags]   Step 18
    Click OB Summary Next button
    Sleep    20 seconds    

21. Input Username in FPX
    [Tags]   Step 19
    Insert User ID Into FPX ID Box    1234
    Sleep    10 seconds      

     # U can changes or input new username beside the FPX ID Box

22. Input Password in FPX
    [Tags]   Step 20
    Insert Password Into FPX Password Box    1234
    Sleep    10 seconds      

     # U can changes or input new Password beside the FPX ID Box  

23. Click Sign in button at FPX page
    [Tags]   Step 21
    Click SignIn Button at FPX page
    Sleep    10 seconds

24. Click Confirm Button at FPX page
    [Tags]   Step 22
    Click Confirm Button at FPX page
    Sleep    10 seconds      

25. Wait For Page to load and get the payment details page
    [Tags]   Step 23
    Sleep    10 seconds    

26. Wait For Page to load and get the reload successful page
    [Tags]   Step 24
    Sleep    10 seconds     

27. Click Back to Home button
    [Tags]   Step 25
    Back To Home Paybill
    Sleep    20 seconds    

28. Click service tab to go to all service page
    [Tags]   Step 26
    Click Service Tab Button On Dashboard
    Sleep    5 seconds    

29. Click on bill payment history button to go to bill payment history page
    [Tags]   Step 27
    Click Bill payment history
    Sleep    5 seconds                           

30. Click on latest paybill history
    [Tags]   Step 28
    Click First Bill Payment History Entry
    Sleep    10 seconds 

31. Verify the Transaction details
    [Tags]   Step 29
    Swipe And to verify the transaction details    

32. Close NGCA App
    [Tags]    close
    Close Ngca App