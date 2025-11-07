*** Settings ***
Documentation    This file to store test cases only

# Resource    ../MOLI-testSettings.robot
Resource    ../TestKeywords/all_keywords.robot

*** Test Cases ***

Test Case 1: Retail - Prepaid eSIM - Single Line
    # Step 0: Generate Access Token
    ${NBC_accessToken}    Generate Access Token NBC
    # Step 1: Get Subscriber
    Download ESIM    NBC_accessToken=${NBC_accessToken}
    # Confrim ESIM
    ${NBC_msisdn}    Retrieve MSISDN    NBC_accessToken=${NBC_accessToken}
    Reserve MSISDN    NBC_accessToken=${NBC_accessToken}    NBC_msisdn=${NBC_msisdn}
    Get Customer    NBC_accessToken=${NBC_accessToken}    NBC_customer=xxxx
    # Customer Eligibility
    Prepaid New Registration    NBC_accessToken=xxx    NBC_customer=xxx    NBC_customerProfile=xxx    NBC_customerCoreId=xxx    NBC_birthDate=xxx    NBC_esimIccid=xxx    NBC_msisdnReserveId=xxx    NBC_msisdn=xxx
