*** Settings ***
Documentation    This file to store test cases SIPADAN FEATURES only

Resource    ../../TestKeywords/all_keywords.robot
# Resource    ../../TestKeywords/moli-sipadan-keywords.robot

*** Test Cases ***

#     [Documentation]    
# ...    Ticket: https://celcomdigi.atlassian.net/browse/MOLI-2221
# ...    API: [account/adapter/csg2/get-account-structure] get msisdn with latest ExpiryDate
# ...    Apidog: https://app.apidog.com/link/project/652757/apis/api-10253733    Env:[moli-staging-uat2]
# ...    Postman: https://digi-devops.postman.co/workspace/MOLI~d27d9e6a-6183-43fc-814c-c66688a09b8e/request/19640659-24e8c3c2-6444-4f5f-af85-3adedc0302b6?action=share&source=copy-link&creator=47340208&ctx=documentation    Env:[moli-staging2-ngsa] 
# ...    GET '/moli-account/v1/accounts/{msisdn}/structure'

# ...    Description:    
# ...    This API can give you an information to determine if user is from Celcom or Digi account, and also the status for their account, together with their Personal ID Number

# ...    Notes:    
# ...    - `msisdn` is mandatory
#...    - `level` is optional (default level is subscriber)

TC01 : Get Account Structure with valid subscriber(Postpaid Principal - Account Level)[Digi]
    ${accessToken}=    Get Access Token NGCA MOLI UAT
    ${accountStructureResponse}    ${status_code}=    Get Account Structure    ${accessToken}    phoneNo=${BAU_DIGI_POSTPAID_MSISDN_PRINCIPAL}    level=account
    Should Be Equal As Strings    ${status_code}    200

TC02 : Get Account Structure with valid subscriber(Postpaid Principal - Subscriber Level)[Digi] 
    ${accessToken}=    Get Access Token NGCA MOLI UAT
    ${accountStructureResponse}    ${status_code}=    Get Account Structure    ${accessToken}    phoneNo=${BAU_DIGI_POSTPAID_MSISDN_PRINCIPAL}    level=subscriber
    Should Be Equal As Strings    ${status_code}    200

TC03 : Get Account Structure with valid subscriber(Postpaid Principal - Customer Level)[Digi] 
    ${accessToken}=    Get Access Token NGCA MOLI UAT
    ${accountStructureResponse}    ${status_code}=    Get Account Structure    ${accessToken}    phoneNo=${BAU_DIGI_POSTPAID_MSISDN_PRINCIPAL}    level=customer
    Should Be Equal As Strings    ${status_code}    200

TC04 : Get Account Structure with valid subscriber(Postpaid Supplementary - Account Level)[Digi] 
    ${accessToken}=    Get Access Token NGCA MOLI UAT
    ${accountStructureResponse}    ${status_code}=    Get Account Structure    ${accessToken}    phoneNo=${BAU_DIGI_POSTPAID_MSISDN_SUPPLEMENTARY}    level=account
    Should Be Equal As Strings    ${status_code}    200

TC05 : Get Account Structure with valid subscriber(Postpaid Supplementary - Subscriber Level)[Digi] 
    ${accessToken}=    Get Access Token NGCA MOLI UAT
    ${accountStructureResponse}    ${status_code}=    Get Account Structure    ${accessToken}    phoneNo=${BAU_DIGI_POSTPAID_MSISDN_SUPPLEMENTARY}    level=subscriber
    Should Be Equal As Strings    ${status_code}    200

TC06 : Get Account Structure with valid subscriber(Postpaid Supplementary - Customer Level)[Digi] 
    ${accessToken}=    Get Access Token NGCA MOLI UAT
    ${accountStructureResponse}    ${status_code}=    Get Account Structure    ${accessToken}    phoneNo=${BAU_DIGI_POSTPAID_MSISDN_SUPPLEMENTARY}    level=customer
    Should Be Equal As Strings    ${status_code}    200

TC07 : Get Account Structure with valid subscriber(Postpaid Principal - Account Level)[Celcom]
    ${accessToken}=    Get Access Token NGCA MOLI UAT
    ${accountStructureResponse}    ${status_code}=    Get Account Structure    ${accessToken}    phoneNo=${BAU_CELCOM_POSTPAID_MSISDN_PRINCIPAL}    level=account
    Should Be Equal As Strings    ${status_code}    200
    
TC08 : Get Account Structure with valid subscriber(Postpaid Principal - Subscriber Level)[Celcom] 
    ${accessToken}=    Get Access Token NGCA MOLI UAT
    ${accountStructureResponse}    ${status_code}=    Get Account Structure    ${accessToken}    phoneNo=${BAU_CELCOM_POSTPAID_MSISDN_PRINCIPAL}    level=subscriber
    Should Be Equal As Strings    ${status_code}    200

TC09 : Get Account Structure with valid subscriber(Postpaid Principal - Customer Level)[Celcom] 
    ${accessToken}=    Get Access Token NGCA MOLI UAT
    ${accountStructureResponse}    ${status_code}=    Get Account Structure    ${accessToken}    phoneNo=${BAU_CELCOM_POSTPAID_MSISDN_PRINCIPAL}    level=customer
    Should Be Equal As Strings    ${status_code}    200

TC10 : Get Account Structure with valid subscriber(Postpaid Supplementary - Account Level)[Celcom] 
    ${accessToken}=    Get Access Token NGCA MOLI UAT
    ${accountStructureResponse}    ${status_code}=    Get Account Structure    ${accessToken}    phoneNo=${BAU_CELCOM_POSTPAID_MSISDN_SUPPLEMENTARY}    level=account
    Should Be Equal As Strings    ${status_code}    200

TC11 : Get Account Structure with valid subscriber(Postpaid Supplementary - Subscriber Level)[Celcom] 
    ${accessToken}=    Get Access Token NGCA MOLI UAT
    ${accountStructureResponse}    ${status_code}=    Get Account Structure    ${accessToken}    phoneNo=${BAU_CELCOM_POSTPAID_MSISDN_SUPPLEMENTARY}    level=subscriber
    Should Be Equal As Strings    ${status_code}    200

TC12 : Get Account Structure with valid subscriber(Postpaid Supplementary - Customer Level)[Celcom] 
    ${accessToken}=    Get Access Token NGCA MOLI UAT
    ${accountStructureResponse}    ${status_code}=    Get Account Structure    ${accessToken}    phoneNo=${BAU_CELCOM_POSTPAID_MSISDN_SUPPLEMENTARY}    level=customer
    Should Be Equal As Strings    ${status_code}    200

TC13 : Get Account Structure with valid subscriber(Prepaid - Account Level)[Digi] 
    ${accessToken}=    Get Access Token NGCA MOLI UAT
    ${accountStructureResponse}    ${status_code}=    Get Account Structure    ${accessToken}    phoneNo=${BAU_DIGI_PREPAID_MSISDN}    level=account
    Should Be Equal As Strings    ${status_code}    200

TC14 : Get Account Structure with valid subscriber(Prepaid - Subscriber Level)[Digi]
    ${accessToken}=    Get Access Token NGCA MOLI UAT
    ${accountStructureResponse}    ${status_code}=    Get Account Structure    ${accessToken}    phoneNo=${BAU_DIGI_PREPAID_MSISDN}    level=subscriber
    Should Be Equal As Strings    ${status_code}    200

TC15 : Get Account Structure with valid subscriber(Prepaid - Customer Level)[Digi] 
    ${accessToken}=    Get Access Token NGCA MOLI UAT
    ${accountStructureResponse}    ${status_code}=    Get Account Structure    ${accessToken}    phoneNo=${BAU_DIGI_PREPAID_MSISDN}    level=customer
    Should Be Equal As Strings    ${status_code}    200

TC16 : Get Account Structure with valid subscriber(Prepaid - Account Level)[Celcom]
    ${accessToken}=    Get Access Token NGCA MOLI UAT
    ${accountStructureResponse}    ${status_code}=    Get Account Structure    ${accessToken}    phoneNo=${BAU_CELCOM_PREPAID_MSISDN}    level=account
    Should Be Equal As Strings    ${status_code}    200

TC17 : Get Account Structure with valid subscriber(Prepaid - Subscriber Level)[Celcom]
    ${accessToken}=    Get Access Token NGCA MOLI UAT
    ${accountStructureResponse}    ${status_code}=    Get Account Structure    ${accessToken}    phoneNo=${BAU_CELCOM_PREPAID_MSISDN}    level=subscriber
    Should Be Equal As Strings    ${status_code}    200

TC18 : Get Account Structure with valid subscriber(Prepaid - Customer Level)[Celcom]
    ${accessToken}=    Get Access Token NGCA MOLI UAT
    ${accountStructureResponse}    ${status_code}=    Get Account Structure    ${accessToken}    phoneNo=${BAU_CELCOM_PREPAID_MSISDN}    level=customer
    Should Be Equal As Strings    ${status_code}    200

TC19 : Get Account Structure with invalid subscriber[non CelcomDigi - Account Level]
    ${accessToken}=    Get Access Token NGCA MOLI UAT
    ${accountStructureResponse}    ${status_code}=    Get Account Structure    ${accessToken}    phoneNo=${BAU_MAXIS_POSTPAID_MSISDN}    level=account
    Should Be Equal As Strings    ${status_code}    404

TC20 : Get Account Structure with invalid subscriber[non CelcomDigi - Subscriber Level]
    ${accessToken}=    Get Access Token NGCA MOLI UAT
    ${accountStructureResponse}    ${status_code}=    Get Account Structure    ${accessToken}    phoneNo=${BAU_MAXIS_POSTPAID_MSISDN}    level=subscriber
    Should Be Equal As Strings    ${status_code}    404

TC21 : Get Account Structure with invalid subscriber[non CelcomDigi - Customer Level]
    ${accessToken}=    Get Access Token NGCA MOLI UAT
    ${accountStructureResponse}    ${status_code}=    Get Account Structure    ${accessToken}    phoneNo=${BAU_MAXIS_POSTPAID_MSISDN}    level=customer
    Should Be Equal As Strings    ${status_code}    404

TC22 : Get Account Structure without mandatory parameter (msisdn)
    ${accessToken}=    Get Access Token NGCA MOLI UAT
    ${accountStructureResponse}    ${status_code}=    Get Account Structure    ${accessToken}    phoneNo=${EMPTY}    level=account
    Should Be Equal As Strings    ${status_code}    422

TC23 : Get Account Structure without optional parameter (level) (default level is subscriber)
    ${accessToken}=    Get Access Token NGCA MOLI UAT
    ${accountStructureResponse}    ${status_code}=    Get Account Structure    ${accessToken}    phoneNo=${BAU_CELCOM_PREPAID_MSISDN}
    Should Be Equal As Strings    ${status_code}    200

TC24 : Get Account Structure with invalid msisdn (invalid service number-incorrect format & less than 10 char)
    ${accessToken}=    Get Access Token NGCA MOLI UAT
    ${accountStructureResponse}    ${status_code}=    Get Account Structure    ${accessToken}    phoneNo=${INVALID_FORMAT_MSISDN_SHORT}
    Should Be Equal As Strings    ${status_code}    422

TC25 : Get Account Structure with invalid msisdn (invalid service number-incorrect format & more than 12 char)
    ${accessToken}=    Get Access Token NGCA MOLI UAT
    ${accountStructureResponse}    ${status_code}=    Get Account Structure    ${accessToken}    phoneNo=${INVALID_FORMAT_MSISDN_SHORT}
    Should Be Equal As Strings    ${status_code}    422

TC26 : Get Account Structure with invalid msisdn (invalid service number-incorrect format)
    ${accessToken}=    Get Access Token NGCA MOLI UAT
    ${accountStructureResponse}    ${status_code}=    Get Account Structure    ${accessToken}    phoneNo=${INVALID_FORMAT}
    Should Be Equal As Strings    ${status_code}    422

TC27 : Get Account Structure with invalid msisdn (invalid service number-less than 10 char)
    ${accessToken}=    Get Access Token NGCA MOLI UAT
    ${accountStructureResponse}    ${status_code}=    Get Account Structure    ${accessToken}    phoneNo=${INVALID_MSISDN_SHORT}
    Should Be Equal As Strings    ${status_code}    422

TC28 : Get Account Structure with invalid msisdn (invalid service number-more than 12 char)
    ${accessToken}=    Get Access Token NGCA MOLI UAT
    ${accountStructureResponse}    ${status_code}=    Get Account Structure    ${accessToken}    phoneNo=${INVALID_MSISDN_LONG}
    Should Be Equal As Strings    ${status_code}    422

TC29 : Get Account Structure with invalid level
    ${accessToken}=    Get Access Token NGCA MOLI UAT
    ${accountStructureResponse}    ${status_code}=    Get Account Structure    ${accessToken}    phoneNo=${BAU_CELCOM_PREPAID_MSISDN}    level=others
    Should Be Equal As Strings    ${status_code}    422
