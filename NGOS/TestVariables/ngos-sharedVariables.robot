*** Settings ***
Documentation    Store Shared Variables

*** Variables ***
# Staging URL
${NGOS_STAGING_BASE_URL}           https://nget.digipay.my

# NGOS Prepaid Reload Page 1
# Header
${NGOS_CD_LOGO}                    //img[@class="cd-logo-img"]
${NGOS_SHOP_TEXT}                  //div[normalize-space()="SHOP"]
${NGOS_LANGUAGE_BUTTON}            //div[normalize-space()="EN"]

${PREPAID_MSISDN}                  60104362933
#Celcom Prepaid 60145474649
#Digi Prepaid   60104362933
${INVALID_MSISDN}                  601133218077
${VAS_MSISDN}                      601129468616

# General Variables
${disabled}                        disabled
${enabled}                         enabled
${CD_LOADING}                      //div[@id='cd-loading']

# Footer
${NGOS_COPYRIGHT}                  //p[@class="text-white text-xs mb-0"]

#Payment Successful Page
${PYMTSUCCESS_TEXT1}               //p[@class="font-bold text-2xl mb-2"]
${PYMTSUCCESS_TEXT2}               //p[@class="text-xs"]
${PYMTSUCCESS_DOWNLOADINFO}        //p[@class="max-sm:text-start"]
${PYMTSUCCESS_DOWNLOADBUTTON}      //a[@id="downloadRecieptBtn"]
${PYMTSUCCESS_TEXT3}               //p[@class="font-bold text-xl"]
${PYMTSUCCESS_PYMTINFO}            //div[@class="grid grid-cols-2 gap-1 text-sm justify-start text-start "]
${PYMTSUCCESS_TAXINFO}            //div[@class="border-t grid grid-cols-2 gap-1 text-sm justify-start py-1 pb-0 mt-1 text-start"]
${PYMTSUCCESS_TOTAL}              //div[@class="flex flex-row justify-between text-white font-bold text-base"]
${MAINPAGE_BUTTON}                 //a[normalize-space()="Back to main page"]

#Payment Failed Page
${PYMTFAILED_IMG}                  //img[@alt="Failed"]
${PYMTFAILED_TEXT1}                //p[@class="font-bold text-2xl"]
${PYMTFAILED_TEXT2}                //p[@class="font-normal text-sm"]
${PYMTFAILED_RETRYBUTTON}          //a[normalize-space()="Retry"]

# Download Receipt
${NGOS_RECEIPT_BUTTON}          //a[@id='downloadRecieptBtn']