*** Settings ***
Documentation    This file to store test cases SIPADAN FEATURES only

# Resource    ../MOLI-testSettings.robot
# Resource    ../../TestKeywords/moli-sipadan-keywords.robot
Resource    ../../TestKeywords/all_keywords.robot

*** Test Cases ***

#     [Documentation]    
# ...    Ticket: https://celcomdigi.atlassian.net/browse/MOLI-2156  - Bug ticket for Digi
# ...    API: [customer/check-blacklist-v2] whitelist watchlist error
# ...    Apidog: https://app.apidog.com/link/project/696426/apis/api-11709208    Env:[moli-staging-uat]    
# ...    Postman: https://digi-devops.postman.co/workspace/MOLI~d27d9e6a-6183-43fc-814c-c66688a09b8e/request/19640659-b5006e29-c3dc-4a0e-8859-542c4609b83f?action=share&source=copy-link&creator=47340208&ctx=documentation    Env:[moli-staging2] 
# ...    POST 'https://d1dvzfm7v42b0o.cloudfront.net/moli-customer/v2/customer/check-blacklist'

# ...    Description:    
# ...    The Check Blacklist API allows CelcomDigi to verify if a customer is blacklisted based on their identification number and type. 
# ...    This API checks both internal and external blacklist statuses for the CELCOM and DIGI networks, ensuring that the customer is not flagged for any issues. 
# ...    It helps in preventing fraud and maintaining secure service delivery by providing a clear pass or fail status for each network. 
# ...    Additionally, the API can include optional information such as the customer's birth date and nationality to enhance the accuracy of the blacklist check.

# ...    Notes:    
# ...    - `idNumber` and `idType` are mandatory.    
# ...    - `birthDate` and `nationality` are optional.     

TC01 : Post Customer Check Blacklist with super black list subscriber[Digi]
    ${accessToken}=    Get Access Token BAU
    ${customerCheckBlacklistResponse}    ${status_code}=    Put Customer Check Blacklist    ${accessToken}    idNumber=${BAU_DIGI_POSTPAID_IDNUMBER_SUPER_BLACKLIST}    idType=${BAU_DIGI_POSTPAID_IDTYPE_SUPER_BLACKLIST}   birthDate=${BAU_DIGI_POSTPAID_BIRTHDATE_SUPER_BLACKLIST}   nationality=${BAU_DIGI_POSTPAID_NATIONALITY_SUPER_BLACKLIST}   
    Should Be Equal As Strings    ${status_code}    200

TC02 : Post Customer Check Blacklist with watch list subscriber[Digi]
    ${accessToken}=    Get Access Token BAU
    ${customerCheckBlacklistResponse}    ${status_code}=    Put Customer Check Blacklist    ${accessToken}    idNumber=${BAU_DIGI_POSTPAID_IDNUMBER_WATCHLIST}    idType=${BAU_DIGI_POSTPAID_IDTYPE_WATCHLIST}   birthDate=${BAU_DIGI_POSTPAID_BIRTHDATE_WATCHLIST}    nationality=${BAU_DIGI_POSTPAID_NATIONALITY_WATCHLIST}   
    Should Be Equal As Strings    ${status_code}    200

TC03 : Post Customer Check Blacklist with fraud list subscriber[Digi]
    ${accessToken}=    Get Access Token BAU
    ${customerCheckBlacklistResponse}    ${status_code}=    Put Customer Check Blacklist    ${accessToken}    idNumber=${BAU_DIGI_POSTPAID_IDNUMBER_FRAUDLIST}    idType=${BAU_DIGI_POSTPAID_IDTYPE_FRAUDLIST}   birthDate=${BAU_DIGI_POSTPAID_BIRTHDATE_FRAUDLIST}    nationality=${BAU_DIGI_POSTPAID_NATIONALITY_FRAUDLIST}   
    Should Be Equal As Strings    ${status_code}    200

TC04 : Post Customer Check Blacklist with grey list subscriber[Digi]
    ${accessToken}=    Get Access Token BAU
    ${customerCheckBlacklistResponse}    ${status_code}=    Put Customer Check Blacklist    ${accessToken}    idNumber=${BAU_DIGI_POSTPAID_IDNUMBER_GREYLIST}    idType=${BAU_DIGI_POSTPAID_IDTYPE_GREYLIST}   birthDate=${BAU_DIGI_POSTPAID_BIRTHDATE_GREYLIST}    nationality=${BAU_DIGI_POSTPAID_NATIONALITY_GREYLIST}   
    Should Be Equal As Strings    ${status_code}    200

TC05 : Post Customer Check Blacklist with non blacklisted subscriber [Digi]
    ${accessToken}=    Get Access Token BAU
    ${customerCheckBlacklistResponse}    ${status_code}=    Put Customer Check Blacklist    ${accessToken}    idNumber=${BAU_DIGI_POSTPAID_IDNUMBER_CLEARLIST}    idType=${BAU_DIGI_POSTPAID_IDTYPE_CLEARLIST}   birthDate=${BAU_DIGI_POSTPAID_BIRTHDATE_CLEARLIST}    nationality=${BAU_DIGI_POSTPAID_NATIONALITY_CLEARLIST}   
    Should Be Equal As Strings    ${status_code}    200  

TC06 : Post Customer Check Blacklist with non blacklisted subscriber [non CelcomDigi]
    ${accessToken}=    Get Access Token BAU
    ${customerCheckBlacklistResponse}    ${status_code}=    Put Customer Check Blacklist    ${accessToken}    idNumber=${BAU_NONCD_POSTPAID_IDNUMBER_CLEARLIST}    idType=${BAU_NONCD_POSTPAID_IDTYPE_CLEARLIST}   birthDate=${BAU_NONCD_POSTPAID_BIRTHDATE_CLEARLIST}    nationality=${BAU_NONCD_POSTPAID_NATIONALITY_CLEARLIST}   
    Should Be Equal As Strings    ${status_code}    200

TC07 : Post Customer Check Blacklist without mandatory parameter(idNumber, idType)
    ${accessToken}=    Get Access Token BAU
    ${customerCheckBlacklistResponse}    ${status_code}=    Put Customer Check Blacklist    ${accessToken}    birthDate=${BAU_DIGI_POSTPAID_BIRTHDATE_SUPER_BLACKLIST}    nationality=${BAU_DIGI_POSTPAID_NATIONALITY_SUPER_BLACKLIST} 
    Should Be Equal As Strings    ${status_code}    422

TC08 : Post Customer Check Blacklist without optional parameter(birthDate, nationality)
    ${accessToken}=    Get Access Token BAU
    ${customerCheckBlacklistResponse}    ${status_code}=    Put Customer Check Blacklist    ${accessToken}    idNumber=${BAU_DIGI_POSTPAID_IDNUMBER_SUPER_BLACKLIST}    idType=${BAU_DIGI_POSTPAID_IDTYPE_SUPER_BLACKLIST} 
    Should Be Equal As Strings    ${status_code}    200

TC9 : Post Customer Check Blacklist without request body
    ${accessToken}=    Get Access Token BAU
    ${customerCheckBlacklistResponse}    ${status_code}=    Put Customer Check Blacklist    ${accessToken}
    Should Be Equal As Strings    ${status_code}    422

TC10 : Post Customer Check Blacklist with empty string
    ${accessToken}=    Get Access Token BAU
    ${customerCheckBlacklistResponse}    ${status_code}=    Put Customer Check Blacklist    ${accessToken}    idNumber=${EMPTY}    idType=${EMPTY}    birthDate=${EMPTY}    nationality=${EMPTY}
    Should Be Equal As Strings    ${status_code}    422

TC11 : Post Customer Check Blacklist invalid subscriber(invalid idNumber)
    ${accessToken}=    Get Access Token BAU
    ${customerCheckBlacklistResponse}    ${status_code}=    Put Customer Check Blacklist    ${accessToken}    idNumber=${INVALID_FORMAT}    idType=${BAU_DIGI_POSTPAID_IDTYPE_SUPER_BLACKLIST}   birthDate=${BAU_DIGI_POSTPAID_BIRTHDATE_SUPER_BLACKLIST}    nationality=${BAU_DIGI_POSTPAID_NATIONALITY_SUPER_BLACKLIST}   
    Should Be Equal As Strings    ${status_code}    500

TC12 : Post Customer Check Blacklist invalid subscriber(invalid idType)
    ${accessToken}=    Get Access Token BAU
    ${customerCheckBlacklistResponse}    ${status_code}=    Put Customer Check Blacklist    ${accessToken}    idNumber=${BAU_DIGI_POSTPAID_IDNUMBER_SUPER_BLACKLIST}    idType=${INVALID_FORMAT}   birthDate=${BAU_DIGI_POSTPAID_BIRTHDATE_SUPER_BLACKLIST}    nationality=${BAU_DIGI_POSTPAID_NATIONALITY_SUPER_BLACKLIST}   
    Should Be Equal As Strings    ${status_code}    422

TC13 : Post Customer Check Blacklist invalid subscriber(invalid birthDate)
    ${accessToken}=    Get Access Token BAU
    ${customerCheckBlacklistResponse}    ${status_code}=    Put Customer Check Blacklist    ${accessToken}    idNumber=${BAU_DIGI_POSTPAID_IDNUMBER_SUPER_BLACKLIST}    idType=${BAU_DIGI_POSTPAID_IDTYPE_SUPER_BLACKLIST}   birthDate=${INVALID_FORMAT}    nationality=${BAU_DIGI_POSTPAID_NATIONALITY_SUPER_BLACKLIST}   
    Should Be Equal As Strings    ${status_code}    422

TC14 : Post Customer Check Blacklist invalid subscriber(invalid nationality)
    ${accessToken}=    Get Access Token BAU
    ${customerCheckBlacklistResponse}    ${status_code}=    Put Customer Check Blacklist    ${accessToken}    idNumber=${BAU_DIGI_POSTPAID_IDNUMBER_SUPER_BLACKLIST}    idType=${BAU_DIGI_POSTPAID_IDTYPE_SUPER_BLACKLIST}   birthDate=${BAU_DIGI_POSTPAID_BIRTHDATE_SUPER_BLACKLIST}    nationality=${INVALID_FORMAT}   
    Should Be Equal As Strings    ${status_code}    422
