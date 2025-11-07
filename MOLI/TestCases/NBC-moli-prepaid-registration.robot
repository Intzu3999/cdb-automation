*** Settings ***
Documentation    This file to store test cases only

# Resource    ../MOLI-testSettings.robot
Resource    ../TestKeywords/all_keywords.robot

*** Test Cases ***
Test Case 1: NBC Prepaid eSIM - New Customer
    ${NBC_accessToken}    Generate Access Token NBC
    ${NBC_body}    ${NBC_customerProfile}    ${NBC_customerCoreId}=    Get Customer    ${NBC_accessToken}    ${NBC_NEW_CUSTOMER}
    Log To Console    Profile: ${NBC_customerProfile} | CustomerId: ${NBC_customerCoreId}
    ${NBC_eligibility_response}    ${NBC_birthDate}=    Check Prepaid Eligibility    ${NBC_accessToken}    ${NBC_NEW_CUSTOMER}
    Log To Console    ${NBC_eligibility_response.json()}
    ${NBC_esimIccid}=    Download ESIM    ${NBC_accessToken}
    Log To Console    eSIM ICCID: ${NBC_esimIccid}
    ${confirm_response}=    Confirm ESIM    ${NBC_accessToken}    ${NBC_esimIccid}
    ${NBC_msisdn}    Retrieve MSISDN    ${NBC_accessToken}
    Log To Console    Retrieved MSISDN: ${NBC_msisdn}
    ${NBC_msisdnReserveId}=    Reserve MSISDN    ${NBC_accessToken}    ${NBC_msisdn}
    Log To Console    Reserved MSISDN: ${NBC_msisdn} with Reservation ID: ${NBC_msisdnReserveId}
    ${NBC_orderId}=    Prepaid New Registration    ${NBC_accessToken}    ${NBC_NEW_CUSTOMER}    new    ${None}    ${NBC_birthDate}    ${NBC_esimIccid}    ${NBC_msisdnReserveId}    ${NBC_msisdn}
    Log To Console    OrderID: ${NBC_orderId}

