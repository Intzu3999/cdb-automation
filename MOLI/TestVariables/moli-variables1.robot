*** Settings ***
Documentation    This file only store variables

*** Variables ***

${MOLI_UAT_BASE_URL}    https://moli-staging.auth.ap-southeast-1.amazoncognito.com
${MOLI_UAT_CLIENT_ID}    2pc38sgrhiggaqdoumujp0h2l1
${MOLI_UAT_CLIENT_SECRET}    9dn661gdr1rijvb8jvn1cjo5rle3scosm6vgvjqadpcmb95ll66
${GRANT_TYPE}    client_credentials

${MOLI_NBC_BASE_URL}    https://d1dvzfm7v42b0o.cloudfront.net
${POST_GENERATE_TOKEN_PATH}    /token
${GET_SUBSCRIBER_PROFILE_PATH}    /moli-subscriber-ms/v1.0/subscriber/get-subscriber?msisdn=${PREPAID_MSISDN}
${GET_SUBSCRIBER_PREPAID_BALANCE_PATH}  /moli-prepay-balance-ms/v1.0/prepay-balance/bucket?msisdn=${PREPAID_MSISDN}
${POST_RECHARGE_ELIGIBILITY_PATH}   /moli-prepay-balance-ms/v1.0/prepay-balance/check-recharge-eligibility
${POST_PREPAID_RELOAD_PATH}    /moli-prepay-balance-ms/v1.0/prepay-balance/topup-balance-cash
${POST_DOWNLOAD_ESIM}    /moli-resources-ms/v1.0/resources/esim-download
${POST_CONFIRM_ESIM}    /moli-resources-ms/v1.0/resources/esim-confirm
${GET_RETRIEVE_MSISDN}    /moli-resource-pool-ms/v1.0/resource-pool/availability-check
${PUT_RESERVE_MSISDN}    /moli-resource-pool-ms/v1.0/resource-pool/reserve
${GET_CUSTOMER}    /moli-customer-ms/v1.0/customer
${POST_CHECK_CUSTOMER_ELIGIBILITY}    /moli-cust-qualification-ms/v1.0/customer-qualification/check-eligibility
${GET_PRODUCT_OFFERING}    /moli-product-catalog-ms/v1.0/product-catalog/product-offering
${POST_PREPAID_NEW_REGISTRATION}    /moli-order-ms/v1.0/order/prepaid-new-registration
${POST_DEBIT_WALLET_BALANCE}    /moli-prepay-balance-ms/v1.0/prepay-balance/wallet-debit-balance
${GET_ORDER_STATUS}    /moli-product-ordering-ms/v1.0/product/order-status

${idType}    New NRIC
${idNumber}    950321193189
${MSISDN}    601016038067
${AMOUNT}    1.00
${PaymentMethod}    Cash

${customerId}
${customerIdentificationIdNo}
${customerIdentificationIdValue}
${customerBirthDate}
${customerAge}

${PREPAID_MSISDN}                   601016300710
