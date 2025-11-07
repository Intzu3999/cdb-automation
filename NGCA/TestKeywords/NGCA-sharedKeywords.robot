*** Settings ***
Documentation    This file contains shared keywords for NGCA tests.

#Import
Resource          ../TestVariables/NGCA-sharedVariables.robot

*** Keywords ***

#Open Apps operation
Open Ngca App
    [Documentation]    Opens the NGCA app using Appium.
    Open Application    ${REMOTE_URL}
    ...    platformName=${PLATFORM_NAME}
    ...    appium:platformVersion=${PLATFORM_VERSION}
    ...    appium:deviceName=${DEVICE_NAME}
    ...    appium:appActivity=${APP_ACTIVITY}
    ...    appium:appPackage=${APP_PACKAGE}
    ...    appium:automationName=${AUTOMATION_NAME}
    ...    appium:autoGrantPermissions=${AUTO_GRANT_PERMISSIONS}
    ...    appium:newCommandTimeout=${NEW_COMMAND_TIMEOUT}
    ...    appium:ignoreHiddenApiPolicyError=${IGNORE_HIDDEN_API_POLICY_ERROR}


Close Ngca App
    [Documentation]    Closes the Ngca app.
    Close Application


