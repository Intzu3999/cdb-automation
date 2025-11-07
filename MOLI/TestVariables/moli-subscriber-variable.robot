*** Settings ***
Documentation    This file only store subscriber variables only

*** Variables ***

${GET_SUBSCRIBER_PROFILE_PATH}    /moli-subscriber/v2/subscriber/
${GET_SUBSCRIBER_PREPAID_BALANCE_PATH}      /moli-subscriber/v1/balance/
${GET_SUBSCRIBER_PREPAID_BALANCE_PATH2}    /prepaid


#NBC PATH
#Both
${NBC_GET_SUBSCRIBER_PROFILE_PATH}              /moli-subscriber-ms/v1.0/subscriber/get-subscriber?msisdn=
${NBC_GET_SUBSCRIBER_PREPAID_BALANCE_PATH}      /moli-prepay-balance-ms/v1.0/prepay-balance/bucket?msisdn=

