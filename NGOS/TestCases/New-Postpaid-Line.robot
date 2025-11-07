*** Settings ***
Documentation    This sectionn is store all the imports
Library          Browser    
Test Teardown    Close Browser

*** Variables ***

#Open NPL Order
${NGOS_NPL_URL}                 https://nget.digipay.my/plans/postpaid/PBH6100266
${CD_BUTTERFLY}                 xpath=/html/body/header/nav/div/a
${CD_COPYRIGHT}                 //footer/div/p
${NPL_OFFER_1}                  //*[@id="postpaid-plan"]/div/div[2]/span[1]
${NPL_OFFER_2}                  //*[@id="postpaid-plan"]/div/div[2]/span[2]
${NPL_OFFER_3}                  //*[@id="postpaid-plan"]/div/div[2]/span[3]
${NPL_OFFER_4}                  //*[@id="postpaid-plan"]/div/div[2]/span[4]
${NPL_OFFER_5}                  //*[@id="postpaid-plan"]/div/div[2]/span[5]
${NPL_OFFER_6}                  //*[@id="postpaid-plan"]/div/div[2]/span[6]
${CD_OFFER_160}                 xpath=/html[1]/body[1]/div[3]/div[1]/div[1]/div[1]/div[1]/div[1]/div[2]/div[1]/div[1]/div[2]/div[1]/div[1]/div[3]/div[1]/div[1]/div[1]/h6[1]

#Change Offer Confirmation
${CD_OFFER_160_ICON}            //*[@id="changePlanModal"]/div/div/div/div/div[1]/span
${CD_OFFER_160_TITLE}           //*[@id="changePlanModal"]/div/div/div/div/div[2]
${CD_OFFER_160_YESBUTTON}       //*[@id="changePlanModal"]/div/div/div/div/button[1]/span
${CD_OFFER_160_CANCEL}          //*[@id="changePlanModal"]/div/div/div/div/button[2]/span

#Choose Get a New Number
${CD_OFFER_160_PROCEED}         xpath=/html[1]/body[1]/div[3]/div[1]/div[1]/div[1]/div[2]/div[1]/div[1]/div[1]/button[1]/span[1]
${NEW_NUMBER_BUTTON}            //*[@id="serviceModal"]/div/div/div/div/div[3]
${PROCEED_ORDER}                //*[@id="serviceModal"]/div/div/div/div/button[1]/span
${CANCEL_ORDER}                 //*[@id="serviceModal"]/div/div/div/div/button[2]/span

#Choose SIM Type
${SKIP_EKYC_PAGE}              https://nget.digipay.my/plans/postpaid/skipekyc/update/true
${SIM_TYPE_TITLE}              xpath=/html/body/div[2]/div/div/div/div/div[1]/div/h5
${ESIM_BOX}                    xpath=/html/body/div[3]/div/div[2]/div[1]/input
${SIM_TYPE_COMPATIBLE}         //*[@id="device-compatible-sec"]/form/div[1]/div[1]/h4
${ESIM_CONFIRM}                //*[@id="device-compatible-confirm"]
${ESIM_PROCCED}                //*[@id="submit-button"]

#Verify NRIC
${VERIFICATION_TITLE}         xpath=/html/body/div[2]/div/div/div/div/div[1]/div/h5
${NRIC_BOX}                   //*[@id="mykad"]
${ENTER_NRIC}                 910102140024
${TERM_CONDITION}             //*[@id="termsCheck"]
${ELIGIBILITY_BUTTON}         xpath=/html/body/div[3]/div/div/div/div[2]/form/div[2]/button

#Choose Number
${NUMBER_SELECTION_PAGE}       xpath=/html/body/div[2]/div/div/div/div/div[1]/div/h5
${CHOOSE__NUMBER}              //*[@id="select-number-sec"]/div[2]/div[2]
${PROCEED_NUMBER}              xpath=/html[1]/body[1]/div[3]/div[1]/div[1]/div[2]/div[1]/div[1]/div[1]/button[1]/span[1]

#Add Suplementary Line
${SUPPP_LINE_PAGE}            xpath=/html/body/div[2]/div/div/div/div/div[1]/div/h5
${PROCEED_BUTTON}             xpath=/html[1]/body[1]/div[3]/div[1]/div[1]/div[2]/div[1]/div[1]/div[1]/button[1]

#Review Selection
${REVIEW_SELECTION_PAGE}      xpath=/html/body/div[2]/div/div/div/div/div[1]/div/h5
${REVIEW_CD_OFFER}            //*[@id="plan-review-cart"]/div[1]/div/p[2]
${REVIEW_MSISDN}              //*[@id="plan-review-cart"]/div[1]/div/p[4]
${REVIEW_OK}                  xpath=/html[1]/body[1]/div[3]/div[1]/div[1]/div[2]/div[1]/div[1]/div[1]/button[1]

#checkout details
${CHECKOUT_PAGE}              xpath=/html/body/div[2]/div/div/div/div/div[1]/div/h5 
${FULLNAME_BOX}               //*[@id="full_name"]
${ENTER_FULLNAME}             NGOS SYAHIRAH
${MSISDN_BOX}                 //*[@id="contact_number"]
${ENTER_MSISDN}               60198762324
${EMAIL_BOX}                  //*[@id="email"]
${ENTER_EMAIL}                nsyahirah.samsur@celcomdigi.com
${ADDRESS1_BOX}               //*[@id="address_line_1"]
${ENTER_ADDRESS1}             109W JALAN MERAK UNGU
${ADDRESS2_BOX}               //*[@id="address_line_2"]
${ENTER_ADDRESS2}             TAMAN ALAM MEGAH
${ADDRESS3_BOX}               //*[@id="address_line_3"]
${ENTER_ADDRESS3}             SEKSYEN 32
${PASTCODE_BOX}               //*[@id="postcode"]
${ENTER_PASSCODE}             40300
${CITY_BOX}                   //*[@id="city"]
${STATE_BOX}                  //*[@id="state"]
${PROCEED_CHECKOUT}           xpath=/html[1]/body[1]/div[3]/div[1]/div[1]/div[1]/div[1]/div[2]/div[1]/div[1]/div[1]/button[1]

#Make a payment page
${TRANSACTION_SUMMARY}        xpath=/html/body/div[2]/div[1]/div[1]/div[1]/h2
${ONLINE_BANKING}             //*[@id="Online-banking"]/div[1]
${SELECT_BANK}                //*[@id="Online-Banking-Block"]/div/a/img
${SELECT_MAYBANK}             //*[@id="bank-1"]
${PROCEED_PAYMENT}            //*[@id="proceed"]
${SUCESS_BUTTON}              xpath=/html/body/div[2]/div[1]/div[1]/div[4]/div/a[1]

#View Transaction History
${PURCHASE_SUMMARY}           xpath=/html/body/div[2]/div/div/div/div/div[1]/div/h5
${DOWNLOAD_RECEIPT}           xpath=/html/body/div[3]/div/div[2]/div[1]/div[2]/button/span

*** Keywords ***
Launch a new browser
    Open Browser    about:blank    chromium    headless=false
    Sleep    5

Open NPL Order
    Go to                       ${NGOS_NPL_URL}               timeout=10
    Wait For Elements State     ${CD_BUTTERFLY}               visible
    Scroll To                   vertical=bottom
    Sleep    5
    Click                       ${NPL_OFFER_1}
    Click                       ${NPL_OFFER_3}
    Sleep    3
    Click                       ${NPL_OFFER_4}
    Click                       ${NPL_OFFER_5}
    Sleep    3
    Click                       ${NPL_OFFER_6}
    Click                       ${NPL_OFFER_2}
    Sleep    5
    Click                       ${CD_OFFER_160}
    Sleep    3
    Take Screenshot

Change Offer Confirmation
    Wait For Elements State     ${CD_OFFER_160_ICON}                visible
    Wait For Elements State     ${CD_OFFER_160_TITLE}               visible
    Wait For Elements State     ${CD_OFFER_160_YESBUTTON}           visible
    Wait For Elements State     ${CD_OFFER_160_CANCEL}              visible
    Sleep    3
    Click                       ${CD_OFFER_160_YESBUTTON}
    Sleep    3
    Take Screenshot

Choose Get a New Number
    Click                       ${CD_OFFER_160_PROCEED}
    Wait For Elements State     ${NEW_NUMBER_BUTTON}               visible
    Wait For Elements State     ${CANCEL_ORDER}                    visible
    Sleep    5
    Click                       ${NEW_NUMBER_BUTTON}
    Sleep    5
    Take Screenshot
    Click                       ${PROCEED_ORDER}

Choose SIM Type
    New Page                    ${SKIP_EKYC_PAGE}    wait_until=domcontentloaded
    Wait For Elements State    //body    visible     timeout=10s
    Close Page 
    Wait For Elements State     ${SIM_TYPE_TITLE}               visible
    Sleep    5
    Click                       ${ESIM_BOX}
    Wait For Elements State     ${SIM_TYPE_COMPATIBLE}          visible
    Sleep    3
    Click                       ${ESIM_CONFIRM}
    Sleep    5
    Take Screenshot
    Click                       ${ESIM_PROCCED}

Verify NRIC
    Wait For Elements State     ${VERIFICATION_TITLE}           visible
    Sleep    5
    Fill Text                   ${NRIC_BOX}                     ${ENTER_NRIC}
    Sleep    3
    Click                       ${TERM_CONDITION} 
    Sleep    5
    Take Screenshot
    Click                       ${ELIGIBILITY_BUTTON}
    Sleep    3

Choose a Number
    Wait For Elements State     ${NUMBER_SELECTION_PAGE}         visible
    Wait For Elements State     ${CHOOSE__NUMBER}                visible
    Click                       ${CHOOSE__NUMBER}
    Sleep    5
    Take Screenshot
    Click                       ${PROCEED_NUMBER}

Add Suplementary Line
    Wait For Elements State     ${NUMBER_SELECTION_PAGE}         visible
    Wait For Elements State     ${CHOOSE__NUMBER}                visible
    Sleep    3
    Take Screenshot
    Click                       ${PROCEED_BUTTON}

Review Selection
    Wait For Elements State     ${REVIEW_SELECTION_PAGE}        visible
    Wait For Elements State     ${REVIEW_CD_OFFER}              visible
    Wait For Elements State     ${REVIEW_MSISDN}                visible
    Wait For Elements State     ${REVIEW_OK}                    visible
    Sleep    3
    Take Screenshot
    Click                       ${REVIEW_OK}

Checkout Details
    Wait For Elements State     ${CHECKOUT_PAGE}               visible
    Wait For Elements State     ${FULLNAME_BOX}                visible
    Fill Text                   ${FULLNAME_BOX}                ${ENTER_FULLNAME}
    Sleep    3
    Fill Text                   ${MSISDN_BOX}                  ${ENTER_MSISDN}
    Take Screenshot
    Scroll To                   vertical=bottom
    Fill Text                   ${EMAIL_BOX}                   ${ENTER_EMAIL}
    Sleep    3
    Fill Text                   ${ADDRESS1_BOX}                ${ENTER_ADDRESS1}
    Sleep    3
    Fill Text                   ${ADDRESS2_BOX}                ${ENTER_ADDRESS2}
    Sleep    3
    Fill Text                   ${ADDRESS3_BOX}                ${ENTER_ADDRESS3}
    Scroll To                   vertical=bottom
    Sleep    3
    Fill Text                   ${PASTCODE_BOX}                ${ENTER_PASSCODE}
    Sleep    3
    Wait For Elements State     ${CITY_BOX}                    visible
    Wait For Elements State     ${STATE_BOX}                   visible
    Sleep    3
    Take Screenshot
    Click                       ${PROCEED_CHECKOUT}

Make a Payment
    Wait For Elements State     ${TRANSACTION_SUMMARY}         visible
    Scroll To                   vertical=bottom
    Click                       ${ONLINE_BANKING}
    Sleep    5
    Click                       ${SELECT_BANK}
    Click                       ${SELECT_MAYBANK}
    Take Screenshot
    Sleep    3
    Click                       ${PROCEED_PAYMENT}
    Sleep    3
    Take Screenshot
    Click                       ${SUCESS_BUTTON}
    Sleep    5

Payment Confirmation Popup
    # New Page    https://d3eukyrjtapblb.cloudfront.net/mock/01K5X8QKNS2QF22J2040PK6JBV
    # Click on Success button
    Handle Future Dialogs    action=accept
    Click    //img[@alt="Success"]
    Sleep    2

View Transaction Summary
    Wait For Elements State     ${PURCHASE_SUMMARY}             visible
    Sleep    3
    Click                       ${DOWNLOAD_RECEIPT}
    Sleep    3
    Take Screenshot
    Scroll To                   vertical=bottom
    Wait For Elements State     ${CD_COPYRIGHT}                 visible
    Sleep    3

*** Test Cases ***

Test Case 1: Subscribe new CD Postpaid 5G 160 Line
    Launch a new browser    
    Open NPL Order
    Change Offer Confirmation
    Choose Get a New Number
    Choose SIM type
    Verify NRIC
    Choose a Number
    Add Suplementary Line
    Review Selection
    Checkout Details
    Make a Payment
    Payment Confirmation Popup
    View Transaction Summary