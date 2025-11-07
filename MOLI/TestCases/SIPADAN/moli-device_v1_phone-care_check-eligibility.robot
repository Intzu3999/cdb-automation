*** Settings ***
Documentation    This file to store test cases SIPADAN FEATURES only

# Resource    ../MOLI-testSettings.robot
# Resource    ../../TestKeywords/moli-sipadan-keywords.robot
Resource    ../../TestKeywords/all_keywords.robot

*** Test Cases ***

#     [Documentation]    
# ...    Ticket: https://celcomdigi.atlassian.net/browse/MOLI-2161
# ...    API: [device/check-phonecare-eligibility] new service api
# ...    Apidog: https://app.apidog.com/project/652757/apis/api-21833239?branchId=1064854    Env:[]   
# ...    Postman: https://digi-devops.postman.co/workspace/MOLI~d27d9e6a-6183-43fc-814c-c66688a09b8e/request/19640659-b5006e29-c3dc-4a0e-8859-542c4609b83f?action=share&source=copy-link&creator=47340208&ctx=documentation    Env:[moli-staging2-ngsa] 
# ...    POST 'https://d1dvzfm7v42b0o.cloudfront.net/moli-device/v1/phone-care/check-eligibility'

# ...    Description:    
# ...    Check with Asurion whether customer is eligible for PhoneCare. Only applicable for iPhone devices currently and purchase must be within 30 days
# ...    Device need to be sold in production
# ...    If subscriber already opt for PhoneCare, still eligible to opt for new PhoneCare (upgrade/downgrade)
# ...    No validation from MOLI, passthrough API. eg : PurchaseDate validation is from frontend

# ...    Notes:    
# ...    - `purchaseDate` and `deviceName` are mandatory.    
# ...    - `imei`, `msisdn`, `idNumber` and `idType` are optional.     

TC01 : Post Device Check Eligibility with valid subscriber (having contract device)[Digi]   
    ${accessToken}=    Get Access Token NGSA MOLI UAT
    ${deviceCheckEligibilityResponse}    ${status_code}=    Post Device Check Eligibility   ${accessToken}    imei=${BAU_DIGI_POSTPAID_IMEI_ELIGIBILITY}    phoneNo=${BAU_DIGI_POSTPAID_MSISDN_ELIGIBILITY}   idNumber=${BAU_DIGI_POSTPAID_IDNUMBER_ELIGIBILITY_}    idType=${BAU_DIGI_POSTPAID_IDTYPE_ELIGIBILITY}   purchaseDate=${BAU_DIGI_POSTPAID_PURCHASEDATE_ELIGIBILITY}    deviceName=${BAU_DIGI_POSTPAID_DEVICENAME_ELIGIBILITY}    
    Should Be Equal As Strings    ${status_code}    200

TC02 : Post Device Check Eligibility with valid subscriber (having contract device)[Celcom]
    ${accessToken}=    Get Access Token NGSA MOLI UAT
    ${deviceCheckEligibilityResponse}    ${status_code}=    Post Device Check Eligibility   ${accessToken}    imei=${BAU_CELCOM_POSTPAID_IMEI_ELIGIBILITY}    phoneNo=${BAU_CELCOM_POSTPAID_MSISDN_ELIGIBILITY}   idNumber=${BAU_CELCOM_POSTPAID_IDNUMBER_ELIGIBILITY_}    idType=${BAU_CELCOM_POSTPAID_IDTYPE_ELIGIBILITY}   purchaseDate=${BAU_CELCOM_POSTPAID_PURCHASEDATE_ELIGIBILITY}    deviceName=${BAU_CELCOM_POSTPAID_DEVICENAME_ELIGIBILITY}    
    Should Be Equal As Strings    ${status_code}    200

TC03 : Post Device Check Eligibility with invalid subscriber [non CelcomDigi]    
    ${accessToken}=    Get Access Token NGSA MOLI UAT
    ${deviceCheckEligibilityResponse}    ${status_code}=    Post Device Check Eligibility   ${accessToken}    imei=358863662510576    phoneNo=60196028285   idNumber=9208    idType=NRIC    purchaseDate=2025-09-30     deviceName=APPLE IPHONE 15 256GB BLK  
    Should Be Equal As Strings    ${status_code}    200    #able to see the eligibility as data is centralised in Asurion and MOLI have no control over it. Controlled by Channel(frontend)

TC04 : Post Device Check Eligibility without mandatory parameter(purchaseDate, deviceName)
    ${accessToken}=    Get Access Token NGSA MOLI UAT
    ${deviceCheckEligibilityResponse}    ${status_code}=    Post Device Check Eligibility   ${accessToken}    imei=${BAU_CELCOM_POSTPAID_IMEI_ELIGIBILITY}    phoneNo=${BAU_CELCOM_POSTPAID_MSISDN_ELIGIBILITY}   idNumber=${BAU_CELCOM_POSTPAID_IDNUMBER_ELIGIBILITY_}    idType=${BAU_CELCOM_POSTPAID_IDTYPE_ELIGIBILITY}       
    Should Be Equal As Strings    ${status_code}    422

TC05 : Post Device Check Eligibility without optional parameter(imei, msisdn, idNumber, idType)
    ${accessToken}=    Get Access Token NGSA MOLI UAT
    ${deviceCheckEligibilityResponse}    ${status_code}=    Post Device Check Eligibility   ${accessToken}    purchaseDate=${BAU_CELCOM_POSTPAID_PURCHASEDATE_ELIGIBILITY}    deviceName=${BAU_CELCOM_POSTPAID_DEVICENAME_ELIGIBILITY}    
    Should Be Equal As Strings    ${status_code}    200

TC06 : Post Device Check Eligibility without conditional mandatory parameter(idType)
    ${accessToken}=    Get Access Token NGSA MOLI UAT
    ${deviceCheckEligibilityResponse}    ${status_code}=    Post Device Check Eligibility   ${accessToken}    imei=${BAU_CELCOM_POSTPAID_IMEI_ELIGIBILITY}    phoneNo=${BAU_CELCOM_POSTPAID_MSISDN_ELIGIBILITY}   idNumber=${BAU_CELCOM_POSTPAID_IDNUMBER_ELIGIBILITY_}      purchaseDate=${BAU_CELCOM_POSTPAID_PURCHASEDATE_ELIGIBILITY}    deviceName=${BAU_CELCOM_POSTPAID_DEVICENAME_ELIGIBILITY}    
    Should Be Equal As Strings    ${status_code}    422

TC07 : Post Device Check Eligibility without request body
    ${accessToken}=    Get Access Token NGSA MOLI UAT
    ${deviceCheckEligibilityResponse}    ${status_code}=    Post Device Check Eligibility   ${accessToken} 
    Should Be Equal As Strings    ${status_code}    422

TC08 : Post Device Check Eligibility with empty string
    ${accessToken}=    Get Access Token NGSA MOLI UAT
    ${deviceCheckEligibilityResponse}    ${status_code}=    Post Device Check Eligibility   ${accessToken}    imei=${EMPTY}    phoneNo=${EMPTY}   idNumber=${EMPTY}    idType=${EMPTY}   purchaseDate=${EMPTY}    deviceName=${EMPTY}    
    Should Be Equal As Strings    ${status_code}    422

TC09 : Post Device Check Eligibility with invalid imei       
    ${accessToken}=    Get Access Token NGSA MOLI UAT
    ${deviceCheckEligibilityResponse}    ${status_code}=    Post Device Check Eligibility   ${accessToken}    imei=${INVALID_FORMAT}    phoneNo=${BAU_CELCOM_POSTPAID_MSISDN_ELIGIBILITY}   idNumber=${BAU_CELCOM_POSTPAID_IDNUMBER_ELIGIBILITY_}    idType=${BAU_CELCOM_POSTPAID_IDTYPE_ELIGIBILITY}   purchaseDate=${BAU_CELCOM_POSTPAID_PURCHASEDATE_ELIGIBILITY}    deviceName=${BAU_CELCOM_POSTPAID_DEVICENAME_ELIGIBILITY}    
    Should Be Equal As Strings    ${status_code}    200    #no validation from MOLI, passthrough API. Controlled by Channel(frontend) 

TC10 : Post Device Check Eligibility with invalid msisdn (invalid service number-incorrect format & less than 10 char)
    ${accessToken}=    Get Access Token NGSA MOLI UAT
    ${deviceCheckEligibilityResponse}    ${status_code}=    Post Device Check Eligibility   ${accessToken}    imei=${BAU_CELCOM_POSTPAID_IMEI_ELIGIBILITY}    phoneNo=${INVALID_FORMAT_MSISDN_SHORT}   idNumber=${BAU_CELCOM_POSTPAID_IDNUMBER_ELIGIBILITY_}    idType=${BAU_CELCOM_POSTPAID_IDTYPE_ELIGIBILITY}   purchaseDate=${BAU_CELCOM_POSTPAID_PURCHASEDATE_ELIGIBILITY}    deviceName=${BAU_CELCOM_POSTPAID_DEVICENAME_ELIGIBILITY}    
    Should Be Equal As Strings    ${status_code}    422

TC11 : Post Device Check Eligibility with invalid msisdn (invalid service number-incorrect format & more than 12 char)
    ${accessToken}=    Get Access Token NGSA MOLI UAT
    ${deviceCheckEligibilityResponse}    ${status_code}=    Post Device Check Eligibility   ${accessToken}    imei=${BAU_CELCOM_POSTPAID_IMEI_ELIGIBILITY}    phoneNo=${INVALID_FORMAT_MSISDN_LONG}   idNumber=${BAU_CELCOM_POSTPAID_IDNUMBER_ELIGIBILITY_}    idType=${BAU_CELCOM_POSTPAID_IDTYPE_ELIGIBILITY}   purchaseDate=${BAU_CELCOM_POSTPAID_PURCHASEDATE_ELIGIBILITY}    deviceName=${BAU_CELCOM_POSTPAID_DEVICENAME_ELIGIBILITY}    
    Should Be Equal As Strings    ${status_code}    422

TC12 : Post Device Check Eligibility with invalid msisdn (invalid service number-incorrect format)
    ${accessToken}=    Get Access Token NGSA MOLI UAT
    ${deviceCheckEligibilityResponse}    ${status_code}=    Post Device Check Eligibility   ${accessToken}    imei=${BAU_CELCOM_POSTPAID_IMEI_ELIGIBILITY}    phoneNo=${INVALID_FORMAT}   idNumber=${BAU_CELCOM_POSTPAID_IDNUMBER_ELIGIBILITY_}    idType=${BAU_CELCOM_POSTPAID_IDTYPE_ELIGIBILITY}   purchaseDate=${BAU_CELCOM_POSTPAID_PURCHASEDATE_ELIGIBILITY}    deviceName=${BAU_CELCOM_POSTPAID_DEVICENAME_ELIGIBILITY}    
    Should Be Equal As Strings    ${status_code}    422

TC13 : Post Device Check Eligibility with invalid msisdn (less than 10 char)
    ${accessToken}=    Get Access Token NGSA MOLI UAT
    ${deviceCheckEligibilityResponse}    ${status_code}=    Post Device Check Eligibility   ${accessToken}    imei=${BAU_CELCOM_POSTPAID_IMEI_ELIGIBILITY}    phoneNo=${INVALID_MSISDN_SHORT}   idNumber=${BAU_CELCOM_POSTPAID_IDNUMBER_ELIGIBILITY_}    idType=${BAU_CELCOM_POSTPAID_IDTYPE_ELIGIBILITY}   purchaseDate=${BAU_CELCOM_POSTPAID_PURCHASEDATE_ELIGIBILITY}    deviceName=${BAU_CELCOM_POSTPAID_DEVICENAME_ELIGIBILITY}    
    Should Be Equal As Strings    ${status_code}    422

TC14 : Post Device Check Eligibility with invalid msisdn (more than 12 char)
    ${accessToken}=    Get Access Token NGSA MOLI UAT
    ${deviceCheckEligibilityResponse}    ${status_code}=    Post Device Check Eligibility   ${accessToken}    imei=${BAU_CELCOM_POSTPAID_IMEI_ELIGIBILITY}    phoneNo=${INVALID_MSISDN_LONG}   idNumber=${BAU_CELCOM_POSTPAID_IDNUMBER_ELIGIBILITY}    idType=${BAU_CELCOM_POSTPAID_IDTYPE_ELIGIBILITY}   purchaseDate=${BAU_CELCOM_POSTPAID_PURCHASEDATE_ELIGIBILITY}    deviceName=${BAU_CELCOM_POSTPAID_DEVICENAME_ELIGIBILITY}    
    Should Be Equal As Strings    ${status_code}    422

TC15 : Post Device Check Eligibility with invalid idNumber  
    ${accessToken}=    Get Access Token NGSA MOLI UAT
    ${deviceCheckEligibilityResponse}    ${status_code}=    Post Device Check Eligibility   ${accessToken}    imei=${BAU_CELCOM_POSTPAID_IMEI_ELIGIBILITY}    phoneNo=${BAU_CELCOM_POSTPAID_MSISDN_ELIGIBILITY}   idNumber=${INVALID_FORMAT}    idType=${BAU_CELCOM_POSTPAID_IDTYPE_ELIGIBILITY}   purchaseDate=${BAU_CELCOM_POSTPAID_PURCHASEDATE_ELIGIBILITY}    deviceName=${BAU_CELCOM_POSTPAID_DEVICENAME_ELIGIBILITY}    
    Should Be Equal As Strings    ${status_code}    200     #no validation from MOLI, passthrough API. Controlled by Channel(frontend)

TC16 : Post Device Check Eligibility with invalid idNumber and idType (missmatch)     
    ${accessToken}=    Get Access Token NGSA MOLI UAT
    ${deviceCheckEligibilityResponse}    ${status_code}=    Post Device Check Eligibility   ${accessToken}    imei=${BAU_CELCOM_POSTPAID_IMEI_ELIGIBILITY}    phoneNo=${BAU_CELCOM_POSTPAID_MSISDN_ELIGIBILITY}   idNumber=${BAU_CELCOM_POSTPAID_IDNUMBER_ELIGIBILITY_}    idType=PASSPORT   purchaseDate=${BAU_CELCOM_POSTPAID_PURCHASEDATE_ELIGIBILITY}    deviceName=${BAU_CELCOM_POSTPAID_DEVICENAME_ELIGIBILITY}    
    Should Be Equal As Strings    ${status_code}    422     #limit to NRIC, hence PASSPORT is not within the allowed value   

TC17 : Post Device Check Eligibility with invalid idType (incorrect format)
    ${accessToken}=    Get Access Token NGSA MOLI UAT
    ${deviceCheckEligibilityResponse}    ${status_code}=    Post Device Check Eligibility   ${accessToken}    imei=${BAU_CELCOM_POSTPAID_IMEI_ELIGIBILITY}    phoneNo=${BAU_CELCOM_POSTPAID_MSISDN_ELIGIBILITY}  idNumber=${BAU_CELCOM_POSTPAID_IDNUMBER_ELIGIBILITY}    idType=${INVALID_FORMAT}   purchaseDate=${BAU_CELCOM_POSTPAID_PURCHASEDATE_ELIGIBILITY}    deviceName=${BAU_CELCOM_POSTPAID_DEVICENAME_ELIGIBILITY}    
    Should Be Equal As Strings    ${status_code}    422

TC18 : Post Device Check Eligibility with invalid purchaseDate (more than 30 days)[Digi]
    ${accessToken}=    Get Access Token NGSA MOLI UAT
    ${deviceCheckEligibilityResponse}    ${status_code}=    Post Device Check Eligibility   ${accessToken}    imei=${BAU_DIGI2_POSTPAID_IMEI_ELIGIBILITY}    phoneNo=${BAU_DIGI2_POSTPAID_MSISDN_ELIGIBILITY}   idNumber=${BAU_DIGI2_POSTPAID_IDNUMBER_ELIGIBILITY}    idType=${BAU_DIGI2_POSTPAID_IDTYPE_ELIGIBILITY}   purchaseDate=${BAU_DIGI2_POSTPAID_PURCHASEDATE_ELIGIBILITY}    deviceName=${BAU_DIGI2_POSTPAID_DEVICENAME_ELIGIBILITY}    
    Should Be Equal As Strings    ${status_code}    400

TC19 : Post Device Check Eligibility with invalid purchaseDate (more than 30 days)[Celcom]
    ${accessToken}=    Get Access Token NGSA MOLI UAT
    ${deviceCheckEligibilityResponse}    ${status_code}=    Post Device Check Eligibility   ${accessToken}    imei=${BAU_CELCOM2_POSTPAID_IMEI_ELIGIBILITY}    phoneNo=${BAU_CELCOM2_POSTPAID_MSISDN_ELIGIBILITY}   idNumber=${BAU_CELCOM2_POSTPAID_IDNUMBER_ELIGIBILITY}    idType=${BAU_CELCOM2_POSTPAID_IDTYPE_ELIGIBILITY}   purchaseDate=${BAU_CELCOM2_POSTPAID_PURCHASEDATE_ELIGIBILITY}    deviceName=${BAU_CELCOM2_POSTPAID_DEVICENAME_ELIGIBILITY}    
    Should Be Equal As Strings    ${status_code}    400

TC20 : Post Device Check Eligibility with invalid purchaseDate (incorrect format)
    ${accessToken}=    Get Access Token NGSA MOLI UAT
    ${deviceCheckEligibilityResponse}    ${status_code}=    Post Device Check Eligibility   ${accessToken}    imei=${BAU_CELCOM_POSTPAID_IMEI_ELIGIBILITY}    phoneNo=${BAU_CELCOM_POSTPAID_MSISDN_ELIGIBILITY}   idNumber=${BAU_CELCOM_POSTPAID_IDNUMBER_ELIGIBILITY}    idType=${BAU_CELCOM_POSTPAID_IDTYPE_ELIGIBILITY}   purchaseDate=${INVALID_FORMAT}    deviceName=${BAU_CELCOM_POSTPAID_DEVICENAME_ELIGIBILITY}    
    Should Be Equal As Strings    ${status_code}    422

TC21 : Post Device Check Eligibility with invalid deviceName
    ${accessToken}=    Get Access Token NGSA MOLI UAT
    ${deviceCheckEligibilityResponse}    ${status_code}=    Post Device Check Eligibility   ${accessToken}    imei=${BAU_CELCOM_POSTPAID_IMEI_ELIGIBILITY}    phoneNo=${BAU_CELCOM_POSTPAID_MSISDN_ELIGIBILITY}   idNumber=${BAU_CELCOM_POSTPAID_IDNUMBER_ELIGIBILITY}    idType=${BAU_CELCOM_POSTPAID_IDTYPE_ELIGIBILITY}   purchaseDate=${BAU_CELCOM_POSTPAID_PURCHASEDATE_ELIGIBILITY}   deviceName=${INVALID_FORMAT}    
    Should Be Equal As Strings    ${status_code}    400
