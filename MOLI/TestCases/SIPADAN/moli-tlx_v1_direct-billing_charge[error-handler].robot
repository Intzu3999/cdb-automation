*** Settings ***
Documentation    This file to store test cases SIPADAN FEATURES only

# Resource    ../MOLI-testSettings.robot
# Resource    ../../TestKeywords/moli-sipadan-keywords.robot
Resource    ../../TestKeywords/all_keywords.robot

*** Test Cases ***

#     [Documentation]    
# ...    Ticket: https://celcomdigi.atlassian.net/browse/MOLI-2113
# ...    API: [gateway/tlx/error-handler] map error message requestError
# ...    Apidog: https://app.apidog.com/link/project/696426/apis/api-11709250    Env:[moli-staging-uat]
# ...    Postman: https://digi-devops.postman.co/workspace/MOLI~d27d9e6a-6183-43fc-814c-c66688a09b8e/request/25208997-c299c5f3-8220-4d73-85a0-071b277f10e0?action=share&source=copy-link&creator=47340208&ctx=documentation    Env:[moli-staging2-ngsa] 
# ...    POST 'https://d1dvzfm7v42b0o.cloudfront.net/moli-tlx/v1/direct-billing/charge'

# ...    Description:    
# ...    The Charge Payment API allows CelcomDigi customers to process payments for their mobile services. 
# ...    By providing the customer's MSISDN, operator ID, and payment details, this API facilitates the charging of a specified amount. 
# ...    The response includes the status of the transaction, along with reference codes for tracking the payment through different channels and partners. 
# ...    This ensures a seamless and efficient payment experience for the customer, enhancing the overall service management.

# ...    Notes:    
# ...    - `msisdn`, `referenceCode`, `channel`, `payment.amount`, `payment.description` are mandatory

TC01 : Post Charge Direct Billing TLX with valid subscriber (Charge amount exceeded)[Digi]   
    ${accessToken}=    Get Access Token NGSA MOLI UAT
    ${payment}=    Create Dictionary    amount=900.00    description=Policy Street - TP
    ${chargeDirectBillingTLXResponse}    ${status_code}=    Post Charge Direct Billing TLX    ${accessToken}    phoneNo=60100009769    payment=${payment}

TC02 : Post Charge Direct Billing TLX with valid subscriber(Duplicate referenceCode)[Celcom]   
    ${accessToken}=    Get Access Token NGSA MOLI UAT
    ${payment}=    Create Dictionary    amount=4.00    description=Policy Street - TP
    ${channel}=    Set Variable    PS250821ACE20D66A3E1
    ${chargeDirectBillingTLXResponse}    ${status_code}=    Post Charge Direct Billing TLX    ${accessToken}    phoneNo=60148956179    channel=${channel}    payment=${payment}
    Should Be Equal As Strings    ${status_code}    400

TC03 : Post Charge Direct Billing TLX with valid subscriber(Insufficient balance)[Celcom]   
    ${accessToken}=    Get Access Token NGSA MOLI UAT
    ${payment}=    Create Dictionary    amount=4.00    description=Policy Street - TP
    ${chargeDirectBillingTLXResponse}    ${status_code}=    Post Charge Direct Billing TLX    ${accessToken}    phoneNo=60198456113    payment=${payment}
    Should Be Equal As Strings    ${status_code}    403
