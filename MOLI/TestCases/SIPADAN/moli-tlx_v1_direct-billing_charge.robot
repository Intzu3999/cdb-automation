*** Settings ***
Documentation    This file to store test cases SIPADAN FEATURES only

# Resource    ../MOLI-testSettings.robot
# Resource    ../../TestKeywords/moli-sipadan-keywords.robot
Resource    ../../TestKeywords/all_keywords.robot

*** Test Cases ***

*** Test Cases ***

#     [Documentation]    
# ...    Ticket: https://celcomdigi.atlassian.net/browse/MOLI-2202
# ...    API: [tlx/charge-payment] map new request parameter chargingMetadata
# ...    Apidog: https://app.apidog.com/link/project/696426/apis/api-11709250    Env:[moli-staging-uat]
# ...    Postman:    Env:[moli-staging2-ngsa] 
# ...    POST 'https://d1dvzfm7v42b0o.cloudfront.net/moli-tlx/v1/direct-billing/charge'

# ...    Description:    
# ...    The Charge Payment API allows CelcomDigi customers to process payments for their mobile services. 
# ...    By providing the customer's MSISDN, operator ID, and payment details, this API facilitates the charging of a specified amount. 
# ...    The response includes the status of the transaction, along with reference codes for tracking the payment through different channels and partners. 
# ...    This ensures a seamless and efficient payment experience for the customer, enhancing the overall service management.

# ...    Notes:    
# ...    - `msisdn`, `referenceCode`, `channel`, `payment.amount`, `payment.description` are mandatory

TC01 : Post Charge Direct Billing TLX with valid subscriber(Prepaid)[Digi]   
    ${accessToken}=    Get Access Token NGSA MOLI UAT
    ${payment}=    Create Dictionary    amount=4.00    description=Policy Street - TP
    ${metadata}=    Create Dictionary    purchaseCategoryCode=Domestic    serviceId=policyStreet
    ${chargeDirectBillingTLXResponse}    ${status_code}=    Post Charge Direct Billing TLX    ${accessToken}    phoneNo=${BAU_DIGI_PREPAID_MSISDN_TLX}    payment=${payment}    metadata=${metadata} 
    Should Be Equal As Strings    ${status_code}    200

TC02 : Post Charge Direct Billing TLX with valid subscriber(Prepaid)[Celcom]   
    ${accessToken}=    Get Access Token NGSA MOLI UAT
    ${payment}=    Create Dictionary    amount=4.50    description=Policy Street - TP
    ${metadata}=    Create Dictionary    purchaseCategoryCode=Domestic    serviceId=policyStreet
    ${chargeDirectBillingTLXResponse}    ${status_code}=    Post Charge Direct Billing TLX    ${accessToken}    phoneNo=${BAU_CELCOM_PREPAID_MSISDN_TLX}    payment=${payment}    metadata=${metadata} 
    Should Be Equal As Strings    ${status_code}    200

TC03 : Post Charge Direct Billing TLX with valid subscriber(Postpaid)[Digi]   
    ${accessToken}=    Get Access Token NGSA MOLI UAT
    ${payment}=    Create Dictionary    amount=3.00    description=Policy Street - TP
    ${metadata}=    Create Dictionary    purchaseCategoryCode=Domestic    serviceId=policyStreet
    ${chargeDirectBillingTLXResponse}    ${status_code}=    Post Charge Direct Billing TLX    ${accessToken}    phoneNo=${BAU_DIGI_POSTPAID_MSISDN_TLX}    payment=${payment}    metadata=${metadata} 
    Should Be Equal As Strings    ${status_code}    200

TC04 : Post Charge Direct Billing TLX with valid subscriber(Postpaid)[Celcom]   
    ${accessToken}=    Get Access Token NGSA MOLI UAT
    ${payment}=    Create Dictionary    amount=3.50    description=Policy Street - TP
    ${metadata}=    Create Dictionary    purchaseCategoryCode=Domestic    serviceId=policyStreet
    ${chargeDirectBillingTLXResponse}    ${status_code}=    Post Charge Direct Billing TLX    ${accessToken}    phoneNo=${BAU_CELCOM_POSTPAID_MSISDN_TLX}    payment=${payment}    metadata=${metadata}
    Should Be Equal As Strings    ${status_code}    200

TC05 : Post Charge Direct Billing TLX with invalid subscriber[non CelcomDigi]
    ${accessToken}=    Get Access Token NGSA MOLI UAT
    ${payment}=    Create Dictionary    amount=3.50    description=Policy Street - TP
    ${metadata}=    Create Dictionary    purchaseCategoryCode=Domestic    serviceId=policyStreet
    ${chargeDirectBillingTLXResponse}    ${status_code}=    Post Charge Direct Billing TLX    ${accessToken}    phoneNo=${BAU_MAXIS_POSTPAID_MSISDN}    payment=${payment}    metadata=${metadata}
    Should Be Equal As Strings    ${status_code}    404

TC06 : Post Charge Direct Billing TLX without mandatory parameter (msisdn, referenceCode.channel, payment.amount, payment.description)
    ${accessToken}=    Get Access Token NGSA MOLI UAT
    ${channel}=    Set Variable    ANYVALUE
    ${metadata}=    Create Dictionary    purchaseCategoryCode=Domestic    serviceId=policyStreet
    ${chargeDirectBillingTLXResponse}    ${status_code}=    Post Charge Direct Billing TLX    ${accessToken}    channel=${channel}    metadata=${metadata}
    Should Be Equal As Strings    ${status_code}    422

TC07 : Post Charge Direct Billing TLX without optional parameter(metadata.purchaseCategoryCode, metadata.serviceId)
    ${accessToken}=    Get Access Token NGSA MOLI UAT
    ${payment}=    Create Dictionary    amount=3.50    description=Policy Street - TP
    ${chargeDirectBillingTLXResponse}    ${status_code}=    Post Charge Direct Billing TLX    ${accessToken}    phoneNo=${BAU_CELCOM_POSTPAID_MSISDN_TLX}    payment=${payment}
    Should Be Equal As Strings    ${status_code}    200

TC08 : Post Charge Direct Billing TLX without request body
    ${accessToken}=    Get Access Token NGSA MOLI UAT
    ${channel}=    Set Variable    ANYVALUE
    ${chargeDirectBillingTLXResponse}    ${status_code}=    Post Charge Direct Billing TLX    ${accessToken}    channel=${channel} 
    Should Be Equal As Strings    ${status_code}    422

TC09 : Post Charge Direct Billing TLX with empty string
    ${accessToken}=    Get Access Token NGSA MOLI UAT
    ${payment}=    Create Dictionary    amount=${EMPTY}   description=${EMPTY}
    ${channel}=    Set Variable    ${EMPTY}
    ${metadata}=    Create Dictionary    purchaseCategoryCode=${EMPTY}    serviceId=${EMPTY}
    ${chargeDirectBillingTLXResponse}    ${status_code}=    Post Charge Direct Billing TLX    ${accessToken}    phoneNo=${EMPTY}    channel=${channel}    payment=${payment}    metadata=${metadata}
    Should Be Equal As Strings    ${status_code}    422

TC10 : Post Charge Direct Billing TLX with invalid msisdn (invalid service number-incorrect format & less than 10 char)
    ${accessToken}=    Get Access Token NGSA MOLI UAT
    ${payment}=    Create Dictionary    amount=4.00    description=Policy Street - TP
    ${metadata}=    Create Dictionary    purchaseCategoryCode=Domestic    serviceId=policyStreet
    ${chargeDirectBillingTLXResponse}    ${status_code}=    Post Charge Direct Billing TLX    ${accessToken}    phoneNo=${INVALID_FORMAT_MSISDN_SHORT}    payment=${payment}    metadata=${metadata} 
    Should Be Equal As Strings    ${status_code}    422

TC11 : Post Charge Direct Billing TLX with invalid msisdn (invalid service number-incorrect format & more than 12 char)
    ${accessToken}=    Get Access Token NGSA MOLI UAT
    ${payment}=    Create Dictionary    amount=4.00    description=Policy Street - TP
    ${metadata}=    Create Dictionary    purchaseCategoryCode=Domestic    serviceId=policyStreet
    ${chargeDirectBillingTLXResponse}    ${status_code}=    Post Charge Direct Billing TLX    ${accessToken}    phoneNo=${INVALID_FORMAT_MSISDN_LONG}    payment=${payment}    metadata=${metadata} 
    Should Be Equal As Strings    ${status_code}    422

TC12 : Post Charge Direct Billing TLX with invalid msisdn (invalid service number-incorrect format)
    ${accessToken}=    Get Access Token NGSA MOLI UAT
    ${payment}=    Create Dictionary    amount=4.00    description=Policy Street - TP
    ${metadata}=    Create Dictionary    purchaseCategoryCode=Domestic    serviceId=policyStreet
    ${chargeDirectBillingTLXResponse}    ${status_code}=    Post Charge Direct Billing TLX    ${accessToken}    phoneNo=${INVALID_FORMAT}    payment=${payment}    metadata=${metadata} 
    Should Be Equal As Strings    ${status_code}    422

TC13 : Post Charge Direct Billing TLX with invalid msisdn (less than 10 char)
    ${accessToken}=    Get Access Token NGSA MOLI UAT
    ${payment}=    Create Dictionary    amount=4.00    description=Policy Street - TP
    ${metadata}=    Create Dictionary    purchaseCategoryCode=Domestic    serviceId=policyStreet
    ${chargeDirectBillingTLXResponse}    ${status_code}=    Post Charge Direct Billing TLX    ${accessToken}    phoneNo=${INVALID_MSISDN_SHORT}    payment=${payment}    metadata=${metadata} 
    Should Be Equal As Strings    ${status_code}    422

TC14 : Post Charge Direct Billing TLX with invalid msisdn (more than 12 char)
    ${accessToken}=    Get Access Token NGSA MOLI UAT
    ${payment}=    Create Dictionary    amount=4.00    description=Policy Street - TP
    ${metadata}=    Create Dictionary    purchaseCategoryCode=Domestic    serviceId=policyStreet
    ${chargeDirectBillingTLXResponse}    ${status_code}=    Post Charge Direct Billing TLX    ${accessToken}    phoneNo=${INVALID_MSISDN_LONG}    payment=${payment}    metadata=${metadata} 
    Should Be Equal As Strings    ${status_code}    422

TC15 : Post Charge Direct Billing TLX with invalid referenceId (incorrect format-exceeding 64 char)[Digi]
    ${accessToken}=    Get Access Token NGSA MOLI UAT
    ${payment}=    Create Dictionary    amount=4.00    description=Policy Street - TP
    ${channel}=    Set Variable    ${INVALID_LONG}
    ${metadata}=    Create Dictionary    purchaseCategoryCode=Domestic    serviceId=policyStreet
    ${chargeDirectBillingTLXResponse}    ${status_code}=    Post Charge Direct Billing TLX    ${accessToken}    phoneNo=${BAU_DIGI_POSTPAID_MSISDN_TLX}    channel=${channel}    payment=${payment}    metadata=${metadata} 
    Should Be Equal As Strings    ${status_code}    400    #no validation value, validation length(max)

TC16 : Post Charge Direct Billing TLX with invalid referenceId (incorrect format-exceeding 64 char)[Celcom]
    ${accessToken}=    Get Access Token NGSA MOLI UAT
    ${payment}=    Create Dictionary    amount=4.00    description=Policy Street - TP
    ${channel}=    Set Variable    ${INVALID_LONG}
    ${metadata}=    Create Dictionary    purchaseCategoryCode=Domestic    serviceId=policyStreet
    ${chargeDirectBillingTLXResponse}    ${status_code}=    Post Charge Direct Billing TLX    ${accessToken}    phoneNo=${BAU_CELCOM_POSTPAID_MSISDN_TLX}    channel=${channel}    payment=${payment}    metadata=${metadata} 
    Should Be Equal As Strings    ${status_code}    400    #no validation value, validation length(max)

TC17 : Post Charge Direct Billing TLX with invalid referenceId (duplicate-has been exist)[Digi]
    ${accessToken}=    Get Access Token NGSA MOLI UAT
    ${payment}=    Create Dictionary    amount=4.00    description=Policy Street - TP
    ${channel}=    Set Variable    OUQRRZWNKHIF
    ${metadata}=    Create Dictionary    purchaseCategoryCode=Domestic    serviceId=policyStreet
    ${chargeDirectBillingTLXResponse}    ${status_code}=    Post Charge Direct Billing TLX    ${accessToken}    phoneNo=${BAU_DIGI_PREPAID_MSISDN_TLX}    channel=${channel}    payment=${payment}    metadata=${metadata} 
    Should Be Equal As Strings    ${status_code}    400

TC18 : Post Charge Direct Billing TLX with invalid referenceId (duplicate-has been exist)[Celcom]
    ${accessToken}=    Get Access Token NGSA MOLI UAT
    ${payment}=    Create Dictionary    amount=4.00    description=Policy Street - TP
    ${channel}=    Set Variable    UOILPEYCJUIK
    ${metadata}=    Create Dictionary    purchaseCategoryCode=Domestic    serviceId=policyStreet
    ${chargeDirectBillingTLXResponse}    ${status_code}=    Post Charge Direct Billing TLX    ${accessToken}    phoneNo=${BAU_CELCOM_PREPAID_MSISDN_TLX}    channel=${channel}    payment=${payment}    metadata=${metadata} 
    Should Be Equal As Strings    ${status_code}    400

TC19 : Post Charge Direct Billing TLX with invalid amount (incorrect format-negative)[Digi]
    ${accessToken}=    Get Access Token NGSA MOLI UAT
    ${payment}=    Create Dictionary    amount=-4.00    description=Policy Street - TP
    ${metadata}=    Create Dictionary    purchaseCategoryCode=Domestic    serviceId=policyStreet
    ${chargeDirectBillingTLXResponse}    ${status_code}=    Post Charge Direct Billing TLX    ${accessToken}    phoneNo=${BAU_DIGI_PREPAID_MSISDN_TLX}    payment=${payment}    metadata=${metadata} 
    Should Be Equal As Strings    ${status_code}    400

TC20 : Post Charge Direct Billing TLX with invalid amount (incorrect format-negative)[Celcom]
    ${accessToken}=    Get Access Token NGSA MOLI UAT
    ${payment}=    Create Dictionary    amount=-4.00    description=Policy Street - TP
    ${metadata}=    Create Dictionary    purchaseCategoryCode=Domestic    serviceId=policyStreet
    ${chargeDirectBillingTLXResponse}    ${status_code}=    Post Charge Direct Billing TLX    ${accessToken}    phoneNo=${BAU_CELCOM_PREPAID_MSISDN_TLX}    payment=${payment}    metadata=${metadata} 
    Should Be Equal As Strings    ${status_code}    400

TC21 : Post Charge Direct Billing TLX with invalid amount (incorrect format)[Digi]
    ${accessToken}=    Get Access Token NGSA MOLI UAT
    ${payment}=    Create Dictionary    amount=${INVALID_FORMAT}    description=Policy Street - TP
    ${metadata}=    Create Dictionary    purchaseCategoryCode=Domestic    serviceId=policyStreet
    ${chargeDirectBillingTLXResponse}    ${status_code}=    Post Charge Direct Billing TLX    ${accessToken}    phoneNo=${BAU_DIGI_POSTPAID_MSISDN_TLX}    payment=${payment}    metadata=${metadata} 
    Should Be Equal As Strings    ${status_code}    422

TC22 : Post Charge Direct Billing TLX with invalid amount (incorrect format)[Celcom]
    ${accessToken}=    Get Access Token NGSA MOLI UAT
    ${payment}=    Create Dictionary    amount=${INVALID_FORMAT}    description=Policy Street - TP
    ${metadata}=    Create Dictionary    purchaseCategoryCode=Domestic    serviceId=policyStreet
    ${chargeDirectBillingTLXResponse}    ${status_code}=    Post Charge Direct Billing TLX    ${accessToken}    phoneNo=${BAU_CELCOM_POSTPAID_MSISDN_TLX}    payment=${payment}    metadata=${metadata} 
    Should Be Equal As Strings    ${status_code}    422

TC23 : Post Charge Direct Billing TLX with invalid description (invalid description-exceeding 50 char)[Digi]
    ${accessToken}=    Get Access Token NGSA MOLI UAT
    ${payment}=    Create Dictionary    amount=4.00    description=${INVALID_LONG}
    ${metadata}=    Create Dictionary    purchaseCategoryCode=Domestic    serviceId=policyStreet
    ${chargeDirectBillingTLXResponse}    ${status_code}=    Post Charge Direct Billing TLX    ${accessToken}    phoneNo=${BAU_DIGI_POSTPAID_MSISDN_TLX}    payment=${payment}    metadata=${metadata} 
    Should Be Equal As Strings    ${status_code}    200    #no validation value, no validation length

TC24 : Post Charge Direct Billing TLX with invalid description (invalid description-exceeding 50 char)[Celcom]
    ${accessToken}=    Get Access Token NGSA MOLI UAT
    ${payment}=    Create Dictionary    amount=4.00    description=${INVALID_LONG}
    ${metadata}=    Create Dictionary    purchaseCategoryCode=Domestic    serviceId=policyStreet
    ${chargeDirectBillingTLXResponse}    ${status_code}=    Post Charge Direct Billing TLX    ${accessToken}    phoneNo=${BAU_CELCOM_POSTPAID_MSISDN_TLX}    payment=${payment}    metadata=${metadata} 
    Should Be Equal As Strings    ${status_code}    200    #no validation value, no validation length

TC25 : Post Charge Direct Billing TLX with invalid purchaseCategoryCode (invalid purchaseCategoryCode-exceeding 10 char)[Digi]
    ${accessToken}=    Get Access Token NGSA MOLI UAT
    ${payment}=    Create Dictionary    amount=4.00    description=Policy Street - TP
    ${metadata}=    Create Dictionary    purchaseCategoryCode=${INVALID_LONG}    serviceId=policyStreet
    ${chargeDirectBillingTLXResponse}    ${status_code}=    Post Charge Direct Billing TLX    ${accessToken}    phoneNo=${BAU_DIGI_PREPAID_MSISDN_TLX}    payment=${payment}    metadata=${metadata} 
    Should Be Equal As Strings    ${status_code}    200    #no validation value, no validation length

TC26 : Post Charge Direct Billing TLX with invalid purchaseCategoryCode (invalid purchaseCategoryCode-exceeding 10 char)[Celcom]
    ${accessToken}=    Get Access Token NGSA MOLI UAT
    ${payment}=    Create Dictionary    amount=4.00    description=Policy Street - TP
    ${metadata}=    Create Dictionary    purchaseCategoryCode=${INVALID_LONG}    serviceId=policyStreet
    ${chargeDirectBillingTLXResponse}    ${status_code}=    Post Charge Direct Billing TLX    ${accessToken}    phoneNo=${BAU_DIGI_PREPAID_MSISDN_TLX}    payment=${payment}    metadata=${metadata} 
    Should Be Equal As Strings    ${status_code}    200    #no validation value, no validation length

TC27 : Post Charge Direct Billing TLX with invalid serviceId[Digi]
    ${accessToken}=    Get Access Token NGSA MOLI UAT
    ${payment}=    Create Dictionary    amount=4.00    description=Policy Street - TP
    ${metadata}=    Create Dictionary    purchaseCategoryCode=Domestic    serviceId=${INVALID_SHORT}
    ${chargeDirectBillingTLXResponse}    ${status_code}=    Post Charge Direct Billing TLX    ${accessToken}    phoneNo=${BAU_DIGI_POSTPAID_MSISDN_TLX}    payment=${payment}    metadata=${metadata} 
    Should Be Equal As Strings    ${status_code}    400    #validation value, no validation length

TC28 : Post Charge Direct Billing TLX with invalid serviceId[Celcom]
    ${accessToken}=    Get Access Token NGSA MOLI UAT
    ${payment}=    Create Dictionary    amount=4.00    description=Policy Street - TP
    ${metadata}=    Create Dictionary    purchaseCategoryCode=Domestic    serviceId=${INVALID_SHORT}
    ${chargeDirectBillingTLXResponse}    ${status_code}=    Post Charge Direct Billing TLX    ${accessToken}    phoneNo=${BAU_CELCOM_POSTPAID_MSISDN_TLX}    payment=${payment}    metadata=${metadata} 
    Should Be Equal As Strings    ${status_code}    400    #validation value, no validation length

TC29 : Post Charge Direct Billing TLX with Barred subscriber[Digi]
    ${accessToken}=    Get Access Token NGSA MOLI UAT
    ${payment}=    Create Dictionary    amount=4.00    description=Policy Street - TP
    ${metadata}=    Create Dictionary    purchaseCategoryCode=Domestic    serviceId=policyStreet
    ${chargeDirectBillingTLXResponse}    ${status_code}=    Post Charge Direct Billing TLX    ${accessToken}    phoneNo=${BAU_DIGI_PREPAID_MSISDN_TLX_BARRED}    payment=${payment}    metadata=${metadata} 
    Should Be Equal As Strings    ${status_code}    400

# TC30 : Post Charge Direct Billing TLX with Barred subscriber[Celcom]
#     ${accessToken}=    Get Access Token NGSA MOLI UAT
#     ${payment}=    Create Dictionary    amount=4.00    description=Policy Street - TP
#     ${metadata}=    Create Dictionary    purchaseCategoryCode=Domestic    serviceId=policyStreet
#    ${chargeDirectBillingTLXResponse}    ${status_code}=    Post Charge Direct Billing TLX    ${accessToken}    phoneNo=${BAU_CELCOM_PREPAID_MSISDN_TLX_BARRED}   payment=${payment}    metadata=${metadata} 
#     Should Be Equal As Strings    ${status_code}    400

# TC31 : Post Charge Direct Billing TLX with Suspended subscriber[Digi]
#     ${accessToken}=    Get Access Token NGSA MOLI UAT
#     ${payment}=    Create Dictionary    amount=4.00    description=Policy Street - TP
#     ${metadata}=    Create Dictionary    purchaseCategoryCode=Domestic    serviceId=policyStreet
#     ${chargeDirectBillingTLXResponse}    ${status_code}=    Post Charge Direct Billing TLX    ${accessToken}    phoneNo=${BAU_DIGI_PREPAID_MSISDN_TLX_SUSPENDED}    payment=${payment}    metadata=${metadata} 
#     Should Be Equal As Strings    ${status_code}    400

# TC32 : Post Charge Direct Billing TLX with Suspended subscriber[Celcom]
#     ${accessToken}=    Get Access Token NGSA MOLI UAT
#     ${payment}=    Create Dictionary    amount=4.00    description=Policy Street - TP
#     ${metadata}=    Create Dictionary    purchaseCategoryCode=Domestic    serviceId=policyStreet
#     ${chargeDirectBillingTLXResponse}    ${status_code}=    Post Charge Direct Billing TLX    ${accessToken}    phoneNo=${BAU_CELCOM_PREPAID_MSISDN_TLX_SUSPENDED}    payment=${payment}    metadata=${metadata} 
#     Should Be Equal As Strings    ${status_code}    400

# TC33 : Post Charge Direct Billing TLX with Terminated subscriber[Digi]
#     ${accessToken}=    Get Access Token NGSA MOLI UAT
#     ${payment}=    Create Dictionary    amount=4.00    description=Policy Street - TP
#     ${metadata}=    Create Dictionary    purchaseCategoryCode=Domestic    serviceId=policyStreet
#     ${chargeDirectBillingTLXResponse}    ${status_code}=    Post Charge Direct Billing TLX    ${accessToken}    phoneNo=${BAU_DIGI_PREPAID_MSISDN_TLX_TERMINATED}    payment=${payment}    metadata=${metadata} 
#     Should Be Equal As Strings    ${status_code}    400

# TC34 : Post Charge Direct Billing TLX with Terminated subscriber[Celcom]
#     ${accessToken}=    Get Access Token NGSA MOLI UAT
#     ${payment}=    Create Dictionary    amount=4.00    description=Policy Street - TP
#     ${metadata}=    Create Dictionary    purchaseCategoryCode=Domestic    serviceId=policyStreet
#     ${chargeDirectBillingTLXResponse}    ${status_code}=    Post Charge Direct Billing TLX    ${accessToken}    phoneNo=${BAU_CELCOM_PREPAID_MSISDN_TLX_TERMINATED}    payment=${payment}    metadata=${metadata} 
#     Should Be Equal As Strings    ${status_code}    400

# TC35 : Post Charge Direct Billing TLX with Unsufficient Balance subscriber[Digi]
#     ${accessToken}=    Get Access Token NGSA MOLI UAT
#     ${payment}=    Create Dictionary    amount=4.00    description=Policy Street - TP
#     ${metadata}=    Create Dictionary    purchaseCategoryCode=Domestic    serviceId=policyStreet
#     ${chargeDirectBillingTLXResponse}    ${status_code}=    Post Charge Direct Billing TLX    ${accessToken}    phoneNo=${BAU_DIGI_PREPAID_CHARGE_DIRECT_BILLING_INSUFFICIENT}    payment=${payment}    metadata=${metadata} 
#     Should Be Equal As Strings    ${status_code}    400

# TC36 : Post Charge Direct Billing TLX with Unsufficient Balance subscriber[Celcom]
#     ${accessToken}=    Get Access Token NGSA MOLI UAT
#     ${payment}=    Create Dictionary    amount=4.00    description=Policy Street - TP
#     ${metadata}=    Create Dictionary    purchaseCategoryCode=Domestic    serviceId=policyStreet
#     ${chargeDirectBillingTLXResponse}    ${status_code}=    Post Charge Direct Billing TLX    ${accessToken}    phoneNo=${BAU_CELCOM_PREPAID_CHARGE_DIRECT_BILLING_INSUFFICIENT}    payment=${payment}    metadata=${metadata} 
#     Should Be Equal As Strings    ${status_code}    400


# exceeding credit limit
# //API Fail
# {
#   "requestError": {
#     "serviceException": {
#       "variables": [
#         "Country 60 is not configured for moli policyStreet"
#       ],
#       "messageId": "SVC0002",
#       "text": "Invalid input value for message part %1"
#     }
#   }
# }

# //barred user 60198456609
# {
#   "error": "GatewayError",
#   "service": "GatewayForTLX",
#   "message": "Fail response from gateway",
#   "source": {
#     "code": "POL2003",
#     "description": "Request failed with status code 403",
#     "reason": "A policy error occurred. Error code is %1.",
#     "details": "BARRED_USER"
#   }
# }

# //success without metadata - covered in TC07
# //success with metadata - covered in TC01-TC04
# //duplicate referenceCode - covered in TC17
