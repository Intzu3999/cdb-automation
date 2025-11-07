*** Settings ***
Documentation    Store sharing keywords

# Import
Resource    ../NGOS-testSettings.robot

*** Keywords ***

Launch New Browser
    [Arguments]    ${browserName}    ${headlessBoolean}
    New Browser    browser=${browserName}    headless=${headlessBoolean}
   
Resize Screen Size
    Set Viewport Size    width=1280    height=800

Refresh Current Page
    Reload
    Wait For Elements State    ${NGOS_CD_LOGO}    visible    timeout=10s

Check For Element Visibility
    [Arguments]    ${element_to_check}
    ${is_visible}=    Run Keyword And Return Status    Get Element States    ${element_to_check}    contains    visible
    
    Run Keyword If    ${is_visible}    Highlight Elements    ${element_to_check}    duration=3s    width=5px    style=dotted    color=#FA8072
    
    Run Keyword If    not ${is_visible}    Run Keywords
    ...    Log To Console    ⚠️ Element not visible: ${element_to_check}
    ...    AND    Take Screenshot

Check Element Exactly Match
    [Arguments]    ${check_elements}    ${expected_elements}
    ${get_elements}=    Get Text    ${check_elements}
    ${get_elements}=    Strip String    ${get_elements}
    
    Run Keyword If    '${get_elements}' == '${expected_elements}'    Run Keywords
    ...    Highlight Elements    ${check_elements}    duration=3s    width=5px    style=dotted    color=#FA8072
    ...    AND    Take Screenshot
    
    Run Keyword If    '${get_elements}' != '${expected_elements}'    Run Keywords
    ...    Highlight Elements    ${check_elements}    duration=3s    width=5px    style=dotted    color=#FA8072
    ...    AND    Log To Console    ⚠️ Expected: ${expected_elements} | Got: ${get_elements}
    ...    AND    Take Screenshot
    ...    
    ...       ${get_elements}

Wait Visible & Hidden
    [Arguments]    ${ElementsToWait}    ${timeout}=20s
    Wait For Elements State    ${ElementsToWait}    visible    timeout=${timeout}
    Wait For Elements State    ${ElementsToWait}    hidden     timeout=${timeout}

Select BANK
    [Arguments]                 ${BANK_NAME}
    Click Until Visible         ${ONLINE_BANKING_PATH}               ${ONLINE_BANKING_DROPDOWN}
    Scroll To Element           ${ONLINE_BANKING_DROPDOWN}
    Click Until Visible         ${ONLINE_BANKING_DROPDOWN}           ${BANK_NAME}
    Click Until Visible         ${BANK_NAME}                         ${PAYMENT_PROCEED_BUTTON}

Click Until Visible
    [Arguments]    ${click_element}    ${expected_visible_element}    ${retries}=3    ${interval}=3s
    Click          ${click_element}
    FOR    ${i}    IN RANGE    ${retries}
        ${is_visible}=         Run Keyword And Return Status    Wait For Elements State    ${expected_visible_element}    visible    timeout=1s
        Sleep                  ${interval}
        # Log     ${is_visible}
        Run Keyword If         '${is_visible}' == 'True'          Exit For Loop
        ${is_enable}=          Run Keyword And Return Status    Wait For Elements State    ${click_element}    enabled
        # Log     ${is_enable}
        Run Keyword If         '${is_enable}' != 'True'    Run Keywords
        ...     Click          ${click_element}
        ...     AND             Log     Click Again
    END
    Run Keyword If    '${is_visible}' != 'True'    Run Keywords
    ...    Log    Element is not visible    WARN
    ...    AND    Fail    Elements is not visible after 3 time retries
