*** Settings ***
Library    RequestsLibrary
Library    JSONLibrary
Library    Collections
Library    BuiltIn

*** Variables ***
${BASE_URL}       https://d2vl1cpd9gu168.cloudfront.net
${AUTH_PATH}      /api/v1/auth/token
${APP_ID}         9bd77127-b8cb-4721-aac1-6d652df9314f
${APP_SECRET}     S2JoDuHqLY2DnDa9ErkQNLmYxXmdSlxwGdJnN8JY

*** Keywords ***
Generate Access Token
    [Documentation]    Calls the /api/v1/auth/token endpoint and returns a valid access token.
    Create Session    auth_session    ${BASE_URL}    verify=False

    &{headers}=    Create Dictionary
    ...    Content-Type=application/x-www-form-urlencoded
    &{data}=    Create Dictionary
    ...    app_id=${APP_ID}
    ...    app_secret=${APP_SECRET}

    Log To Console    \n🔹 Sending token request to ${BASE_URL}${AUTH_PATH}
    Log To Console    🔸 Request body: ${data}

    ${response}=    POST On Session
    ...    auth_session
    ...    ${AUTH_PATH}
    ...    data=${data}
    ...    headers=${headers}

    Log To Console    🔹 Response status: ${response.status_code}
    Log To Console    🔹 Response body: ${response.text}

    Should Be Equal As Integers    ${response.status_code}    200    Token API failed!

    ${json}=    Evaluate    json.loads('''${response.text}''')    json
    ${token}=    Get Value From Json    ${json}    $.data.access_token

    Log To Console    ✅ Token generated successfully: ${token}
    RETURN    ${token}

*** Test Cases ***
Validate Token API Returns 200
    [Documentation]    Simple test to verify that the token API returns 200 and a valid token.
    ${token}=    Generate Access Token
    Should Not Be Empty    ${token}    Token should not be empty
    Log To Console    🎯 Final token: ${token}
