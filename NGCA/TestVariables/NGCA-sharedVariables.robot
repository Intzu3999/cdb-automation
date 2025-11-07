*** Settings ***
Documentation     This file contains shared vaeriables for NGCA tests.

Resource          ../NGCA-testSettings.robot 

*** Variables ***
${REMOTE_URL}                       http://localhost:4723
${PLATFORM_NAME}                    android
${PLATFORM_VERSION}                 14.0
${DEVICE_NAME}                      KBQ4UCDEPZSKFIHA
# ${PLATFORM_VERSION}               15.0
# ${DEVICE_NAME}                    R5CX810JVPL
${APP_ACTIVITY}                     com.main.MainActivity
${APP_PACKAGE}                      com.celcomdigi.nga.uat
${AUTOMATION_NAME}                  UiAutomator2
${AUTO_GRANT_PERMISSIONS}           true
${NEW_COMMAND_TIMEOUT}              0
${IGNORE_HIDDEN_API_POLICY_ERROR}   true
${CHROMEDRIVER_AUTODOWNLOAD}        True
