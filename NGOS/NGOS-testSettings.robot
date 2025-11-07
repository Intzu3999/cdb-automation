*** Settings ***
Documentation    This file only to store Libraries and Resources files.
Library    Browser
Library    String

#Variables
Resource    TestVariables/ngos-sharedVariables.robot
Resource    TestVariables/ngos-reloadVariables.robot
Resource    TestVariables/ngpay-variables.robot
# Resource    TestVariables/ngos-preorderVariables.robot
Resource    TestVariables/ngos-billpaymentVariables.robot
#Resource    TestVariables/ngos-vasVariables.robot

# #Keywords
# Resource    TestKeywords/ngos-sharedKeywords.robot
# Resource    TestKeywords/ngos-reloadKeywords.robot
# Resource    TestKeywords/ngpay-Keywords.robot
# # Resource    TestKeywords/ngos-preorderKeywords.robot
# Resource    TestKeywords/ngos-billpaymentKeywords.robot
