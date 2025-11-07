*** Settings ***
Documentation    This file only store reload variables

*** Variables ***

${POST_PREPAID_PINLESS_RELOAD_PATH}    /moli-subscriber/v1/balance/reload-pinless


#NBC PATH
#Both
${NBC_RECHARGE_ELIGIBILITY}                     /moli-prepay-balance-ms/v1.0/prepay-balance/check-recharge-eligibility

#Retail
${NBC_CHECK_DEAlER_BALANCE}                     /moli-prepay-balance-ms/v1.0/prepay-balance/dealer-balance
${NBC_PREPAID_RELOAD_DEALER_WALLET}             /moli-prepay-balance-ms/v1.0/prepay-balance/topup-balance-wallet

#APPS
${NBC_PREPAID_RELOAD_CASH}                      /moli-prepay-balance-ms/v1.0/prepay-balance/topup-balance-cash
