*** Settings ***
Documentation    This sectionn is store all the imports
Library          Browser    
Test Teardown    Close Browser

*** Variables ***

#VAS Page 1
${NGOS_ADDON_URL}                    https://nget.digipay.my/vas
${CD_BUTTERFLY}                      xpath=/html[1]/body[1]/header[1]/nav[1]/div[1]/a[1]/img[1]
${CD_COPYRIGHT}                      //footer/div/p
${ENTER_MSISDN_TITLE}                xpath=/html/body/div[3]/div/div/div/div[1]/h4
${VAS_HEADING}                       xpath=/html[1]/body[1]/div[3]/div[1]/div[1]/div[1]/div[2]/form[1]/div[1]/h6[1]
${VAS_SUBMITBUTTON}                  xpath=/html/body/div[3]/div/div/div/div[2]/form/div[2]/button
${VAS_SUBMITBUTTON_FIELD}            //*[@id="msisdn"]
${ENTER_MSISDN}                      601114907029
 
#VAS Page 2
${ENTER_OTP_TITLE}                   xpath=/html/body/div[3]/div/div/div[1]/h4
${ENTER_OTP_HEADING}                 xpath=/html[1]/body[1]/div[3]/div[1]/div[1]/div[2]/label[1]
${ENTER_OTP_TITLE}                   //h4[normalize-space()="Enter OTP Number"]
${ENTER_OTP_HEADING}                 //label[@class="form-label fs-7"]
${OTP_BOX1}                          //*[@id="otp1"]
${OTP_BOX2}                         //*[@id="otp2"]
${OTP_BOX3}                         //*[@id="otp3"]
${OTP_BOX4}                         //*[@id="otp4"]
${OTP_BOX5}                         //*[@id="otp5"]
${OTP_BOX6}                         //*[@id="otp6"]
${OTP_NUMBER_1}                      6
${OTP_NUMBER_2}                      5
${OTP_NUMBER_3}                      4
${OTP_NUMBER_4}                      4
${OTP_NUMBER_5}                      5
${OTP_NUMBER_6}                      6
${VERIFY_OTP_BUTTON}                 xpath=/html[1]/body[1]/div[3]/div[1]/div[1]/div[3]/form[1]/div[2]

#VAS Page 3
${FREEDOM_ADDON_TAB}                 xpath=/html/body/div[3]/div/div/div/div[1]/div/div[2]
${VAS_ITEM}                          xpath=/html/body/div[3]/div/div/div/div[2]/div[1]/div
${VAS_PURCHASE}                      xpath=/html/body/div[3]/div/div/div/div[2]/div[1]/div/div[2]

#VAS Successful Page
${CONFIRM_TITLE}                    //*[@id="subscriptionDrawer"]
${CONFIRM_BUTTON}                   //*[@id="subscriptionDrawer"]/div/div/button
${Subscription Successful}          //*[@id="text-container"]/h2/text()[1]

*** Keywords ***
Launch a new browser
    Open Browser    about:blank    chromium    headless=false
    Sleep    5

Open VAS Page 1
    Go to                       ${NGOS_ADDON_URL}               timeout=10
    Wait For Elements State     ${CD_BUTTERFLY}                 visible
    Wait For Elements State     ${CD_COPYRIGHT}                 visible
    Wait For Elements State     ${ENTER_MSISDN_TITLE}           visible
    Wait For Elements State     ${VAS_HEADING}                  visible
    Wait For Elements State     ${VAS_SUBMITBUTTON}             visible
    Fill Text                   ${VAS_SUBMITBUTTON_FIELD}       ${ENTER_MSISDN}
    Sleep    3
    Click                       ${VAS_SUBMITBUTTON}
    Take Screenshot
    Sleep    5
    Take Screenshot

Open VAS Page 2
    Wait For Elements State     ${CD_BUTTERFLY}                visible
    Wait For Elements State     ${CD_COPYRIGHT}                visible
    Wait For Elements State     ${ENTER_OTP_TITLE}             visible
    Wait For Elements State     ${ENTER_OTP_HEADING}           visible
    # Sleep    3
    Click                       ${OTP_BOX1}
    Sleep    1
    Fill Text                   ${OTP_BOX1}                   ${OTP_NUMBER_1}
    Click                       ${OTP_BOX2}
    Sleep    1
    Fill Text                   ${OTP_BOX2}                   ${OTP_NUMBER_2}
    Click                       ${OTP_BOX3}
    Sleep    1
    Fill Text                   ${OTP_BOX3}                   ${OTP_NUMBER_3}
    Sleep    1
    Click                       ${OTP_BOX4}
    Sleep    1
    Fill Text                   ${OTP_BOX4}                   ${OTP_NUMBER_4}
    Click                       ${OTP_BOX5}
    Sleep    1
    Fill Text                   ${OTP_BOX5}                   ${OTP_NUMBER_5}
    Click                       ${OTP_BOX6}
    Sleep    1
    Fill Text                   ${OTP_BOX6}                   ${OTP_NUMBER_6}
    Take Screenshot
    Sleep    3
    Click                       ${VERIFY_OTP_BUTTON}

Open VAS Page 3
    Wait For Elements State     ${CD_BUTTERFLY}                visible
    Wait For Elements State     ${CD_COPYRIGHT}                visible
    Sleep    5
    Take Screenshot
    Click                       ${FREEDOM_ADDON_TAB}
    Sleep    5
    Wait For Elements State     ${VAS_ITEM}                    visible
    Take Screenshot
    Click                       ${VAS_PURCHASE}

VAS Confirmation Successful Page
    Wait For Elements State    ${CONFIRM_TITLE}
    Take Screenshot
    Sleep    5
    Click                      ${CONFIRM_BUTTON}

VAS Success Page
    Wait For Elements State    ${Subscription Successful}
    Sleep    3
    Take Screenshot
    Scroll To                  vertical=bottom
    Close Browser              CURRENT
    

*** Test Cases ***

Test Case 1: NGOS Subscribe Addon
    Launch a new browser
    Open VAS Page 1
    Open VAS Page 2
    Open VAS Page 3
    # VAS Confirmation Successful Page 
    # Vas Success Page 