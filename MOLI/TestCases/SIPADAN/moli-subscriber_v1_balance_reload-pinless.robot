*** Settings ***
Documentation    This file to store test cases SIPADAN FEATURES only

# Resource    ../MOLI-testSettings.robot
# Resource    ../../TestKeywords/moli-sipadan-keywords.robot
Resource    ../../TestKeywords/all_keywords.robot

*** Test Cases ***

#     [Documentation]    
# ...    Ticket: https://celcomdigi.atlassian.net/browse/MOLI-2127
# ...    API: [subscriber/reload-pinless] add new request parameter referenceId
# ...    Apidog: https://app.apidog.com/link/project/652757/apis/api-10408836?branchId=1063929    Env:[moli-staging-uat]
# ...    Postman: https://digi-devops.postman.co/workspace/MOLI~d27d9e6a-6183-43fc-814c-c66688a09b8e/request/19640659-6ad20a96-ec32-4c2c-9d0c-691547ce532f?action=share&source=copy-link&creator=47340208&ctx=documentation    Env:[moli-staging2-ngsa] 
# ...    POST 'https://d1dvzfm7v42b0o.cloudfront.net/moli-subscriber/v1/balance/reload-pinless

# ...    Description:    
# ...    This API function is to validate a reload PIN for a subscriber's prepaid account.
# ...    This endpoint ensures that the provided PIN is correct and can be used to top-up subscribers account.
# ...    This allows for topping up the account without the need for a physical PIN, streamlining the recharge process.

# ...    Notes:    
# ...    - `msisdn`, `referenceCode`, `channel`, `payment.amount`, `payment.description` are mandatory

TC01 : Post Reload Pinless with valid subscriber[Digi]   
    ${accessToken}=    Get Access Token BAU
    ${prepaidReloadPinless}    ${status_code}=    Post Prepaid Pinless Reload    ${accessToken}    phoneNo=${BAU_DIGI_PREPAID_MSISDN}    paymentAmount=5.00   paymentMethod=OnlineBanking    sourceChannel=223
    Should Be Equal As Strings    ${status_code}    200

TC02 : Post Reload Pinless with valid subscriber[Celcom]   
    ${accessToken}=    Get Access Token BAU
    ${prepaidReloadPinless}    ${status_code}=    Post Prepaid Pinless Reload    ${accessToken}    phoneNo=${BAU_CELCOM_PREPAID_MSISDN}    paymentAmount=5.00   paymentMethod=OnlineBanking    sourceChannel=223
    Should Be Equal As Strings    ${status_code}    200

TC03 : Post Reload Pinless with invalid subscriber[non CelcomDigi]   
    ${accessToken}=    Get Access Token BAU
    ${prepaidReloadPinless}    ${status_code}=    Post Prepaid Pinless Reload    ${accessToken}    phoneNo=${BAU_MAXIS_PREPAID_MSISDN}    paymentAmount=5.00   paymentMethod=OnlineBanking    sourceChannel=223
    Should Be Equal As Strings    ${status_code}    400

TC04 : Post Reload Pinless without mandatory parameter(msisdn) 
    ${accessToken}=    Get Access Token BAU
    ${prepaidReloadPinless}    ${status_code}=    Post Prepaid Pinless Reload    ${accessToken}    paymentAmount=5.00   paymentMethod=OnlineBanking    sourceChannel=223
    Should Be Equal As Strings    ${status_code}    422

TC05 : Post Reload Pinless without conditional mandatory parameter(paymentMethod, paymentAmount, sourceChannel) 
    ${accessToken}=    Get Access Token BAU
    ${prepaidReloadPinless}    ${status_code}=    Post Prepaid Pinless Reload    ${accessToken}    phoneNo=${BAU_DIGI_PREPAID_MSISDN}
    Should Be Equal As Strings    ${status_code}    422

TC06 : Post Reload Pinless without optional parameter(referenceId) 
    ${accessToken}=    Get Access Token BAU
    ${prepaidReloadPinless}    ${status_code}=    Post Prepaid Pinless Reload    ${accessToken}    phoneNo=${BAU_CELCOM_PREPAID_MSISDN}    paymentAmount=5.00   paymentMethod=OnlineBanking    sourceChannel=223    referenceId=ANYVALUE
    Should Be Equal As Strings    ${status_code}    200

TC07 : Post Reload Pinless without request body
    ${accessToken}=    Get Access Token BAU
    ${prepaidReloadPinless}    ${status_code}=    Post Prepaid Pinless Reload    ${accessToken}    referenceId=ANYVALUE
    Should Be Equal As Strings    ${status_code}    422    

TC08 : Post Reload Pinless with empty string   
    ${accessToken}=    Get Access Token BAU
    ${prepaidReloadPinless}    ${status_code}=    Post Prepaid Pinless Reload    ${accessToken}    phoneNo=${EMPTY}    paymentAmount=${EMPTY}   paymentMethod=${EMPTY}    sourceChannel=${EMPTY}    referenceId=${EMPTY}
    Should Be Equal As Strings    ${status_code}    422

TC09 : Post Reload Pinless with invalid msisdn (invalid service number-incorrect format & less than 10 char)
    ${accessToken}=    Get Access Token BAU
    ${prepaidReloadPinless}    ${status_code}=    Post Prepaid Pinless Reload    ${accessToken}    phoneNo=${INVALID_FORMAT_MSISDN_SHORT}    paymentAmount=5.00   paymentMethod=OnlineBanking    sourceChannel=223
    Should Be Equal As Strings    ${status_code}    422    #validation format, validation length(min)

TC10 : Post Reload Pinless with invalid msisdn (invalid service number-incorrect format & more than 12 char)
    ${accessToken}=    Get Access Token BAU
    ${prepaidReloadPinless}    ${status_code}=    Post Prepaid Pinless Reload    ${accessToken}    phoneNo=${INVALID_FORMAT_MSISDN_LONG}    paymentAmount=5.00   paymentMethod=OnlineBanking    sourceChannel=223
    Should Be Equal As Strings    ${status_code}    422    #validation format, validation length(max)

TC11 : Post Reload Pinless with invalid msisdn (invalid service number-incorrect format)
    ${accessToken}=    Get Access Token BAU
    ${prepaidReloadPinless}    ${status_code}=    Post Prepaid Pinless Reload    ${accessToken}    phoneNo=${INVALID_FORMAT}    paymentAmount=5.00   paymentMethod=OnlineBanking    sourceChannel=223
    Should Be Equal As Strings    ${status_code}    422    #validation format

TC12 : Post Reload Pinless with invalid msisdn (invalid service number-less than 10 char)
    ${accessToken}=    Get Access Token BAU
    ${prepaidReloadPinless}    ${status_code}=    Post Prepaid Pinless Reload    ${accessToken}    phoneNo=${INVALID_MSISDN_SHORT}    paymentAmount=5.00   paymentMethod=OnlineBanking    sourceChannel=223
    Should Be Equal As Strings    ${status_code}    422    #validation length(min)

TC13 : Post Reload Pinless with invalid msisdn (invalid service number-more than 12 char)
    ${accessToken}=    Get Access Token BAU
    ${prepaidReloadPinless}    ${status_code}=    Post Prepaid Pinless Reload    ${accessToken}    phoneNo=${INVALID_MSISDN_LONG}    paymentAmount=5.00   paymentMethod=OnlineBanking    sourceChannel=223
    Should Be Equal As Strings    ${status_code}    422    #validation length(max)

TC14 : Post Reload Pinless with invalid paymentMethod (incorrect format)[Digi]
    ${accessToken}=    Get Access Token BAU
    ${prepaidReloadPinless}    ${status_code}=    Post Prepaid Pinless Reload    ${accessToken}    phoneNo=${BAU_DIGI_PREPAID_MSISDN}    paymentAmount=5.00   paymentMethod=${INVALID_SHORT}    sourceChannel=223
    Should Be Equal As Strings    ${status_code}    422    #validation format

TC15 : Post Reload Pinless with invalid paymentMethod (incorrect format)[Celcom]
    ${accessToken}=    Get Access Token BAU
    ${prepaidReloadPinless}    ${status_code}=    Post Prepaid Pinless Reload    ${accessToken}    phoneNo=${BAU_DIGI_PREPAID_MSISDN}    paymentAmount=5.00   paymentMethod=${INVALID_LONG}    sourceChannel=223
    Should Be Equal As Strings    ${status_code}    422    #validation format

TC16 : Post Reload Pinless with invalid amount (incorrect format-negative)[Digi]
    ${accessToken}=    Get Access Token BAU
    ${prepaidReloadPinless}    ${status_code}=    Post Prepaid Pinless Reload    ${accessToken}    phoneNo=${BAU_DIGI_PREPAID_MSISDN}    paymentAmount=-5.00   paymentMethod=OnlineBanking    sourceChannel=223
    Should Be Equal As Strings    ${status_code}    500

TC17 : Post Reload Pinless with invalid amount (incorrect format-negative)[Celcom]
    ${accessToken}=    Get Access Token BAU
    ${prepaidReloadPinless}    ${status_code}=    Post Prepaid Pinless Reload    ${accessToken}    phoneNo=${BAU_CELCOM_PREPAID_MSISDN}    paymentAmount=-5.00   paymentMethod=OnlineBanking    sourceChannel=223
    Should Be Equal As Strings    ${status_code}    500

TC18 : Post Reload Pinless with invalid amount (incorrect format)[Digi]
    ${accessToken}=    Get Access Token BAU
    ${prepaidReloadPinless}    ${status_code}=    Post Prepaid Pinless Reload    ${accessToken}    phoneNo=${BAU_DIGI_PREPAID_MSISDN}    paymentAmount=${INVALID_FORMAT}   paymentMethod=OnlineBanking    sourceChannel=223
    Should Be Equal As Strings    ${status_code}    422

TC19 : Post Reload Pinless with invalid amount (incorrect format)[Celcom]
    ${accessToken}=    Get Access Token BAU
    ${prepaidReloadPinless}    ${status_code}=    Post Prepaid Pinless Reload    ${accessToken}    phoneNo=${BAU_CELCOM_PREPAID_MSISDN}    paymentAmount=${INVALID_FORMAT}   paymentMethod=OnlineBanking    sourceChannel=223
    Should Be Equal As Strings    ${status_code}    422

TC20 : Post Reload Pinless with invalid sourceChannel[Digi]
    ${accessToken}=    Get Access Token BAU
    ${prepaidReloadPinless}    ${status_code}=    Post Prepaid Pinless Reload    ${accessToken}    phoneNo=${BAU_DIGI_PREPAID_MSISDN}    paymentAmount=5.00   paymentMethod=OnlineBanking    sourceChannel=${INVALID_SHORT}
    Should Be Equal As Strings    ${status_code}    200    #no validation

TC21 : Post Reload Pinless with invalid sourceChannel[Celcom]
    ${accessToken}=    Get Access Token BAU
    ${prepaidReloadPinless}    ${status_code}=    Post Prepaid Pinless Reload    ${accessToken}    phoneNo=${BAU_CELCOM_PREPAID_MSISDN}    paymentAmount=5.00   paymentMethod=OnlineBanking    sourceChannel=${INVALID_SHORT}
    Should Be Equal As Strings    ${status_code}    200    #no validation

TC22 : Post Reload Pinless with invalid sourceChannel (invalid sourceChannel-more than 10 char)[Digi]
    ${accessToken}=    Get Access Token BAU
    ${prepaidReloadPinless}    ${status_code}=    Post Prepaid Pinless Reload    ${accessToken}    phoneNo=${BAU_DIGI_PREPAID_MSISDN}    paymentAmount=5.00   paymentMethod=OnlineBanking    sourceChannel=${INVALID_LONG}
    Should Be Equal As Strings    ${status_code}    500    #validation length(max)    #Digi (CSG) - Expected error, due to invalid sourceChannel    #Digi (CSG) - sourceChannel is only mapped for CSG2, not IGW and there’s validation at CSG2 for the character length

TC23 : Post Reload Pinless with invalid sourceChannel (invalid sourceChannel-more than 10 char)[Celcom]
    ${accessToken}=    Get Access Token BAU
    ${prepaidReloadPinless}    ${status_code}=    Post Prepaid Pinless Reload    ${accessToken}    phoneNo=${BAU_CELCOM_PREPAID_MSISDN}    paymentAmount=5.00   paymentMethod=OnlineBanking    sourceChannel=${INVALID_LONG}
    Should Be Equal As Strings    ${status_code}    200    #no validation on length(max)    #Celcom (IGW) - sourceChannel is only mapped for CSG2, not IGW and there’s validation at CSG2 for the character length

TC24 : Post Reload Pinless with invalid invalid referenceId (incorrect format-exceeding 23 char)[Digi]
    ${accessToken}=    Get Access Token BAU
    ${prepaidReloadPinless}    ${status_code}=    Post Prepaid Pinless Reload    ${accessToken}    phoneNo=${BAU_DIGI_PREPAID_MSISDN}    paymentAmount=5.00   paymentMethod=OnlineBanking    sourceChannel=223    referenceId=${INVALID_LONG}
    Should Be Equal As Strings    ${status_code}    500    #validation length(max)    #Digi (CSG) - Expected error, due to invalid referenceId    #Error is coming from CSG2/IGW, hence the error messages are different

TC25 : Post Reload Pinless with invalid invalid referenceId (incorrect format-exceeding 23 char)[Celcom]
    ${accessToken}=    Get Access Token BAU
    ${prepaidReloadPinless}    ${status_code}=    Post Prepaid Pinless Reload    ${accessToken}    phoneNo=${BAU_CELCOM_PREPAID_MSISDN}    paymentAmount=5.00   paymentMethod=OnlineBanking    sourceChannel=223    referenceId=${INVALID_LONG}
    Should Be Equal As Strings    ${status_code}    500    #validation length(max)    #Celcom (IGW) - Expected error, due to invalid referenceId    #Error is coming from CSG2/IGW, hence the error messages are different

TC26 : Post Reload Pinless with invalid invalid referenceId (duplicate-has been exist)[Digi] 
    ${accessToken}=    Get Access Token BAU
    ${prepaidReloadPinless}    ${status_code}=    Post Prepaid Pinless Reload    ${accessToken}    phoneNo=${BAU_DIGI_PREPAID_MSISDN}    paymentAmount=20.00   paymentMethod=OnlineBanking    sourceChannel=223    referenceId=HOVPMMDXYUGX
    Should Be Equal As Strings    ${status_code}    200    #no validation[no error but in CRM transaction will only appear once(second transaction ignored)]    #response is identical to the first, except for the distinct transactionDate, value.topup.amount    

TC27 : Post Reload Pinless with invalid invalid referenceId (duplicate-has been exist)[Celcom] 
    ${accessToken}=    Get Access Token BAU
    ${prepaidReloadPinless}    ${status_code}=    Post Prepaid Pinless Reload    ${accessToken}    phoneNo=${BAU_CELCOM_PREPAID_MSISDN}    paymentAmount=10.00   paymentMethod=OnlineBanking    sourceChannel=223    referenceId=CKBJPGEOHDLJ
    Should Be Equal As Strings    ${status_code}    422    #validation value    #Celcom (IGW) - Expected error, due to invalid referenceId    #Error is coming from CSG2/IGW, hence the error messages are different    #IGW returns 201 with error message. So MOLI map it to error code 422 with error message coming from IGW.
