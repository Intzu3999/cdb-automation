*** Settings ***
Library    RequestsLibrary
Library    Collections
Library    JSONLibrary
Library    BuiltIn
Library    String

*** Variables ***
${BASE_URL}           https://d2vl1cpd9gu168.cloudfront.net
${DEALER_PLANS_API}   /api/v2/dealer/plans
${CHANNEL_ID}         NGSA
${API_TOKEN}          119348|7wYDvt2vpBAmWsEnzq0Qbcg6j8QdaYQtanm5OSD5a0b93b8e

*** Keywords ***
Send Dealer Plans Request
    [Documentation]    Sends POST request to Dealer Plans API with static token
    &{headers}=    Create Dictionary
    ...    Accept=application/json
    ...    channelId=${CHANNEL_ID}
    ...    Content-Type=application/json
    ...    Authorization=Bearer ${API_TOKEN}

    &{body}=    Create Dictionary
    ...    account_type=POSTPAID
    ...    digi_dealer_id=INT01-B0006
    ...    telco_type=DIGI
    ...    digi_order_type=12
    ...    celcom_order_type=ChangePackage
    ...    order_segment=10
    ...    plan_type=PRIMARY
    ...    category=Pakej MegaJimat
    ...    subscriber_type=1
    ...    dealer_type=DEALER

    ${json_body}=    Evaluate    json.dumps(${body})    json
    Log To Console    🧾 Request Body: ${json_body}

    Create Session    dealer_session    ${BASE_URL}    verify=False
    ${response}=    POST On Session    dealer_session    ${DEALER_PLANS_API}    data=${json_body}    headers=${headers}

    Log To Console    📡 Status: ${response.status_code}
    Log To Console    🔍 Response: ${response.text}

    Should Be Equal As Integers    ${response.status_code}    200    Dealer Plans API failed with status ${response.status_code}!

    Delete All Sessions
    RETURN    ${response}

*** Test Cases ***
Validate Get Dealer Plans V2 API Returns 200
    [Documentation]    Verify Dealer Plans API returns 200 OK with static token
    ${response}=    Send Dealer Plans Request
    Log To Console    ✅ Dealer Plans API validated successfully
