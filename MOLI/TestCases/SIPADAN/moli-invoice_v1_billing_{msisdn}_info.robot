*** Settings ***
Documentation    This file to store test cases SIPADAN FEATURES only

# Resource    ../MOLI-testSettings.robot
# Resource    ../../TestKeywords/moli-sipadan-keywords.robot
Resource    ../../TestKeywords/all_keywords.robot

*** Test Cases ***

#     [Documentation]    
# ...    Ticket: https://celcomdigi.atlassian.net/browse/MOLI-2230
# ...    API: [invoice/get-billing-info] improve latency for CELCOM msisdn
# ...    Apidog: https://app.apidog.com/link/project/652757/apis/api-20020020    Env:[moli-staging-uat2]
# ...    Postman: https://digi-devops.postman.co/workspace/MOLI~d27d9e6a-6183-43fc-814c-c66688a09b8e/request/19640659-ac2201c6-a9b7-4662-9f2e-84d72cee1c5a?action=share&source=copy-link&creator=47340208&ctx=documentation    Env:[moli-staging2-ngsa] 
# ...    GET 'https://d31yztj5imu3ny.cloudfront.net/moli-invoice/v1/billing//info'

# ...    Description:    
# ...    This API will get you the account type of the customer, together with bill details, invoice date, outstanding amount, etc.

# ...    Notes:    
# ...    - `msisdn` is mandatory

TC01 : Get Billing Info with valid subscriber(Postpaid)[Digi] 
    ${accessToken}=    Get Access Token NGCA MOLI UAT
    ${billingInfoResponse}    ${status_code}=    Get Billing Info    ${accessToken}    phoneNo=${BAU_DIGI_POSTPAID_MSISDN_PRINCIPAL}
    Should Be Equal As Strings    ${status_code}    200

TC02 : Get Billing Info with valid subscriber(Postpaid)[Celcom] 
    ${accessToken}=    Get Access Token NGCA MOLI UAT
    ${billingInfoResponse}    ${status_code}=    Get Billing Info    ${accessToken}    phoneNo=${BAU_CELCOM_POSTPAID_MSISDN_PRINCIPAL}
    Should Be Equal As Strings    ${status_code}    200

TC03 : Get Billing Info with invalid subscriber(Postpaid)[non CelcomDigi] 
    ${accessToken}=    Get Access Token NGCA MOLI UAT
    ${billingInfoResponse}    ${status_code}=    Get Billing Info    ${accessToken}    phoneNo=${BAU_MAXIS_POSTPAID_MSISDN}
    Should Be Equal As Strings    ${status_code}    400

TC04 : Get Billing Info with valid subscriber(Prepaid)[Digi] 
    ${accessToken}=    Get Access Token NGCA MOLI UAT
    ${billingInfoResponse}    ${status_code}=    Get Billing Info    ${accessToken}    phoneNo=${BAU_DIGI_PREPAID_MSISDN}
    Should Be Equal As Strings    ${status_code}    200    //no validation for prepaid Digi

TC05 : Get Billing Info with valid subscriber(Prepaid)[Celcom] 
    ${accessToken}=    Get Access Token NGCA MOLI UAT
    ${billingInfoResponse}    ${status_code}=    Get Billing Info    ${accessToken}    phoneNo=${BAU_CELCOM_PREPAID_MSISDN}
    Should Be Equal As Strings    ${status_code}    400    //validation for prepaid Celcom

TC06 : Get Billing Info without mandatory parameter (msisdn)
    ${accessToken}=    Get Access Token NGCA MOLI UAT
    ${billingInfoResponse}    ${status_code}=    Get Billing Info    ${accessToken}    phoneNo=${EMPTY}
    Should Be Equal As Strings    ${status_code}    422

TC07 : Get Billing Info with invalid msisdn (invalid service number-incorrect format & less than 10 char)
    ${accessToken}=    Get Access Token NGCA MOLI UAT
    ${billingInfoResponse}    ${status_code}=    Get Billing Info    ${accessToken}    phoneNo=${INVALID_FORMAT_MSISDN_SHORT}
    Should Be Equal As Strings    ${status_code}    422

TC08 : Get Billing Info with invalid msisdn (invalid service number-incorrect format & more than 12 char)
    ${accessToken}=    Get Access Token NGCA MOLI UAT
    ${billingInfoResponse}    ${status_code}=    Get Billing Info    ${accessToken}    phoneNo=${INVALID_FORMAT_MSISDN_LONG}
    Should Be Equal As Strings    ${status_code}    422

TC09 : Get Billing Info with invalid msisdn (invalid service number-incorrect format)
    ${accessToken}=    Get Access Token NGCA MOLI UAT
    ${billingInfoResponse}    ${status_code}=    Get Billing Info    ${accessToken}    phoneNo=${INVALID_FORMAT}
    Should Be Equal As Strings    ${status_code}    422

TC10 : Get Billing Info with invalid msisdn (invalid service number-less than 10 char)
    ${accessToken}=    Get Access Token NGCA MOLI UAT
    ${billingInfoResponse}    ${status_code}=    Get Billing Info    ${accessToken}    phoneNo=${INVALID_MSISDN_SHORT}
    Should Be Equal As Strings    ${status_code}    422

TC11 : Get Billing Info with invalid msisdn (invalid service number-more than 12 char)
    ${accessToken}=    Get Access Token NGCA MOLI UAT
    ${billingInfoResponse}    ${status_code}=    Get Billing Info    ${accessToken}    phoneNo=${INVALID_MSISDN_LONG}
    Should Be Equal As Strings    ${status_code}    422

TC12 : Measure Latency For Billing Info (24 MSISDNs)
    ${accessToken}=    Get Access Token NGCA MOLI UAT
    ${latencies}=    Create List

    FOR    ${msisdn}    IN    @{MSISDN_LIST}
        ${latency}    ${traceId}=    Measure Billing Info Latency    ${accessToken}    ${msisdn}
        Append To List    ${latencies}    ${latency}
        Log To Console    \n⚡ Latency for ${msisdn}: ${latency} milliseconds
        Log To Console    X-Amzn-Trace-Id: ${traceId}
    END

    ${average}=    Evaluate    sum(${latencies}) / len(${latencies})
    ${fastest}=    Evaluate    min(${latencies})
    ${slowest}=    Evaluate    max(${latencies})
    ${summary}=    Catenate
    ...    \n=======================================
    ...    \nAverage : ${average}
    ...    \nFastest : ${fastest}
    ...    \nSlowest : ${slowest}
    ...    \n=======================================

    Log To Console    ${summary}
