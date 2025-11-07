*** Settings ***
Documentation    This file to store test cases SIPADAN FEATURES only

# Resource    ../../MOLI-testSettings.robot
Resource    ../../TestKeywords/all_keywords.robot
# Resource    ../../TestKeywords/moli-sipadan-keywords.robot

*** Test Cases ***

#     [Documentation]    
# ...    Ticket: https://celcomdigi.atlassian.net/browse/MOLI-2123
# ...    API: [account/update-account] allow email update
# ...    Apidog: https://app.apidog.com/link/project/696426/apis/api-20169525    Env:[moli-staging-uat2]
# ...    Postman: https://digi-devops.postman.co/workspace/MOLI~d27d9e6a-6183-43fc-814c-c66688a09b8e/request/19640659-ee32882f-c58c-4b86-ac65-5756c432a74d?action=share&source=copy-link&creator=47340208&ctx=documentation    Env:[moli-staging2-ngsa] 
# ...    PUT 'https://d31yztj5imu3ny.cloudfront.net/moli-account/v1/account/update-account'

# ...    Description:    
# ...    TThis API is used to update an existing customer account with revised details such as name, contact information, billing preferences, or account status. 
# ...    It supports PUT operations to modify account metadata and synchronize changes across systems for accurate customer profiling

# ...    Notes:    
# ...    - `telco` is mandatory
# ...    - `msisdn`, `update` are conditional mandatory
# ...    - `dealer`, `sourceChannel` are optional

TC01 : Put Update Account Email with valid subscriber(Postpaid Principal-accountOwnerMSISDN is Principal)[Digi] 
    ${accessToken}=    Get Access Token NGCA MOLI UAT
    ${dealer}=    Create Dictionary    code=R0001-B0001    userId=R0001-B0001-1    salesmanCode=R0001-B0001
    ${update}=    Create Dictionary    accountOwnerMSISDN=${BAU_DIGI_POSTPAID_MSISDN_PRINCIPAL}    billingEmail=change@gmail.com
    ${updateAccountResponse}    ${status_code}=    Put Update Account    ${accessToken}    phoneNo=${BAU_DIGI_POSTPAID_MSISDN_PRINCIPAL}     telco=${DIGITELCO}    dealer=${dealer}    sourceChannel=223   update=${update}
    Should Be Equal As Strings    ${status_code}    200

TC02 : Put Update Account Email with valid subscriber(Postpaid Principal-accountOwnerMSISDN is Supplementary)[Digi]
    ${accessToken}=    Get Access Token NGCA MOLI UAT
    ${dealer}=    Create Dictionary    code=R0001-B0001    userId=R0001-B0001-1    salesmanCode=R0001-B0001
    ${update}=    Create Dictionary    accountOwnerMSISDN=${BAU_DIGI_POSTPAID_MSISDN_SUPPLEMENTARY}    billingEmail=changeagain@gmail.com       
    ${updateAccountResponse}    ${status_code}=    Put Update Account    ${accessToken}    phoneNo=${BAU_DIGI_POSTPAID_MSISDN_PRINCIPAL}     telco=${DIGITELCO}    dealer=${dealer}    sourceChannel=223   update=${update}
    Should Be Equal As Strings    ${status_code}    200

TC03 : Put Update Account Email with valid subscriber(Postpaid Supplementary-accountOwnerMSISDN is Principal)[Digi]
    ${accessToken}=    Get Access Token NGCA MOLI UAT
    ${dealer}=    Create Dictionary    code=R0001-B0001    userId=R0001-B0001-1    salesmanCode=R0001-B0001
    ${update}=    Create Dictionary    accountOwnerMSISDN=${BAU_DIGI_POSTPAID_MSISDN_PRINCIPAL}    billingEmail=update@gmail.com       
    ${updateAccountResponse}    ${status_code}=    Put Update Account    ${accessToken}    phoneNo=${BAU_DIGI_POSTPAID_MSISDN_SUPPLEMENTARY}     telco=${DIGITELCO}    dealer=${dealer}    sourceChannel=223   update=${update}
    Should Be Equal As Strings    ${status_code}    200

TC04 : Put Update Account Email with valid subscriber(Postpaid Supplementary-accountOwnerMSISDN is Supplementary)[Digi] 
    ${accessToken}=    Get Access Token NGCA MOLI UAT
    ${dealer}=    Create Dictionary    code=R0001-B0001    userId=R0001-B0001-1    salesmanCode=R0001-B0001
    ${update}=    Create Dictionary    accountOwnerMSISDN=${BAU_DIGI_POSTPAID_MSISDN_SUPPLEMENTARY}    billingEmail=updateagain@gmail.com       
    ${updateAccountResponse}    ${status_code}=    Put Update Account    ${accessToken}    phoneNo=${BAU_DIGI_POSTPAID_MSISDN_SUPPLEMENTARY}     telco=${DIGITELCO}    dealer=${dealer}    sourceChannel=223   update=${update}
    Should Be Equal As Strings    ${status_code}    200

TC05 : Put Update Account Email with valid subscriber(Postpaid Principal-accountOwnerMSISDN is Principal)[Celcom]
    ${accessToken}=    Get Access Token NGCA MOLI UAT
    ${dealer}=    Create Dictionary    code=R0001-B0001    userId=R0001-B0001-1    salesmanCode=R0001-B0001
    ${update}=    Create Dictionary    accountOwnerMSISDN=${BAU_CELCOM_POSTPAID_MSISDN_PRINCIPAL}    billingEmail=abc@gmail.com       
    ${updateAccountResponse}    ${status_code}=    Put Update Account    ${accessToken}    phoneNo=${BAU_CELCOM_POSTPAID_MSISDN_PRINCIPAL}     telco=${CELCOMTELCO}    dealer=${dealer}    sourceChannel=223   update=${update}
    Should Be Equal As Strings    ${status_code}    200

TC06 : Put Update Account Email with valid subscriber(Postpaid Principal-accountOwnerMSISDN is Supplementary)[Celcom]  
    ${accessToken}=    Get Access Token NGCA MOLI UAT
    ${dealer}=    Create Dictionary    code=R0001-B0001    userId=R0001-B0001-1    salesmanCode=R0001-B0001
    ${update}=    Create Dictionary    accountOwnerMSISDN=${BAU_CELCOM_POSTPAID_MSISDN_SUPPLEMENTARY}    billingEmail=abc@gmail.com       
    ${updateAccountResponse}    ${status_code}=    Put Update Account    ${accessToken}    phoneNo=${BAU_CELCOM_POSTPAID_MSISDN_PRINCIPAL}     telco=${CELCOMTELCO}    dealer=${dealer}    sourceChannel=223   update=${update}
    Should Be Equal As Strings    ${status_code}    200

TC07 : Put Update Account Email with valid subscriber(Postpaid Supplementary-accountOwnerMSISDN is Principal)[Celcom]
    ${accessToken}=    Get Access Token NGCA MOLI UAT
    ${dealer}=    Create Dictionary    code=R0001-B0001    userId=R0001-B0001-1    salesmanCode=R0001-B0001
    ${update}=    Create Dictionary    accountOwnerMSISDN=${BAU_CELCOM_POSTPAID_MSISDN_PRINCIPAL}    billingEmail=abc@gmail.com       
    ${updateAccountResponse}    ${status_code}=    Put Update Account    ${accessToken}    phoneNo=${BAU_CELCOM_POSTPAID_MSISDN_SUPPLEMENTARY}     telco=${CELCOMTELCO}    dealer=${dealer}    sourceChannel=223   update=${update}
    Should Be Equal As Strings    ${status_code}    200

TC08 : Put Update Account Email with valid subscriber(Postpaid Supplementary-accountOwnerMSISDN is Supplementary)[Celcom]  
    ${accessToken}=    Get Access Token NGCA MOLI UAT
    ${dealer}=    Create Dictionary    code=R0001-B0001    userId=R0001-B0001-1    salesmanCode=R0001-B0001
    ${update}=    Create Dictionary    accountOwnerMSISDN=${BAU_CELCOM_POSTPAID_MSISDN_SUPPLEMENTARY}    billingEmail=abc@gmail.com       
    ${updateAccountResponse}    ${status_code}=    Put Update Account    ${accessToken}    phoneNo=${BAU_CELCOM_POSTPAID_MSISDN_SUPPLEMENTARY}     telco=${CELCOMTELCO}    dealer=${dealer}    sourceChannel=223   update=${update}
    Should Be Equal As Strings    ${status_code}    200

TC09 : Put Update Account Email with valid subscriber(Prepaid)[Digi] 
    ${accessToken}=    Get Access Token NGCA MOLI UAT
    ${dealer}=    Create Dictionary    code=R0001-B0001    userId=R0001-B0001-1    salesmanCode=R0001-B0001
    ${update}=    Create Dictionary    accountOwnerMSISDN=${BAU_DIGI_PREPAID_MSISDN}    billingEmail=lalala@gmail.com       
    ${updateAccountResponse}    ${status_code}=    Put Update Account    ${accessToken}    phoneNo=${BAU_DIGI_PREPAID_MSISDN}     telco=${DIGITELCO}    dealer=${dealer}    sourceChannel=223   update=${update}
    Should Be Equal As Strings    ${status_code}    200

TC10 : Put Update Account Email with valid subscriber(Prepaid)[Celcom]  
    ${accessToken}=    Get Access Token NGCA MOLI UAT
    ${dealer}=    Create Dictionary    code=R0001-B0001    userId=R0001-B0001-1    salesmanCode=R0001-B0001
    ${update}=    Create Dictionary    accountOwnerMSISDN=${BAU_CELCOM_PREPAID_MSISDN}    billingEmail=test@gmail.com       
    ${updateAccountResponse}    ${status_code}=    Put Update Account    ${accessToken}    phoneNo=${BAU_CELCOM_PREPAID_MSISDN}     telco=${CELCOMTELCO}    dealer=${dealer}    sourceChannel=223   update=${update}
    Should Be Equal As Strings    ${status_code}    200

TC11 : Put Update Account Email with valid subscriber(Duplicate request-have opened case and still pending email verification)[Digi]
    ${accessToken}=    Get Access Token NGCA MOLI UAT
    ${dealer}=    Create Dictionary    code=R0001-B0001    userId=R0001-B0001-1    salesmanCode=R0001-B0001
    ${update}=    Create Dictionary    accountOwnerMSISDN=${BAU_DIGI_POSTPAID_MSISDN_PRINCIPAL}    billingEmail=change@gmail.com
    ${updateAccountResponse}    ${status_code}=    Put Update Account    ${accessToken}    phoneNo=${BAU_DIGI_POSTPAID_MSISDN_PRINCIPAL}     telco=${DIGITELCO}    dealer=${dealer}    sourceChannel=223   update=${update}
    Should Be Equal As Strings    ${status_code}    200

TC12 : Put Update Account Email with valid subscriber(Duplicate request-have opened case and still pending email verification)[Celcom]
    ${accessToken}=    Get Access Token NGCA MOLI UAT
    ${dealer}=    Create Dictionary    code=R0001-B0001    userId=R0001-B0001-1    salesmanCode=R0001-B0001
    ${update}=    Create Dictionary    accountOwnerMSISDN=${BAU_CELCOM_POSTPAID_MSISDN_PRINCIPAL}    billingEmail=abc@gmail.com       
    ${updateAccountResponse}    ${status_code}=    Put Update Account    ${accessToken}    phoneNo=${BAU_CELCOM_POSTPAID_MSISDN_PRINCIPAL}     telco=${CELCOMTELCO}    dealer=${dealer}    sourceChannel=223   update=${update}
    Should Be Equal As Strings    ${status_code}    200

TC13 : Put Update Account Email with invalid subscriber[non CelcomDigi]
    ${accessToken}=    Get Access Token NGCA MOLI UAT
    ${dealer}=    Create Dictionary    code=R0001-B0001    userId=R0001-B0001-1    salesmanCode=R0001-B0001
    ${update}=    Create Dictionary    accountOwnerMSISDN=${BAU_MAXIS_POSTPAID_MSISDN}    billingEmail=abc@gmail.com       
    ${updateAccountResponse}    ${status_code}=    Put Update Account    ${accessToken}    phoneNo=${BAU_MAXIS_POSTPAID_MSISDN}     telco=${MAXISTELCO}    dealer=${dealer}    sourceChannel=223   update=${update}
    Should Be Equal As Strings    ${status_code}    200

TC14 : Put Update Account Email without mandatory parameter (telco)
    ${accessToken}=    Get Access Token NGCA MOLI UAT
    ${dealer}=    Create Dictionary    code=R0001-B0001    userId=R0001-B0001-1    salesmanCode=R0001-B0001
    ${update}=    Create Dictionary    accountOwnerMSISDN=${BAU_CELCOM_POSTPAID_MSISDN}    billingEmail=abc@gmail.com       
    ${updateAccountResponse}    ${status_code}=    Put Update Account    ${accessToken}    phoneNo=${BAU_CELCOM_POSTPAID_MSISDN}     dealer=${dealer}    sourceChannel=223   update=${update}
    Should Be Equal As Strings    ${status_code}    422

TC15 : Put Update Account Email without conditional mandatory parameter (msisdn, update)
    ${accessToken}=    Get Access Token NGCA MOLI UAT
    ${dealer}=    Create Dictionary    code=R0001-B0001    userId=R0001-B0001-1    salesmanCode=R0001-B0001
    ${updateAccountResponse}    ${status_code}=    Put Update Account    ${accessToken}    telco=${CELCOMTELCO}    dealer=${dealer}    sourceChannel=223
    Should Be Equal As Strings    ${status_code}    422

TC16 : Put Update Account Email without optional parameter (dealer, sourceChannel)
    ${accessToken}=    Get Access Token NGCA MOLI UAT
    ${update}=    Create Dictionary    accountOwnerMSISDN=${BAU_DIGI_POSTPAID_MSISDN_PRINCIPAL}    billingEmail=optional@gmail.com       
    ${updateAccountResponse}    ${status_code}=    Put Update Account    ${accessToken}    phoneNo=${BAU_DIGI_POSTPAID_MSISDN_PRINCIPAL}     telco=${DIGITELCO}    update=${update}
    Should Be Equal As Strings    ${status_code}    200

TC17 : Put Update Account Email without request body
    ${accessToken}=    Get Access Token NGCA MOLI UAT
    ${updateAccountResponse}    ${status_code}=    Put Update Account    ${accessToken}    
    Should Be Equal As Strings    ${status_code}    422

TC18 : Put Update Account Email with empty string
    ${accessToken}=    Get Access Token NGCA MOLI UAT
    ${dealer}=    Create Dictionary    code=${EMPTY}   userId=${EMPTY}    salesmanCode=${EMPTY}
    ${update}=    Create Dictionary    accountOwnerMSISDN=${EMPTY}    billingEmail=${EMPTY}
    ${updateAccountResponse}    ${status_code}=    Put Update Account    ${accessToken}    phoneNo=${EMPTY}     telco=${EMPTY}    dealer=${dealer}   sourceChannel=${EMPTY}   update=${update}
    Should Be Equal As Strings    ${status_code}    400

TC19 : Put Update Account Email with invalid msisdn (invalid service number-incorrect format & less than 10 char)[Digi]
    ${accessToken}=    Get Access Token NGCA MOLI UAT
    ${dealer}=    Create Dictionary    code=R0001-B0001    userId=R0001-B0001-1    salesmanCode=R0001-B0001
    ${update}=    Create Dictionary    accountOwnerMSISDN=${BAU_DIGI_POSTPAID_MSISDN_PRINCIPAL}    billingEmail=change@gmail.com
    ${updateAccountResponse}    ${status_code}=    Put Update Account    ${accessToken}    phoneNo=${INVALID_FORMAT_MSISDN_SHORT}     telco=${DIGITELCO}    dealer=${dealer}    sourceChannel=223   update=${update}
    Should Be Equal As Strings    ${status_code}    422

TC20 : Put Update Account Email with invalid msisdn (invalid service number-incorrect format & less than 10 char)[Celcom]
    ${accessToken}=    Get Access Token NGCA MOLI UAT
    ${dealer}=    Create Dictionary    code=R0001-B0001    userId=R0001-B0001-1    salesmanCode=R0001-B0001
    ${update}=    Create Dictionary    accountOwnerMSISDN=${BAU_CELCOM_POSTPAID_MSISDN_PRINCIPAL}    billingEmail=change@gmail.com
    ${updateAccountResponse}    ${status_code}=    Put Update Account    ${accessToken}    phoneNo=${INVALID_FORMAT_MSISDN_SHORT}     telco=${CELCOMTELCO}    dealer=${dealer}    sourceChannel=223   update=${update}
    Should Be Equal As Strings    ${status_code}    422    

TC21 : Put Update Account Email with invalid msisdn (invalid service number-incorrect format & more than 12 char)[Digi]
    ${accessToken}=    Get Access Token NGCA MOLI UAT
    ${dealer}=    Create Dictionary    code=R0001-B0001    userId=R0001-B0001-1    salesmanCode=R0001-B0001
    ${update}=    Create Dictionary    accountOwnerMSISDN=${BAU_DIGI_POSTPAID_MSISDN_PRINCIPAL}    billingEmail=change@gmail.com
    ${updateAccountResponse}    ${status_code}=    Put Update Account    ${accessToken}    phoneNo=${INVALID_FORMAT_MSISDN_LONG}     telco=${DIGITELCO}    dealer=${dealer}    sourceChannel=223   update=${update}
    Should Be Equal As Strings    ${status_code}    422

TC22 : Put Update Account Email with invalid msisdn (invalid service number-incorrect format & more than 12 char)[Celcom]
    ${accessToken}=    Get Access Token NGCA MOLI UAT
    ${dealer}=    Create Dictionary    code=R0001-B0001    userId=R0001-B0001-1    salesmanCode=R0001-B0001
    ${update}=    Create Dictionary    accountOwnerMSISDN=${BAU_CELCOM_POSTPAID_MSISDN_PRINCIPAL}    billingEmail=change@gmail.com
    ${updateAccountResponse}    ${status_code}=    Put Update Account    ${accessToken}    phoneNo=${INVALID_FORMAT_MSISDN_LONG}     telco=${CELCOMTELCO}    dealer=${dealer}    sourceChannel=223   update=${update}
    Should Be Equal As Strings    ${status_code}    422

TC23 : Put Update Account Email with invalid msisdn (invalid service number-incorrect format)[Digi]
    ${accessToken}=    Get Access Token NGCA MOLI UAT
    ${dealer}=    Create Dictionary    code=R0001-B0001    userId=R0001-B0001-1    salesmanCode=R0001-B0001
    ${update}=    Create Dictionary    accountOwnerMSISDN=${BAU_DIGI_POSTPAID_MSISDN_PRINCIPAL}    billingEmail=change@gmail.com
    ${updateAccountResponse}    ${status_code}=    Put Update Account    ${accessToken}    phoneNo=${INVALID_FORMAT}     telco=${DIGITELCO}    dealer=${dealer}    sourceChannel=223   update=${update}
    Should Be Equal As Strings    ${status_code}    422

TC24 : Put Update Account Email with invalid msisdn (invalid service number-incorrect format)[Celcom]
    ${accessToken}=    Get Access Token NGCA MOLI UAT
    ${dealer}=    Create Dictionary    code=R0001-B0001    userId=R0001-B0001-1    salesmanCode=R0001-B0001
    ${update}=    Create Dictionary    accountOwnerMSISDN=${BAU_CELCOM_POSTPAID_MSISDN_PRINCIPAL}    billingEmail=change@gmail.com
    ${updateAccountResponse}    ${status_code}=    Put Update Account    ${accessToken}    phoneNo=${INVALID_FORMAT}     telco=${CELCOMTELCO}    dealer=${dealer}    sourceChannel=223   update=${update}
    Should Be Equal As Strings    ${status_code}    422

TC25 : Put Update Account Email with invalid msisdn (invalid service number-less than 10 char)[Digi]
    ${accessToken}=    Get Access Token NGCA MOLI UAT
    ${dealer}=    Create Dictionary    code=R0001-B0001    userId=R0001-B0001-1    salesmanCode=R0001-B0001
    ${update}=    Create Dictionary    accountOwnerMSISDN=${BAU_DIGI_POSTPAID_MSISDN_PRINCIPAL}    billingEmail=change@gmail.com
    ${updateAccountResponse}    ${status_code}=    Put Update Account    ${accessToken}    phoneNo=${INVALID_MSISDN_SHORT}     telco=${DIGITELCO}    dealer=${dealer}    sourceChannel=223   update=${update}
    Should Be Equal As Strings    ${status_code}    422     

TC26 : Put Update Account Email with invalid msisdn (invalid service number-less than 10 char)[Celcom]
    ${accessToken}=    Get Access Token NGCA MOLI UAT
    ${dealer}=    Create Dictionary    code=R0001-B0001    userId=R0001-B0001-1    salesmanCode=R0001-B0001
    ${update}=    Create Dictionary    accountOwnerMSISDN=${BAU_CELCOM_POSTPAID_MSISDN_PRINCIPAL}    billingEmail=change@gmail.com
    ${updateAccount}    ${status_code}=    Put Update Account    ${accessToken}    phoneNo=${INVALID_MSISDN_SHORT}     telco=${CELCOMTELCO}    dealer=${dealer}    sourceChannel=223   update=${update}
    Should Be Equal As Strings    ${status_code}    422

TC27 : Put Update Account Email with invalid msisdn (invalid service number-more than 12 char)[Digi]
    ${accessToken}=    Get Access Token NGCA MOLI UAT
    ${dealer}=    Create Dictionary    code=R0001-B0001    userId=R0001-B0001-1    salesmanCode=R0001-B0001
    ${update}=    Create Dictionary    accountOwnerMSISDN=${BAU_DIGI_POSTPAID_MSISDN_PRINCIPAL}    billingEmail=change@gmail.com
    ${updateAccountResponse}    ${status_code}=    Put Update Account    ${accessToken}    phoneNo=${INVALID_MSISDN_LONG}     telco=${DIGITELCO}    dealer=${dealer}    sourceChannel=223   update=${update}
    Should Be Equal As Strings    ${status_code}    422

TC28 : Put Update Account Email with invalid msisdn (invalid service number-more than 12 char)[Celcom]
    ${accessToken}=    Get Access Token NGCA MOLI UAT
    ${dealer}=    Create Dictionary    code=R0001-B0001    userId=R0001-B0001-1    salesmanCode=R0001-B0001
    ${update}=    Create Dictionary    accountOwnerMSISDN=${BAU_CELCOM_POSTPAID_MSISDN_PRINCIPAL}    billingEmail=change@gmail.com
    ${updateAccountResponse}    ${status_code}=    Put Update Account    ${accessToken}    phoneNo=${INVALID_MSISDN_LONG}     telco=${CELCOMTELCO}    dealer=${dealer}    sourceChannel=223   update=${update}
    Should Be Equal As Strings    ${status_code}    422

TC29 : Put Update Account Email with invalid telco
    ${accessToken}=    Get Access Token NGCA MOLI UAT
    ${dealer}=    Create Dictionary    code=R0001-B0001    userId=R0001-B0001-1    salesmanCode=R0001-B0001
    ${update}=    Create Dictionary    accountOwnerMSISDN=${BAU_DIGI_POSTPAID_MSISDN_PRINCIPAL}    billingEmail=change@gmail.com
    ${updateAccountResponse}    ${status_code}=    Put Update Account    ${accessToken}    phoneNo=${BAU_DIGI_POSTPAID_MSISDN_PRINCIPAL}     telco=CELCOMDIGI    dealer=${dealer}    sourceChannel=223   update=${update}
    Should Be Equal As Strings    ${status_code}    400

TC30 : Put Update Account Email with invalid dealer[Digi]
    ${accessToken}=    Get Access Token NGCA MOLI UAT
    ${dealer}=    Create Dictionary    code=${INVALID_SHORT}   userId=${INVALID_SHORT}    salesmanCode=${INVALID_SHORT}
    ${update}=    Create Dictionary    accountOwnerMSISDN=${BAU_DIGI_POSTPAID_MSISDN_PRINCIPAL}    billingEmail=2change@gmail.com
    ${updateAccountResponse}    ${status_code}=    Put Update Account    ${accessToken}    phoneNo=${BAU_DIGI_POSTPAID_MSISDN_PRINCIPAL}     telco=${DIGITELCO}    dealer=${dealer}    sourceChannel=223   update=${update}
    Should Be Equal As Strings    ${status_code}    200    //no validation value

TC31 : Put Update Account Email with invalid dealer[Celcom]
    ${accessToken}=    Get Access Token NGCA MOLI UAT
    ${dealer}=    Create Dictionary    code=${INVALID_SHORT}   userId=${INVALID_SHORT}    salesmanCode=${INVALID_SHORT}
    ${update}=    Create Dictionary    accountOwnerMSISDN=${BAU_CELCOM_POSTPAID_MSISDN_PRINCIPAL}    billingEmail=change@gmail.com
    ${updateAccountResponse}    ${status_code}=    Put Update Account    ${accessToken}    phoneNo=${BAU_CELCOM_POSTPAID_MSISDN_PRINCIPAL}     telco=${CELCOMTELCO}    dealer=${dealer}    sourceChannel=223   update=${update}
    Should Be Equal As Strings    ${status_code}    200    //no validation on value

TC32 : Put Update Account Email with invalid dealer (invalid dealer-exceeding 50 char)[Digi]
    ${accessToken}=    Get Access Token NGCA MOLI UAT
    ${dealer}=    Create Dictionary    code=${INVALID_LONG}   userId=${INVALID_LONG}    salesmanCode=${INVALID_LONG}
    ${update}=    Create Dictionary    accountOwnerMSISDN=${BAU_DIGI_POSTPAID_MSISDN_PRINCIPAL}    billingEmail=abcdef@gmail.com
    ${updateAccountResponse}    ${status_code}=    Put Update Account    ${accessToken}    phoneNo=${BAU_DIGI_POSTPAID_MSISDN_PRINCIPAL}     telco=${DIGITELCO}    dealer=${dealer}    sourceChannel=223   update=${update}
    Should Be Equal As Strings    ${status_code}    500

TC33 : Put Update Account Email with invalid dealer (invalid dealer-exceeding 50 char)[Celcom]
    ${accessToken}=    Get Access Token NGCA MOLI UAT
    ${dealer}=    Create Dictionary    code=${INVALID_LONG}   userId=${INVALID_LONG}    salesmanCode=${INVALID_LONG}
    ${update}=    Create Dictionary    accountOwnerMSISDN=${BAU_CELCOM_POSTPAID_MSISDN_PRINCIPAL}    billingEmail=abcdef@gmail.com
    ${updateAccountResponse}    ${status_code}=    Put Update Account    ${accessToken}    phoneNo=${BAU_CELCOM_POSTPAID_MSISDN_PRINCIPAL}     telco=${CELCOMTELCO}    dealer=${dealer}    sourceChannel=223   update=${update}
    Should Be Equal As Strings    ${status_code}    200    //no validation on value

TC34 : Put Update Account Email with invalid sourceChannel[Digi]
    ${accessToken}=    Get Access Token NGCA MOLI UAT
    ${dealer}=    Create Dictionary    code=R0001-B0001    userId=R0001-B0001-1    salesmanCode=R0001-B0001
    ${update}=    Create Dictionary    accountOwnerMSISDN=${BAU_DIGI_POSTPAID_MSISDN_PRINCIPAL}    billingEmail=22change@gmail.com
    ${updateAccountResponse}    ${status_code}=    Put Update Account    ${accessToken}    phoneNo=${BAU_DIGI_POSTPAID_MSISDN_PRINCIPAL}     telco=${DIGITELCO}    dealer=${dealer}    sourceChannel=${INVALID_SHORT}   update=${update}
    Should Be Equal As Strings    ${status_code}    200    //no validation on value

TC35 : Put Update Account Email with invalid sourceChannel[Celcom]
    ${accessToken}=    Get Access Token NGCA MOLI UAT
    ${dealer}=    Create Dictionary    code=R0001-B0001    userId=R0001-B0001-1    salesmanCode=R0001-B0001
    ${update}=    Create Dictionary    accountOwnerMSISDN=${BAU_CELCOM_POSTPAID_MSISDN_PRINCIPAL}    billingEmail=change@gmail.com
    ${updateAccountResponse}    ${status_code}=    Put Update Account    ${accessToken}    phoneNo=${BAU_CELCOM_POSTPAID_MSISDN_PRINCIPAL}     telco=${CELCOMTELCO}    dealer=${dealer}    sourceChannel=${INVALID_SHORT}   update=${update}
    Should Be Equal As Strings    ${status_code}    200    //no validation on value

TC36 : Put Update Account Email with invalid sourceChannel (invalid sourceChannel-exceeding 50 char)[Digi]
    ${accessToken}=    Get Access Token NGCA MOLI UAT
    ${dealer}=    Create Dictionary    code=R0001-B0001    userId=R0001-B0001-1    salesmanCode=R0001-B0001
    ${update}=    Create Dictionary    accountOwnerMSISDN=${BAU_DIGI_POSTPAID_MSISDN_PRINCIPAL}    billingEmail=change@gmail.com
    ${updateAccountResponse}    ${status_code}=    Put Update Account    ${accessToken}    phoneNo=${BAU_DIGI_POSTPAID_MSISDN_PRINCIPAL}     telco=${DIGITELCO}    dealer=${dealer}    sourceChannel=${INVALID_LONG}   update=${update}
    Should Be Equal As Strings    ${status_code}    200    //no validation on value

TC37 : Put Update Account Email with invalid sourceChannel (invalid sourceChannel-exceeding 50 char)[Celcom]
    ${accessToken}=    Get Access Token NGCA MOLI UAT
    ${dealer}=    Create Dictionary    code=R0001-B0001    userId=R0001-B0001-1    salesmanCode=R0001-B0001
    ${update}=    Create Dictionary    accountOwnerMSISDN=${BAU_CELCOM_POSTPAID_MSISDN_PRINCIPAL}    billingEmail=change@gmail.com
    ${updateAccountResponse}    ${status_code}=    Put Update Account    ${accessToken}    phoneNo=${BAU_CELCOM_POSTPAID_MSISDN_PRINCIPAL}     telco=${CELCOMTELCO}    dealer=${dealer}    sourceChannel=${INVALID_LONG}   update=${update}
    Should Be Equal As Strings    ${status_code}    200    //no validation on value

TC38 : Put Update Account Email with invalid update[Digi]
    ${accessToken}=    Get Access Token NGCA MOLI UAT
    ${dealer}=    Create Dictionary    code=R0001-B0001    userId=R0001-B0001-1    salesmanCode=R0001-B0001
    ${update}=    Create Dictionary    accountOwnerMSISDN=${INVALID_SHORT}    billingEmail=${INVALID_SHORT}
    ${updateAccountResponse}    ${status_code}=    Put Update Account    ${accessToken}    phoneNo=${BAU_DIGI_POSTPAID_MSISDN_PRINCIPAL}     telco=${DIGITELCO}    dealer=${dealer}    sourceChannel=223   update=${update}
    Should Be Equal As Strings    ${status_code}    500    

TC39 : Put Update Account Email with invalid update[Celcom]
    ${accessToken}=    Get Access Token NGCA MOLI UAT
    ${dealer}=    Create Dictionary    code=R0001-B0001    userId=R0001-B0001-1    salesmanCode=R0001-B0001
    ${update}=    Create Dictionary    accountOwnerMSISDN=${INVALID_SHORT}    billingEmail=${INVALID_SHORT}
    ${updateAccountResponse}    ${status_code}=    Put Update Account    ${accessToken}    phoneNo=${BAU_CELCOM_POSTPAID_MSISDN_PRINCIPAL}     telco=${CELCOMTELCO}    dealer=${dealer}    sourceChannel=223   update=${update}
    Should Be Equal As Strings    ${status_code}    200    //no validation on value

TC40 : Put Update Account Email with invalid update (invalid update-exceeding 50 char)[Digi]
    ${accessToken}=    Get Access Token NGCA MOLI UAT
    ${dealer}=    Create Dictionary    code=R0001-B0001    userId=R0001-B0001-1    salesmanCode=R0001-B0001
    ${update}=    Create Dictionary    accountOwnerMSISDN=${INVALID_LONG}    billingEmail=${INVALID_LONG}
    ${updateAccountResponse}    ${status_code}=    Put Update Account    ${accessToken}    phoneNo=${BAU_DIGI_POSTPAID_MSISDN_PRINCIPAL}     telco=${DIGITELCO}    dealer=${dealer}    sourceChannel=223   update=${update}
    Should Be Equal As Strings    ${status_code}    500    

TC41 : Put Update Account Email with invalid update (invalid update-exceeding 50 char)[Celcom]
    ${accessToken}=    Get Access Token NGCA MOLI UAT
    ${dealer}=    Create Dictionary    code=R0001-B0001    userId=R0001-B0001-1    salesmanCode=R0001-B0001
    ${update}=    Create Dictionary    accountOwnerMSISDN=${INVALID_LONG}    billingEmail=${INVALID_LONG}
    ${updateAccountResponse}    ${status_code}=    Put Update Account    ${accessToken}    phoneNo=${BAU_CELCOM_POSTPAID_MSISDN_PRINCIPAL}     telco=${CELCOMTELCO}    dealer=${dealer}    sourceChannel=223   update=${update}
    Should Be Equal As Strings    ${status_code}    200    //no validation on value

TC42 : Put Update Account Email with valid subscriber(Postpaid Principal-accountOwnerMSISDN is Principal)[Digi] using Celcom telco
    ${accessToken}=    Get Access Token NGCA MOLI UAT
    ${dealer}=    Create Dictionary    code=R0001-B0001    userId=R0001-B0001-1    salesmanCode=R0001-B0001
    ${update}=    Create Dictionary    accountOwnerMSISDN=${BAU_DIGI_POSTPAID_MSISDN_PRINCIPAL}    billingEmail=change@gmail.com
    ${updateAccountResponse}    ${status_code}=    Put Update Account    ${accessToken}    phoneNo=${BAU_DIGI_POSTPAID_MSISDN_PRINCIPAL}     telco=${CELCOMTELCO}    dealer=${dealer}    sourceChannel=223   update=${update}
    Should Be Equal As Strings    ${status_code}    500

TC43 : Put Update Account Email with valid subscriber(Postpaid Principal-accountOwnerMSISDN is Principal)[Celcom] using Digi telco
    ${accessToken}=    Get Access Token NGCA MOLI UAT
    ${dealer}=    Create Dictionary    code=R0001-B0001    userId=R0001-B0001-1    salesmanCode=R0001-B0001
    ${update}=    Create Dictionary    accountOwnerMSISDN=${BAU_CELCOM_POSTPAID_MSISDN_PRINCIPAL}    billingEmail=abc@gmail.com
    ${updateAccountResponse}    ${status_code}=    Put Update Account    ${accessToken}    phoneNo=${BAU_CELCOM_POSTPAID_MSISDN_PRINCIPAL}     telco=${DIGITELCO}    dealer=${dealer}    sourceChannel=223   update=${update}
    Should Be Equal As Strings    ${status_code}    500
