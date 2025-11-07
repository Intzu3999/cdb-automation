*** Settings ***
Documentation    This file to store test cases SIPADAN FEATURES only

Resource    ../MOLI-testSettings.robot
Resource    ../../TestKeywords/moli-sipadan-keywords.robot

*** Test Cases ***

#     [Documentation]    
# ...    Ticket: https://celcomdigi.atlassian.net/browse/MOLI-2114
# ...    API: [addon/request-campaign-provision] new service api (celcom)
# ...    Apidog: Env:[moli-staging-uat]
# ...    Postman: Env:[moli-staging2-ngsa] 
# ...    POST 'https://d31yztj5imu3ny.cloudfront.net/moli-addon/v1/addon/campaign-provision'

# ...    Description:    
# ...    

# ...    Notes:    
# ...    - `action`, `msisdn`, `offeringId`, `source` are mandatory
#...     - `adjustmentCode`, `attributeList`, `endDate`, `serviceName`, `startDate`, `transactionId` are optional

TC01 : Post Addon Campaign Provisioning Request with valid subscriber (Postpaid)[Celcom] 
    ${accessToken}=    Get Access Token BAU
    ${a1}=    Create Dictionary    name=salesChannel    value=App
    ${a2}=    Create Dictionary    name=dealerCode    value=BCC10000KUL
    ${attributeList}=    Create List    ${a1}    ${a2}
    ${addOnCampaignProvisioningRequestResponse}    ${status_code}=    Post Addon Campaign Provisioning Request    ${accessToken}    action=Add    phoneNo=${BAU_CELCOM_POSTPAID_MSISDN_SUPPLEMENTARY}    offeringId=1006502    source=CMP    adjustmentCode=cbs_dynamic_adj    attributeList=${attributeList}    endDate=2025-11-27 12:53:37    serviceName=NA    startDate=2025-10-27 12:53:37   
    Should Be Equal As Strings    ${status_code}    200

TC02 : Post Addon Campaign Provisioning Request with valid subscriber (Prepaid)[Celcom]
    ${accessToken}=    Get Access Token BAU
    ${a1}=    Create Dictionary    name=salesChannel    value=App
    ${a2}=    Create Dictionary    name=dealerCode    value=BCC10000KUL
    ${attributeList}=    Create List    ${a1}    ${a2}
    ${addOnCampaignProvisioningRequestResponse}    ${status_code}=    Post Addon Campaign Provisioning Request    ${accessToken}    action=Add    phoneNo=${BAU_CELCOM_PREPAID_MSISDN}    offeringId=1006389    source=CMP    adjustmentCode=cbs_dynamic_adj    attributeList=${attributeList}    endDate=2025-11-27 12:53:37    serviceName=NA    startDate=2025-10-27 12:53:37   
    Should Be Equal As Strings    ${status_code}    200

TC03 : Post Addon Campaign Provisioning Request with valid subscriber (Postpaid)[Digi] 
    ${accessToken}=    Get Access Token BAU
    ${a1}=    Create Dictionary    name=salesChannel    value=App
    ${a2}=    Create Dictionary    name=dealerCode    value=BCC10000KUL
    ${attributeList}=    Create List    ${a1}    ${a2}
    ${addOnCampaignProvisioningRequestResponse}    ${status_code}=    Post Addon Campaign Provisioning Request    ${accessToken}    action=Add    phoneNo=${BAU_DIGI_POSTPAID_MSISDN_PRINCIPAL}    offeringId=1006502    source=CMP    adjustmentCode=cbs_dynamic_adj    attributeList=${attributeList}    endDate=2025-11-27 12:53:37    serviceName=NA    startDate=2025-10-27 12:53:37   
    Should Be Equal As Strings    ${status_code}    501

TC04 : Post Addon Campaign Provisioning Request with valid subscriber (Prepaid)[Digi] 
    ${accessToken}=    Get Access Token BAU
    ${a1}=    Create Dictionary    name=salesChannel    value=App
    ${a2}=    Create Dictionary    name=dealerCode    value=BCC10000KUL
    ${attributeList}=    Create List    ${a1}    ${a2}
    ${addOnCampaignProvisioningRequestResponse}    ${status_code}=    Post Addon Campaign Provisioning Request    ${accessToken}    action=Add    phoneNo=${BAU_DIGI_PREPAID_MSISDN}    offeringId=1006502    source=CMP    adjustmentCode=cbs_dynamic_adj    attributeList=${attributeList}    endDate=2025-11-27 12:53:37    serviceName=NA    startDate=2025-10-27 12:53:37   
    Should Be Equal As Strings    ${status_code}    501

TC05 : Post Addon Campaign Provisioning Request with valid subscriber [non CelcomDigi]
    ${accessToken}=    Get Access Token BAU
    ${a1}=    Create Dictionary    name=salesChannel    value=App
    ${a2}=    Create Dictionary    name=dealerCode    value=BCC10000KUL
    ${attributeList}=    Create List    ${a1}    ${a2}
    ${addOnCampaignProvisioningRequestResponse}    ${status_code}=    Post Addon Campaign Provisioning Request    ${accessToken}    action=Add    phoneNo=${BAU_MAXIS_POSTPAID_MSISDN}    offeringId=2040764    source=CMP    adjustmentCode=cbs_dynamic_adj    attributeList=${attributeList}    endDate=2025-11-27 12:53:37    serviceName=NA    startDate=2025-10-27 12:53:37   
    Should Be Equal As Strings    ${status_code}    400

TC06 : Post Addon Campaign Provisioning Request without mandatory parameter (action, msisdn, offeringId, source)
    ${accessToken}=    Get Access Token BAU
    ${a1}=    Create Dictionary    name=salesChannel    value=App
    ${a2}=    Create Dictionary    name=dealerCode    value=BCC10000KUL
    ${attributeList}=    Create List    ${a1}    ${a2}
    ${addOnCampaignProvisioningRequestResponse}    ${status_code}=    Post Addon Campaign Provisioning Request    ${accessToken}    adjustmentCode=cbs_dynamic_adj    attributeList=${attributeList}    endDate=2025-11-27 12:53:37    serviceName=NA    startDate=2025-10-27 12:53:37   
    Should Be Equal As Strings    ${status_code}    422

TC07 : Post Addon Campaign Provisioning Request without optional parameter (adjustmentCode, attributeList, endDate, serviceName, startDate, transactionId)
    ${accessToken}=    Get Access Token BAU
    ${a1}=    Create Dictionary    name=salesChannel    value=App
    ${a2}=    Create Dictionary    name=dealerCode    value=BCC10000KUL
    ${attributeList}=    Create List    ${a1}    ${a2}
    ${addOnCampaignProvisioningRequestResponse}    ${status_code}=    Post Addon Campaign Provisioning Request    ${accessToken}    action=Add    phoneNo=${BAU_CELCOM_POSTPAID_MSISDN_PRINCIPAL}    offeringId=1006502    source=CMP    transactionId=ANYVALUE
    Should Be Equal As Strings    ${status_code}    200

TC08 : Post Addon Campaign Provisioning Request without request body
    ${accessToken}=    Get Access Token BAU
    ${addOnCampaignProvisioningRequestResponse}    ${status_code}=    Post Addon Campaign Provisioning Request    ${accessToken}  transactionId=ANYVALUE
    Should Be Equal As Strings    ${status_code}    422

TC09 : Post Addon Campaign Provisioning Request with empty string
    ${accessToken}=    Get Access Token BAU
    ${a1}=    Create Dictionary    name=${EMPTY}    value=${EMPTY}
    ${a2}=    Create Dictionary    name=${EMPTY}    value=${EMPTY}
    ${attributeList}=    Create List    ${a1}    ${a2}
    ${addOnCampaignProvisioningRequestResponse}    ${status_code}=    Post Addon Campaign Provisioning Request    ${accessToken}    action=${EMPTY}    phoneNo=${EMPTY}    offeringId=${EMPTY}    source=${EMPTY}    adjustmentCode=${EMPTY}    attributeList=${attributeList}    endDate=${EMPTY}    serviceName=${EMPTY}    startDate=${EMPTY}    transactionId=${EMPTY}
    Should Be Equal As Strings    ${status_code}    422

TC10 : Post Addon Campaign Provisioning Request with valid subscriber (Postpaid)[Celcom] with Prepaid offering
    ${accessToken}=    Get Access Token BAU
    ${a1}=    Create Dictionary    name=salesChannel    value=App
    ${a2}=    Create Dictionary    name=dealerCode    value=BCC10000KUL
    ${attributeList}=    Create List    ${a1}    ${a2}
    ${addOnCampaignProvisioningRequestResponse}    ${status_code}=    Post Addon Campaign Provisioning Request    ${accessToken}    action=Add    phoneNo=${BAU_CELCOM_POSTPAID_MSISDN_PRINCIPAL}    offeringId=2040764    source=CMP    adjustmentCode=cbs_dynamic_adj    attributeList=${attributeList}    endDate=2025-11-27 12:53:37    serviceName=NA    startDate=2025-10-27 12:53:37   
    Should Be Equal As Strings    ${status_code}    400

TC11 : Post Addon Campaign Provisioning Request with valid subscriber (Prepaid)[Celcom] with Postpaid offering
    ${accessToken}=    Get Access Token BAU
    ${a1}=    Create Dictionary    name=salesChannel    value=App
    ${a2}=    Create Dictionary    name=dealerCode    value=BCC10000KUL
    ${attributeList}=    Create List    ${a1}    ${a2}
    ${addOnCampaignProvisioningRequestResponse}    ${status_code}=    Post Addon Campaign Provisioning Request    ${accessToken}    action=Add    phoneNo=${BAU_CELCOM_PREPAID_MSISDN}    offeringId=1006502    source=CMP    adjustmentCode=cbs_dynamic_adj    attributeList=${attributeList}    endDate=2025-11-27 12:53:37    serviceName=NA    startDate=2025-10-27 12:53:37   
    Should Be Equal As Strings    ${status_code}    400

TC12 : Post Addon Campaign Provisioning Request with valid subscriber (duplicate-has been exist)
    ${accessToken}=    Get Access Token BAU
    ${a1}=    Create Dictionary    name=salesChannel    value=App
    ${a2}=    Create Dictionary    name=dealerCode    value=BCC10000KUL
    ${attributeList}=    Create List    ${a1}    ${a2}
    ${addOnCampaignProvisioningRequestResponse}    ${status_code}=    Post Addon Campaign Provisioning Request    ${accessToken}    action=Add    phoneNo=${BAU_CELCOM_POSTPAID_MSISDN_SUPPLEMENTARY}    offeringId=1006502    source=CMP    adjustmentCode=cbs_dynamic_adj    attributeList=${attributeList}    endDate=2025-11-27 12:53:37    serviceName=NA    startDate=2025-10-27 12:53:37   
    Should Be Equal As Strings    ${status_code}    200    #1006502 : Monthly Internet Add On 5GB    #since offer still active in CXI/CRM, hence no new usage created, offers is being replaced with new timestamp    #operation success as no checking on MOLI side, passthrough the value

TC13 : Post Addon Campaign Provisioning Request with invalid action
    ${accessToken}=    Get Access Token BAU
    ${a1}=    Create Dictionary    name=salesChannel    value=App
    ${a2}=    Create Dictionary    name=dealerCode    value=BCC10000KUL
    ${attributeList}=    Create List    ${a1}    ${a2}
    ${addOnCampaignProvisioningRequestResponse}    ${status_code}=    Post Addon Campaign Provisioning Request    ${accessToken}    action=Remove    phoneNo=${BAU_CELCOM_PREPAID_MSISDN}    offeringId=1006502    source=CMP    adjustmentCode=cbs_dynamic_adj    attributeList=${attributeList}    endDate=2025-11-27 12:53:37    serviceName=NA    startDate=2025-10-27 12:53:37   
    Should Be Equal As Strings    ${status_code}    400    #forwarding the same error from IGW

TC14 : Post Addon Campaign Provisioning Request with invalid msisdn (invalid service number-incorrect format & less than 10 char)
    ${accessToken}=    Get Access Token BAU
    ${a1}=    Create Dictionary    name=salesChannel    value=App
    ${a2}=    Create Dictionary    name=dealerCode    value=BCC10000KUL
    ${attributeList}=    Create List    ${a1}    ${a2}
    ${addOnCampaignProvisioningRequestResponse}    ${status_code}=    Post Addon Campaign Provisioning Request    ${accessToken}    action=Remove    phoneNo=${INVALID_FORMAT_MSISDN_SHORT}    offeringId=1006502    source=CMP    adjustmentCode=cbs_dynamic_adj    attributeList=${attributeList}    endDate=2025-11-27 12:53:37    serviceName=NA    startDate=2025-10-27 12:53:37   
    Should Be Equal As Strings    ${status_code}    422

TC15 : Post Addon Campaign Provisioning Request with invalid msisdn (invalid service number-incorrect format & more than 12 char)
    ${accessToken}=    Get Access Token BAU
    ${a1}=    Create Dictionary    name=salesChannel    value=App
    ${a2}=    Create Dictionary    name=dealerCode    value=BCC10000KUL
    ${attributeList}=    Create List    ${a1}    ${a2}
    ${addOnCampaignProvisioningRequestResponse}    ${status_code}=    Post Addon Campaign Provisioning Request    ${accessToken}    action=Remove    phoneNo=${INVALID_FORMAT_MSISDN_LONG}    offeringId=1006502    source=CMP    adjustmentCode=cbs_dynamic_adj    attributeList=${attributeList}    endDate=2025-11-27 12:53:37    serviceName=NA    startDate=2025-10-27 12:53:37   
    Should Be Equal As Strings    ${status_code}    422

TC16 : Post Addon Campaign Provisioning Request with invalid msisdn (invalid service number-incorrect format)
    ${accessToken}=    Get Access Token BAU
    ${a1}=    Create Dictionary    name=salesChannel    value=App
    ${a2}=    Create Dictionary    name=dealerCode    value=BCC10000KUL
    ${attributeList}=    Create List    ${a1}    ${a2}
    ${addOnCampaignProvisioningRequestResponse}    ${status_code}=    Post Addon Campaign Provisioning Request    ${accessToken}    action=Remove    phoneNo=${INVALID_FORMAT}    offeringId=1006502    source=CMP    adjustmentCode=cbs_dynamic_adj    attributeList=${attributeList}    endDate=2025-11-27 12:53:37    serviceName=NA    startDate=2025-10-27 12:53:37   
    Should Be Equal As Strings    ${status_code}    422

TC17 : Post Addon Campaign Provisioning Request with invalid msisdn (invalid service number-less than 10 char)
    ${accessToken}=    Get Access Token BAU
    ${a1}=    Create Dictionary    name=salesChannel    value=App
    ${a2}=    Create Dictionary    name=dealerCode    value=BCC10000KUL
    ${attributeList}=    Create List    ${a1}    ${a2}
    ${addOnCampaignProvisioningRequestResponse}    ${status_code}=    Post Addon Campaign Provisioning Request    ${accessToken}    action=Remove    phoneNo=${INVALID_MSISDN_SHORT}    offeringId=1006502    source=CMP    adjustmentCode=cbs_dynamic_adj    attributeList=${attributeList}    endDate=2025-11-27 12:53:37    serviceName=NA    startDate=2025-10-27 12:53:37   
    Should Be Equal As Strings    ${status_code}    422

TC18 : Post Addon Campaign Provisioning Request with invalid msisdn (invalid service number-more than 12 char)
    ${accessToken}=    Get Access Token BAU
    ${a1}=    Create Dictionary    name=salesChannel    value=App
    ${a2}=    Create Dictionary    name=dealerCode    value=BCC10000KUL
    ${attributeList}=    Create List    ${a1}    ${a2}
    ${addOnCampaignProvisioningRequestResponse}    ${status_code}=    Post Addon Campaign Provisioning Request    ${accessToken}    action=Remove    phoneNo=${INVALID_MSISDN_LONG}    offeringId=1006502    source=CMP    adjustmentCode=cbs_dynamic_adj    attributeList=${attributeList}    endDate=2025-11-27 12:53:37    serviceName=NA    startDate=2025-10-27 12:53:37   
    Should Be Equal As Strings    ${status_code}    422

TC19 : Post Addon Campaign Provisioning Request with invalid offerId
    ${accessToken}=    Get Access Token BAU
    ${a1}=    Create Dictionary    name=salesChannel    value=App
    ${a2}=    Create Dictionary    name=dealerCode    value=BCC10000KUL
    ${attributeList}=    Create List    ${a1}    ${a2}
    ${addOnCampaignProvisioningRequestResponse}    ${status_code}=    Post Addon Campaign Provisioning Request    ${accessToken}    action=Add    phoneNo=${BAU_CELCOM_POSTPAID_MSISDN_PRINCIPAL}    offeringId=100650u    source=CMP    adjustmentCode=cbs_dynamic_adj    attributeList=${attributeList}    endDate=2025-11-27 12:53:37    serviceName=NA    startDate=2025-10-27 12:53:37   
    Should Be Equal As Strings    ${status_code}    400    #forwarding the same error from IGW

TC20 : Post Addon Campaign Provisioning Request with invalid source
    ${accessToken}=    Get Access Token BAU
    ${a1}=    Create Dictionary    name=salesChannel    value=App
    ${a2}=    Create Dictionary    name=dealerCode    value=BCC10000KUL
    ${attributeList}=    Create List    ${a1}    ${a2}
    ${addOnCampaignProvisioningRequestResponse}    ${status_code}=    Post Addon Campaign Provisioning Request    ${accessToken}    action=Add    phoneNo=${BAU_CELCOM_POSTPAID_MSISDN_PRINCIPAL}    offeringId=1006502    source=${INVALID_LONG}    adjustmentCode=cbs_dynamic_adj    attributeList=${attributeList}    endDate=2025-11-27 12:53:37    serviceName=NA    startDate=2025-10-28 00:00:37   
    Should Be Equal As Strings    ${status_code}    200    #1006502 : Monthly Internet Add On 5GB    #since offer still active in CXI/CRM, hence no new usage created, offers is being replaced with new timestamp    #operation success as no checking on MOLI side, passthrough the value

TC21 : Post Addon Campaign Provisioning Request with invalid adjustmentCode
    ${accessToken}=    Get Access Token BAU
    ${a1}=    Create Dictionary    name=salesChannel    value=App
    ${a2}=    Create Dictionary    name=dealerCode    value=BCC10000KUL
    ${attributeList}=    Create List    ${a1}    ${a2}
    ${addOnCampaignProvisioningRequestResponse}    ${status_code}=    Post Addon Campaign Provisioning Request    ${accessToken}    action=Add    phoneNo=${BAU_CELCOM_POSTPAID_MSISDN_PRINCIPAL}    offeringId=1006502    source=CMP   adjustmentCode=${INVALID_LONG}    attributeList=${attributeList}    endDate=2025-11-27 12:53:37    serviceName=NA    startDate=2025-10-28 00:00:37   
    Should Be Equal As Strings    ${status_code}    200    #1006502 : Monthly Internet Add On 5GB    #since offer still active in CXI/CRM, hence no new usage created, offers is being replaced with new timestamp    #operation success as no checking on MOLI side, passthrough the value

TC22 : Post Addon Campaign Provisioning Request with invalid attributeList
    ${accessToken}=    Get Access Token BAU
    ${a1}=    Create Dictionary    name=price    value=20
    ${a2}=    Create Dictionary    name=cReasonFee    value=0
    ${a3}=    Create Dictionary    name=salesChannel    value=App
    ${a4}=    Create Dictionary    name=dealerCode    value=ABC
    ${a5}=    Create Dictionary    name=quota    value=5
    ${a6}=    Create Dictionary    name=dmiQuota    value=0
    ${attributeList}=    Create List    ${a1}    ${a2}    ${a3}    ${a4}    ${a5}    ${a6}
    ${addOnCampaignProvisioningRequestResponse}    ${status_code}=    Post Addon Campaign Provisioning Request    ${accessToken}    action=Add    phoneNo=${BAU_CELCOM_POSTPAID_MSISDN_PRINCIPAL}    offeringId=1006502    source=CMP   adjustmentCode=${INVALID_LONG}    attributeList=${attributeList}    endDate=2025-11-27 12:53:37    serviceName=NA    startDate=2025-10-28 00:00:37   
    Should Be Equal As Strings    ${status_code}    400    #forwarding the same error from IGW

TC23 : Post Addon Campaign Provisioning Request with invalid endDate
    ${accessToken}=    Get Access Token BAU
    ${a1}=    Create Dictionary    name=salesChannel    value=App
    ${a2}=    Create Dictionary    name=dealerCode    value=BCC10000KUL
    ${attributeList}=    Create List    ${a1}    ${a2}
    ${addOnCampaignProvisioningRequestResponse}    ${status_code}=    Post Addon Campaign Provisioning Request    ${accessToken}    action=Add    phoneNo=${BAU_CELCOM_POSTPAID_MSISDN_PRINCIPAL}    offeringId=1006502    source=CMP   adjustmentCode=cbs_dynamic_adj    attributeList=${attributeList}    endDate=${INVALID_LONG}    serviceName=NA    startDate=2025-10-28 00:00:37   
    Should Be Equal As Strings    ${status_code}    422    #forwarding the same error from IGW

C24 : Post Addon Campaign Provisioning Request with invalid endDate (backdated endDate and startDate)
    ${accessToken}=    Get Access Token BAU
    ${a1}=    Create Dictionary    name=salesChannel    value=App
    ${a2}=    Create Dictionary    name=dealerCode    value=BCC10000KUL
    ${attributeList}=    Create List    ${a1}    ${a2}
    ${addOnCampaignProvisioningRequestResponse}    ${status_code}=    Post Addon Campaign Provisioning Request    ${accessToken}    action=Add    phoneNo=${BAU_CELCOM_POSTPAID_MSISDN_PRINCIPAL}    offeringId=1006502    source=CMP   adjustmentCode=cbs_dynamic_adj    attributeList=${attributeList}    endDate=2000-11-27 12:53:37    serviceName=NA    startDate=2000-11-20 12:53:37   
    Should Be Equal As Strings    ${status_code}    200    #no validation    #no checking on MOLI side, passthrough the value

C25 : Post Addon Campaign Provisioning Request with invalid endDate (endDate < startDate)
    ${accessToken}=    Get Access Token BAU
    ${a1}=    Create Dictionary    name=salesChannel    value=App
    ${a2}=    Create Dictionary    name=dealerCode    value=BCC10000KUL
    ${attributeList}=    Create List    ${a1}    ${a2}
    ${addOnCampaignProvisioningRequestResponse}    ${status_code}=    Post Addon Campaign Provisioning Request    ${accessToken}    action=Add    phoneNo=${BAU_CELCOM_POSTPAID_MSISDN_PRINCIPAL}    offeringId=1006502    source=CMP   adjustmentCode=cbs_dynamic_adj    attributeList=${attributeList}    endDate=2026-11-01 12:53:37    serviceName=NA    startDate=2026-11-05 00:00:37   
    Should Be Equal As Strings    ${status_code}    200    #no validation    #no checking on MOLI side, passthrough the value

C26 : Post Addon Campaign Provisioning Request with invalid serviceName
    ${accessToken}=    Get Access Token BAU
    ${a1}=    Create Dictionary    name=salesChannel    value=App
    ${a2}=    Create Dictionary    name=dealerCode    value=BCC10000KUL
    ${attributeList}=    Create List    ${a1}    ${a2}
    ${addOnCampaignProvisioningRequestResponse}    ${status_code}=    Post Addon Campaign Provisioning Request    ${accessToken}    action=Add    phoneNo=${BAU_CELCOM_POSTPAID_MSISDN_PRINCIPAL}    offeringId=1006502    source=CMP   adjustmentCode=cbs_dynamic_adj    attributeList=${attributeList}    endDate=2026-11-10 12:53:37    serviceName=${INVALID_LONG}    startDate=2026-11-01 00:00:37   
    Should Be Equal As Strings    ${status_code}    200    #no validation    #no checking on MOLI side, passthrough the value

C27 : Post Addon Campaign Provisioning Request with invalid transactionId
    ${accessToken}=    Get Access Token BAU
    ${a1}=    Create Dictionary    name=salesChannel    value=App
    ${a2}=    Create Dictionary    name=dealerCode    value=BCC10000KUL
    ${attributeList}=    Create List    ${a1}    ${a2}
    ${addOnCampaignProvisioningRequestResponse}    ${status_code}=    Post Addon Campaign Provisioning Request    ${accessToken}    action=Add    phoneNo=${BAU_CELCOM_POSTPAID_MSISDN_PRINCIPAL}    offeringId=1006502    source=CMP   adjustmentCode=cbs_dynamic_adj    attributeList=${attributeList}    endDate=2026-11-10 12:53:37    serviceName=NA    startDate=2026-11-01 00:00:37    transactionId=${INVALID_LONG}
    Should Be Equal As Strings    ${status_code}    200    #no validation    #no checking on MOLI side, passthrough the value
