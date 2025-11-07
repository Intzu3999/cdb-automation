*** Settings ***
Library    Browser
Library    String
Library    Collections
Library    BuiltIn
Library    OperatingSystem

Suite Setup       Open Browser And Login
Suite Teardown    Close Browser
Test Teardown     Take Screenshot    fullPage=True

*** Variables ***
${NGPC_LOGIN_URL}        https://d2vl1cpd9gu168.cloudfront.net/admin/login
${EMAIL}                 ngpc-testers@maildrop.cc
${PASSWORD}              YL92bsOowp3V

${SIGN_IN_BOX}           (//main[contains(@class, 'fi-simple-main')])[1]
${EMAIL_ADDRESS_INPUT}   (//input[@id='form.email'])[1]
${PASSWORD_INPUT}        (//input[@id='form.password'])[1]
${SIGN_IN_BUTTON}        (//button[@type='submit'])[1]
${DASHBOARD_HEADER}      (//span[normalize-space()='Dashboard'])[1]
${LEFT_MENU_CONTAINER}   (//ul[@class='fi-sidebar-nav-groups'])[1]

*** Keywords ***
Open Browser And Login
    New Browser    chromium    headless=False
    New Page       ${NGPC_LOGIN_URL}
    Set Browser Timeout    60s
    Wait For Elements State    ${SIGN_IN_BOX}    visible    timeout=30s
    Type Text    ${EMAIL_ADDRESS_INPUT}    ${EMAIL}
    Type Text    ${PASSWORD_INPUT}        ${PASSWORD}
    Click        ${SIGN_IN_BUTTON}
    Wait For Elements State    ${DASHBOARD_HEADER}    visible    timeout=60s
    Log To Console    ✅ Logged in and dashboard loaded

Click And Verify All Menu Links
    Wait For Elements State    ${LEFT_MENU_CONTAINER}    visible    timeout=30s
    ${menu_elements}=    Get Elements    //nav[contains(@class,'sidebar')]//a[normalize-space()]
    FOR    ${element}    IN    @{menu_elements}
        ${link_text}=    Get Text    ${element}
        ${link_text}=    Evaluate    """${link_text}""".strip()
        IF    '${link_text}' in ['digi-cbs-blacklists']
            Log To Console    Skipping menu: ${link_text}
            CONTINUE
        END
        Log To Console    Clicking menu: ${link_text}
        Click    //nav[contains(@class,'sidebar')]//a[normalize-space()='${link_text}']
        ${header_locator}=    Set Variable    //h1[contains(translate(normalize-space(.), 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz'), '${link_text.lower()}')]
        Wait For Elements State    ${header_locator}    visible    timeout=20s
    END
    Log To Console    ✅ All left menu links validated successfully

*** Test Cases ***
Validate Left Menu Navigation
    [Tags]    smoke    ui
    Click And Verify All Menu Links
