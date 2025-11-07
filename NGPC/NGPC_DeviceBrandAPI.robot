*** Settings ***
Library    RequestsLibrary
Library    Collections
Library    BuiltIn

*** Variables ***
${BASE_URL}          https://d2vl1cpd9gu168.cloudfront.net
${DEVICE_BRANDS_API}  /api/v1/outright/device/brands
${API_TOKEN}         118296|yDvkwDpxZ2JExNn8F2PkFIJBkYrR2f3qK1nTFXfy19ea5fec
${CHANNEL_ID}        NGSA

*** Keywords ***
Get Device Brands
    [Documentation]    Sends GET request to Device Brands API matching your curl request
    &{headers}=    Create Dictionary
    ...    channelId=NGSA
    ...    Authorization=Bearer 119369|98SIZLjtdmeOWvfo7Jktx8yAZwscQymLWNJU897v1a832e6b

    Create Session    device_session    https://d2vl1cpd9gu168.cloudfront.net    verify=False
    ${response}=    GET On Session    device_session    /api/v1/outright/device/brands    headers=${headers}

    Log To Console    📡 Status: ${response.status_code}
    Log To Console    🔍 Response Body: ${response.text}

    Should Be Equal As Integers    ${response.status_code}    200    Device Brands API failed!
    RETURN    ${response}


*** Test Cases ***
Validate Get Device Brands API Returns 200
    [Documentation]    Verify that Device Brands API returns 200 OK
    ${response}=    Get Device Brands
    Log To Console    ✅ Device Brands API validated successfully
