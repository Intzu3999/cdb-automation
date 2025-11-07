*** Settings ***
Documentation    This file to store test cases only

Resource    ../TestKeywords/NGCA-sharedKeywords.robot
Resource    ../TestKeywords/NGCA-AllKeywords.robot

*** Test Cases ***
01. Open NGCA App
    [Tags]   Open
    Open Ngca App
    Sleep    2 seconds

02. Wait For Page to load and view
    [Tags]   Step 1
    Sleep    2 seconds

03. Click Next Button
    [Tags]   Step 2
    Click Next Button at onboarding page
    Sleep    2 seconds

04. Click Next Button
    [Tags]   Step 3
    Click Next Button at onboarding page
    Sleep    2 seconds

05. Click Unlock Button
    [Tags]   Step 4
    Click Unlock Button
    Sleep    3 seconds

06. Click on Logged Via SSO previuosly? Click here button
    [Tags]   Step 5
    Click SSO Button
    Sleep    1 seconds

07. Login with continue with email
    [Tags]   Step 6
    Click Continue with email
    Sleep    1 seconds

08. Input email ID
    [Tags]   Step 7
    Insert Email ID Into Input Box    ngca1880@gmail.com
    Sleep    2 seconds
    # U can input or changes email ID beside the input box     

09. Input password ID
    [Tags]   Step 8
    Insert password ID Into Input Box    Ngca@1234
    Sleep    2 seconds
    # U can input or changes Password ID beside the input box    

10. Click submit and go to apps dashboard
    [Tags]   Step 9
    Click Submit Login With Email
    Sleep    3 seconds

11. Wait For Page to load and view the dashboard for all the item
    [Tags]   Step 10
    Sleep    20 seconds     

12. Click service tab to go to all service page
    [Tags]   Step 11
    Click Service Tab Button On Dashboard
    Sleep    5 seconds    

13. Apps scroll down until it find the reload for others button and click on it 
    [Tags]   Step 12
    Scroll Until Reload for others Is Visible and click on it
    Sleep    5 seconds     

14. Input others MSISDN to mobile number box
    [Tags]   Step 13
    Insert Others MSISDN Into Number Box  0104369439
    Sleep    5 seconds         

15. Click next button in Reload others page
    [Tags]   Step 14
    Click Next Button Reload Others
    Sleep    10 seconds  

16. Select a Reload option
    [Tags]   Step 15
    Click Reload Amount With Scroll    RM 30
    Sleep    5 seconds

    # please use the following for reload amount : RM 5, RM 10, RM 30, RM 50, RM 100     

17. Reload page Next Button
    [Tags]   Step 15
    Click Reload Next button
    Sleep    5 seconds    

18. Select Payment method
    [Tags]   Step 17
    Click Payment Method    Credit Card
    Sleep    5 seconds  

     # please put the following into test cases to choose payment method : Credit Card, Online Banking, e-Wallet    

19. Switch ON the email me my receipt toggle
    [Tags]   Step 18
    Turn Switch On If Off
    Sleep    5 seconds   

20. Click Next button at Payment method page 
    [Tags]   Step 19
    Click Reload Next button
    Sleep    5 seconds   

21. Click Next button at credit card summary transaction page  
    [Tags]   Step 20
    Click Next Button at card summary transaction
    Sleep    10 seconds       

22. Click on + Icon to get the payment details    
    [Tags]   Step 20
    Click Plus button
    Sleep    5 seconds   

23. Click get the payment ID details and store it for OTP    
    [Tags]   Step 21
    Store Payment ID
    Log    ✅ Stored Payment ID: ${payment_id}
    Should Not Be Empty    ${payment_id}    Payment ID was not found on screen!
    Sleep    5 seconds  

25. Wait For Page to load and view
    [Tags]   Step 23
    Sleep    5 seconds            

26. Insert card names at card details page
    [Tags]   Step 24
    Insert Card Names     NGCA Test Card
    Sleep    5 seconds       

27. Insert card numbers at card details page
    [Tags]   Step 25
    Insert Card Numbers     4506186581373246
    Sleep    5 seconds  

28. Insert CVV numbers at card details page
    [Tags]   Step 26
    Insert CVV Numbers     123
    Sleep    5 seconds     

29. Click Expiry Date Month box
    [Tags]   Step 27
    Click Month Expiry date dropdown 
    Sleep    5 seconds    

30. Scrolls expiry date month and select month december
    [Tags]   Step 28
    Scroll month expiry date and select the month 
    Sleep    5 seconds      

31. Click Expiry Date Years box
    [Tags]   Step 29
    Click Years Expiry date dropdown  
    Sleep    5 seconds    

32. Scrolls expiry date Years and select Year 2028
    [Tags]   Step 30
    Scroll Years expiry date and select the years 
    Sleep    5 seconds    

33. Click on bank box
    [Tags]   Step 31
    Click Bank Selection dropdown   
    Sleep    5 seconds       

34. Select Maybank
    [Tags]   Step 32
    Scroll Bank and select Maybank   
    Sleep    5 seconds 

35. Agree with Terms and condition 
    [Tags]   Step 33
    Tap T&C Checkbox   
    Sleep    5 seconds            

36. Click proceed and go to OTP pages
    [Tags]   Step 34
    Click on proceed button on credit card details   
    Sleep    5 seconds     

37. Wait For Page to load and view
    [Tags]   Step 35
    Sleep    10 seconds   

38. OTP Page
    Open New Browser
    TAC Page
    Sleep    5 seconds 
39. Insert OTP code 
    [Tags]   Step 35
    Insert OTP into the msos code    ${otp_code}
    Sleep    3 seconds 
40. Click submit button 
    [Tags]   Step 35
    Click submit button on OTP page
    Sleep    3 seconds 
















