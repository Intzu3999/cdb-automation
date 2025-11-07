
*** Settings ***
Documentation    This file only share customer keywords only

Resource    ../MOLI-testSettings.robot

*** Keywords ***
#=====================NBC Customer========================
Get Customer
    [Arguments]    ${NBC_accessToken}    ${NBC_customer}

    # Create headers
    ${NBC_headers}=    Create Dictionary
    ...    Accept=*/*
    ...    Content-Type=application/x-www-form-urlencoded
    ...    Authorization=${NBC_accessToken}

    # Prepare request
    ${NBC_request}=    Create Dictionary
    ...    idType=${NBC_customer["idType"]}
    ...    idNumber=${NBC_customer["idNumber"]}

    # Call API
    Create Session    getcustomer    ${NBC_MOLI_BASE_URL}    headers=${NBC_headers}    verify=True
    ${NBC_response}=    Get On Session    getcustomer    ${NBC_GET_CUSTOMER}    params=${NBC_request}    expected_status=any
    ${NBC_body}=    Set Variable    ${NBC_response.json()}
    Log To Console    RESPONSE: ${NBC_body}

    # Default values
    ${NBC_customerProfile}=    Set Variable    New
    ${NBC_customerCoreId}=     Set Variable    None

    # Case 1: response is a list → Existing customer
    ${is_list}=    Evaluate    isinstance(${NBC_body}, list)
    IF    ${is_list}
        ${NBC_customerProfile}=    Set Variable    Existing
        ${NBC_customerCoreId}=     Set Variable    ${NBC_body[0]['customerId']}
    END

    # Case 2: response is dict with NotFoundError → New customer
    ${is_dict}=    Evaluate    isinstance(${NBC_body}, dict)
    IF    ${is_dict} and '${NBC_body.get("error")}' == 'NotFoundError'
        ${NBC_customerProfile}=    Set Variable    New
        ${NBC_customerCoreId}=     Set Variable    None
    END

    Log To Console    CUSTOMER PROFILE: ${NBC_customerProfile}
    Log To Console    CUSTOMER CORE ID: ${NBC_customerCoreId}

    RETURN    ${NBC_body}    ${NBC_customerProfile}    ${NBC_customerCoreId}



Extract Birthdate
    [Arguments]    ${NBC_customer}
    ${id_type}=    Set Variable    ${NBC_customer["idType"]}
    ${id_number}=  Set Variable    ${NBC_customer["idNumber"]}

    ${NBC_birthDate}=    Set Variable    None

    IF    '${id_type}' in ['New NRIC','MyTentera']
        ${year_prefix}=    Evaluate    "20" if int(${id_number}[0:2]) <= 21 else "19"
        ${NBC_birthDate}=    Evaluate    str(${year_prefix}) + str(${id_number}[0:2]) + "-" + str(${id_number}[2:4]) + "-" + str(${id_number}[4:6])
    ELSE IF    '${id_type}' in ['Passport','IMM13']
         ${NBC_birthDate}=    Set Variable    2000-01-01
    END

    Run Keyword If    '${NBC_birthDate}' == 'None'    Fail    Unable to determine DOB for ID Type: ${id_type}, Number: ${id_number}
    
    Log To Console    Extracted DOB: ${NBC_birthDate}
    RETURN     ${NBC_birthDate}

# Convert IdNumber To Birthdate
#     [Arguments]    ${NBC_idNumber}
#     ${yy}=    Evaluate    str(${NBC_idNumber})[0:2]
#     ${mm}=    Evaluate    str(${NBC_idNumber})[2:4]
#     ${dd}=    Evaluate    str(${NBC_idNumber})[4:6]
#     ${year}=    Evaluate    1900 + int(${yy}) if int(${yy}) > 30 else 2000 + int(${yy})
#     ${NBC_birthDate}=    Set Variable    ${year}-${mm}-${dd}
#     RETURN    ${NBC_birthDate}

