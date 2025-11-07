*** Settings ***
Documentation    This file only share lightningsim keywords only

Resource    ../MOLI-testSettings.robot

*** Keywords ***
#=====================NBC LightningSIM Order========================#
Prepaid New Registration
    [Arguments]     ${NBC_accessToken}    ${NBC_customer}     ${NBC_customerProfile}    ${NBC_customerCoreId}    ${NBC_birthDate}    ${NBC_esimIccid}    ${NBC_msisdnReserveId}    ${NBC_msisdn}
    
    Run Keyword If    '${NBC_customerProfile}' == 'Existing'
    ...    Existing Customer LightningSIM Registration    ${NBC_accessToken}    ${NBC_customer}    ${NBC_customerCoreId}    ${NBC_birthDate}    ${NBC_esimIccid}    ${NBC_msisdn}    ${NBC_msisdnReserveId}   
    ...    ELSE
    ...    New Customer LightningSIM Registration    ${NBC_accessToken}    ${NBC_customer}    ${NBC_birthDate}    ${NBC_esimIccid}    ${NBC_msisdn}    ${NBC_msisdnReserveId}

New Customer LightningSIM Registration
    [Arguments]    ${NBC_accessToken}    ${NBC_customer}    ${NBC_birthDate}    ${NBC_esimIccid}    ${NBC_msisdn}    ${NBC_msisdnReserveId}
    
    ${NBC_headers}=    Create Dictionary
    ...    Accept=*/*
    ...    Content-Type=application/json
    ...    Authorization=${NBC_accessToken}

    # ========== Note ==========
    ${NBC_note_dict}=    Create Dictionary    author=S0002935061    text=NEW_ORDER_VALIDATION    type=Note
    ${NBC_note}=    Create List    ${NBC_note_dict}

    # ========== Language ==========
    ${NBC_languageAbility_dict}=    Create Dictionary    languageName=English    isFavouriteLanguage=${true}
    ${NBC_languageAbility}=    Create List    ${NBC_languageAbility_dict}

    # ========== Identification ==========
    ${NBC_identification_dict}=    Create Dictionary    identificationId=${NBC_customer['idNumber']}    identificationType=${NBC_customer['idType']}
    ${NBC_individualIdentification}=    Create List    ${NBC_identification_dict}

    # ========== Party Characteristics ==========
    ${NBC_pc1}=    Create Dictionary    name=mothermaidenname    value=Moli Automation
    ${NBC_pc2}=    Create Dictionary    name=race    value=Others
    ${NBC_pc3}=    Create Dictionary    name=authenticationMode    value=OCR
    ${NBC_pc4}=    Create Dictionary    name=customersegment    value=Retail
    ${NBC_pc5}=    Create Dictionary    name=customerCategory    value=Consumer
    ${NBC_pc6}=    Create Dictionary    name=preferredContactType    value=SMS
    ${NBC_pc7}=    Create Dictionary    name=preferredContactTime    value=9_12
    ${NBC_partyCharacteristics}=    Create List    ${NBC_pc1}    ${NBC_pc2}    ${NBC_pc3}    ${NBC_pc4}    ${NBC_pc5}    ${NBC_pc6}    ${NBC_pc7}

    # ========== Contact Medium ==========
    ${NBC_cm1}=    Create Dictionary    type=PhoneContactMedium    contactType=homePhone    phoneNumber=${NBC_msisdn}
    ${NBC_cm2}=    Create Dictionary    type=PhoneContactMedium    contactType=alternatePhone    phoneNumber=${NBC_msisdn}
    ${NBC_cm3}=    Create Dictionary    type=GeographicAddressContactMedium    contactType=RESIDENTIAL    city=KLUANG    country=MYS    postCode=86000    street1=CelcomDigi Tower    street2=Level 23 Forest Area    stateOrProvince=KL
    ${NBC_cm4}=    Create Dictionary    type=EmailContactMedium    contactType=personalEmail    emailAddress=raafiq.rahalim@gmail.com
    ${NBC_cm5}=    Create Dictionary    type=SocialContactMedium    contactType=whatsApp    socialNetworkId=${NBC_msisdn}
    ${NBC_contactMedium}=    Create List    ${NBC_cm1}    ${NBC_cm2}    ${NBC_cm3}    ${NBC_cm4}    ${NBC_cm5}

    # ========== Party ==========
    ${NBC_party_dict}=    Create Dictionary
    ...    type=Individual
    ...    role=Customer
    ...    givenName=Afiq Qa
    ...    title=Mr.
    ...    familyName=Automation
    ...    gender=Male
    ...    nationality=Malaysia
    ...    birthDate=${NBC_birthDate}
    ...    countryOfBirth=Malaysia
    ...    languageAbility=${NBC_languageAbility}
    ...    individualIdentification=${NBC_individualIdentification}
    ...    partyCharacteristics=${NBC_partyCharacteristics}
    ...    contactMedium=${NBC_contactMedium}
    ${NBC_party}=    Create List    ${NBC_party_dict}

    # ========== Related Sites ==========
    ${NBC_relatedSites_dict}=    Create Dictionary    id=region Id    role=REGION    name=SOUTHERN
    ${NBC_relatedSites}=    Create List    ${NBC_relatedSites_dict}

    # ========== Related Party ==========
    ${NBC_dealer}=    Create Dictionary    id=CKL89999    name=dealername    referredType=Organization
    ${NBC_salesRep}=    Create Dictionary    id=S0644908889    name=salesRepName    referredType=Individual
    ${NBC_partner}=    Create Dictionary    id=P326763264    name=salesRepName    referredType=Individual
    ${NBC_rp1}=    Create Dictionary    role=Dealer    partyOrPartyRole=${NBC_dealer}
    ${NBC_rp2}=    Create Dictionary    role=SalesRep    partyOrPartyRole=${NBC_salesRep}
    ${NBC_rp3}=    Create Dictionary    role=Partner    partyOrPartyRole=${NBC_partner}
    ${NBC_relatedParty}=    Create List    ${NBC_rp1}    ${NBC_rp2}    ${NBC_rp3}

        # --- Product Order Item ---
    ${pkgChar}=    Create Dictionary    name=BRAND    value=LIGHTNING_SIM
    ${pkgChars}=    Create List    ${pkgChar}

     ${ppbProductOffering}=    Create Dictionary    id=PPB0000004
    ${ppbProduct}=    Create Dictionary    productOffering=${ppbProductOffering}
    ${ppbWrapper}=    Create Dictionary    product=${ppbProduct}

    ${copChar}=    Create Dictionary    name=MSISDN    value=${NBC_msisdn}
    ${copChars}=    Create List    ${copChar}
    ${copProductOffering}=    Create Dictionary    id=COP0000001
    ${copProduct}=    Create Dictionary    productOffering=${copProductOffering}    productCharacteristics=${copChars}
    ${copWrapper}=    Create Dictionary    product=${copProduct}

    ${smChar1}=    Create Dictionary    name=ICCID    value=${NBC_esimIccid}
    ${smChar2}=    Create Dictionary    name=BRAND    value=REPLACEMENT
    ${smChars}=    Create List    ${smChar1}    ${smChar2}
    ${smProductOffering}=    Create Dictionary    id=SM00000001
    ${smProduct}=    Create Dictionary    productOffering=${smProductOffering}    productCharacteristics=${smChars}
    ${smWrapper}=    Create Dictionary    product=${smProduct}

    ${fbiProductOffering}=    Create Dictionary    id=FBI0000000
    ${fbiProduct}=    Create Dictionary    productOffering=${fbiProductOffering}
    ${fbiWrapper}=    Create Dictionary    product=${fbiProduct}

    ${qtuProductOffering}=    Create Dictionary    id=QTU0000009
    ${qtuProduct}=    Create Dictionary    productOffering=${qtuProductOffering}
    ${qtuWrapper}=    Create Dictionary    product=${qtuProduct}

    ${ecnProductOffering}=    Create Dictionary    id=ECN0000000
    ${ecnProduct}=    Create Dictionary    productOffering=${ecnProductOffering}
    ${ecnWrapper}=    Create Dictionary    product=${ecnProduct}

    ${iuProductOffering}=    Create Dictionary    id=IU00000002
    ${iuProduct}=    Create Dictionary    productOffering=${iuProductOffering}
    ${iuWrapper}=    Create Dictionary    product=${iuProduct}

    ${otpProductOffering}=    Create Dictionary    id=OTP0000001
    ${otpProduct}=    Create Dictionary    productOffering=${otpProductOffering}
    ${otpWrapper}=    Create Dictionary    product=${otpProduct}

    ${innerProducts}=    Create List
    ...    ${ppbWrapper}
    ...    ${copWrapper}
    ...    ${smWrapper}
    ...    ${fbiWrapper}
    ...    ${qtuWrapper}
    ...    ${ecnWrapper}
    ...    ${iuWrapper}
    ...    ${otpWrapper}

    ${pkgProductOffering}=    Create Dictionary    id=PKG0000001
    ${pkgChar}=    Create Dictionary    name=BRAND    value=LIGHTNING_SIM
    ${pkgChars}=    Create List    ${pkgChar}
    ${pkgProduct}=    Create Dictionary    productOffering=${pkgProductOffering}    productCharacteristics=${pkgChars}    productOrderItem=${innerProducts}
    ${pkgWrapper}=    Create Dictionary    product=${pkgProduct}

    ${NBC_productOrderItem}=    Create List    ${pkgWrapper}

    # ========== Payment ==========
    ${NBC_amount}=    Create Dictionary    value=35    unit=MYR
    # force string type for value
    ${NBC_amount['value']}=    Set Variable    "35"

    ${NBC_paymentMethod}=    Create Dictionary    type=Cash
    ${NBC_payment_dict}=    Create Dictionary    amount=${NBC_amount}    paymentMethod=${NBC_paymentMethod}
    ${NBC_payment}=    Create List    ${NBC_payment_dict}

    # ========== Final Body ==========
    ${NBC_request_body}=    Create Dictionary
    ...    orderType=New Registration
    ...    upfrontPayment=${true}
    ...    simType=esim
    ...    reservationId=${NBC_msisdnReserveId}
    ...    note=${NBC_note}
    ...    party=${NBC_party}
    ...    relatedSites=${NBC_relatedSites}
    ...    relatedParty=${NBC_relatedParty}
    ...    productOrderItem=${NBC_productOrderItem}
    ...    payment=${NBC_payment}

    # Call API
    Create Session    newCustomerSession    ${NBC_MOLI_BASE_URL}    headers=${NBC_headers}    verify=true
    Log To Console    ================= REQUEST BODY =================
    Log To Console    ${NBC_request_body}
    Log To Console    =================================================
    
    Create Session    newCustomerSession    ${NBC_MOLI_BASE_URL}    headers=${NBC_headers}    verify=true
    ${NBC_response}=    POST On Session    newCustomerSession    ${NBC_POST_PREPAID_NEW_REGISTRATION}   json=${NBC_request_body}
    ${NBC_response_json}=    Set Variable    ${NBC_response.json()}
    ${NBC_orderId}=    Set Variable    ${NBC_response_json['orderId']}
    Log To Console    OrderID: ${NBC_orderId}
    RETURN    ${NBC_orderId}

Existing Customer LightningSIM Registration
    [Arguments]    ${NBC_accessToken}    ${NBC_customer}    ${NBC_customerCoreId}    ${NBC_birthDate}    ${NBC_esimIccid}    ${NBC_msisdn}    ${NBC_msisdnReserveId}                

    ${NBC_headers}=    Create Dictionary
    ...    Accept=*/*
    ...    Content-Type=application/json
    ...    Authorization=${NBC_accessToken}

    ${NBC_note}=    Create Dictionary
    ...    author=S0002935061
    ...    text=NEW_ORDER_VALIDATION
    ...    type=Note
    ${NBC_note_list}=    Create List    ${NBC_note}

    ${NBC_individualIdentification}=    Create Dictionary
    ...    identificationId=${NBC_customer['idNumber']}
    ...    identificationType="${NBC_customer['idType']}"
    ${NBC_individualIdentification_list}=    Create List    ${NBC_individualIdentification}

    ${NBC_party}=    Create Dictionary
    ...    type=Individual
    ...    role=Customer
    ...    id=${NBC_customerCoreId}
    ...    birthDate=${NBC_birthDate}
    ...    individualIdentification=${NBC_individualIdentification_list}
    ${NBC_party_list}=    Create List    ${NBC_party}

    ${NBC_relatedSite}=    Create Dictionary
    ...    id=region Id
    ...    role=REGION
    ...    name=SOUTHERN
    ${NBC_relatedSites}=    Create List    ${NBC_relatedSite}

    ${NBC_relatedParty1}=    Create Dictionary
    ...    role=Dealer
    ...    partyOrPartyRole={"id":"CKL89999","name":"dealername","referredType":"Organization"}
    ${NBC_relatedParty2}=    Create Dictionary
    ...    role=SalesRep
    ...    partyOrPartyRole={"id":"S0644908889","name":"salesRepName","referredType":"Individual"}
    ${NBC_relatedParty3}=    Create Dictionary
    ...    role=Partner
    ...    partyOrPartyRole={"id":"P326763264","name":"salesRepName","referredType":"Individual"}
    ${NBC_relatedParty_list}=    Create List    ${NBC_relatedParty1}    ${NBC_relatedParty2}    ${NBC_relatedParty3}

    ${NBC_productChar1}=    Create Dictionary
    ...    name=BRAND
    ...    value=LIGHTNING_SIM
    ${NBC_productChar_list}=    Create List    ${NBC_productChar1}

    ${NBC_productOrderItem1}=    Create Dictionary
    ...    product={"productOffering":{"id":"PPB0000004"}}
    ${NBC_productOrderItem2}=    Create Dictionary
    ...    product={"productOffering":{"id":"COP0000001"},"productCharacteristics":[{"name":"MSISDN","value":"${NBC_msisdn}"}]}
    ${NBC_productOrderItem3}=    Create Dictionary
    ...    product={"productOffering":{"id":"SM00000001"},"productCharacteristics":[{"name":"ICCID","value":"${NBC_esimIccid}"},{"name":"BRAND","value":"REPLACEMENT"}]}
    ${NBC_productOrderItem4}=    Create Dictionary
    ...    product={"productOffering":{"id":"FBI0000000"}}
    ${NBC_productOrderItem5}=    Create Dictionary
    ...    product={"productOffering":{"id":"QTU0000009"}}
    ${NBC_productOrderItem6}=    Create Dictionary
    ...    product={"productOffering":{"id":"ECN0000000"}}
    ${NBC_productOrderItem7}=    Create Dictionary
    ...    product={"productOffering":{"id":"IU00000002"}}
    ${NBC_productOrderItem8}=    Create Dictionary
    ...    product={"productOffering":{"id":"OTP0000001"}}
    ${NBC_productOrderItem_list}=    Create List
    ...    ${NBC_productOrderItem1}
    ...    ${NBC_productOrderItem2}
    ...    ${NBC_productOrderItem3}
    ...    ${NBC_productOrderItem4}
    ...    ${NBC_productOrderItem5}
    ...    ${NBC_productOrderItem6}
    ...    ${NBC_productOrderItem7}
    ...    ${NBC_productOrderItem8}

    ${NBC_product}=    Create Dictionary
    ...    productOffering={"id":"PKG0000001"}
    ...    productCharacteristics=${NBC_productChar_list}
    ...    productOrderItem=${NBC_productOrderItem_list}

    ${NBC_productOrder}=    Create Dictionary
    ...    product=${NBC_product}
    ${NBC_productOrder_list}=    Create List    ${NBC_productOrder}

    ${NBC_paymentAmount}=    Create Dictionary
    ...    value=35
    ...    unit=MYR
    ${NBC_paymentMethod}=    Create Dictionary
    ...    type=Cash
    ${NBC_payment}=    Create Dictionary
    ...    amount=${NBC_paymentAmount}
    ...    paymentMethod=${NBC_paymentMethod}
    ${NBC_payment_list}=    Create List    ${NBC_payment}

    ${NBC_request_body}=    Create Dictionary
    ...    orderType=New Registration
    ...    upfrontPayment=${true}
    ...    simType=esim
    ...    reservationId=${NBC_msisdnReserveId}
    ...    note=${NBC_note_list}
    ...    party=${NBC_party_list}
    ...    relatedSites=${NBC_relatedSites}
    ...    relatedParty=${NBC_relatedParty_list}
    ...    productOrderItem=${NBC_productOrder_list}
    ...    payment=${NBC_payment_list}

    # Call API
    Create Session    existingCustomerSession    ${NBC_MOLI_BASE_URL}    headers=${NBC_headers}    verify=true
    ${NBC_response}=    POST On Session    existingCustomerSession    ${NBC_POST_PREPAID_NEW_REGISTRATION}    json=${NBC_request_body}
    Should Be Equal As Integers    ${NBC_response.status_code}    200
    RETURN    ${NBC_response.json()}
    

