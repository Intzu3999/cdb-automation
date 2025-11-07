*** Settings ***
Documentation    Store NGOS Reload Variables

*** Variables ***
# URL Reload Path
${NGOS_RELOAD_PATH}             /reload

# NGOS Prepaid Reload Page 1
${NGOS_RELOAD_MAIN_TEXT}        //h2[normalize-space()="Quick and Easy Reloads"]
${NGOS_SUBTEXT1}                //h5[normalize-space()="Prepaid Reload"]
${NGOS_SUBTEXT2}                //p[@class="text-xs md:text-base text-left md:text-center"]
${NGOS_MOBILE_FIELD}            //input[@id="mobile_number_input"]
${NGOS_SUBMIT_BUTTON}           //button[@id='submit_button']
${NGOS_RELOAD_ERROR_MESSAGE}    (//p[@class='text-xs text-error-message'])[1]

# NGOS Prepaid Reload Page 2
${NGOS_BANNER_FULL}             //div[@class='border rounded-2xl p-4 bg-gradient-blue text-white relative overflow-hidden']
${NGOS_BANNER_TYPE}             //div[@class="mb-4 sm:flex sm:gap-7"]
${NGOS_BANNER_NUMBER}           //div[@class="relative z-10"]/p[1]
${NGOS_BANNER_TELCO}            //div[@class="relative z-10"]/p[2]

${NGOS_RELOAD_TEXT}             //p[@class="font-extrabold text-xl"]
${NGOS_RELOAD_RM5}              //div[@id="0"]
${NGOS_RELOAD_RM10}             //div[@id="1"]
${NGOS_RELOAD_RM30}             //div[@id="2"]
${NGOS_RELOAD_RM50}             //div[@id="3"]
${NGOS_RELOAD_RM100}            //div[@id="4"]

${NGOS_RELOAD_INFO}             //p[@class="text-base font-medium text-gray-500"]
${NGOS_TNC}                     //body[1]/div[2]/div[1]/div[1]/form[1]/div[1]/div[1]/div[2]/div[4]/div[1]/p[1]
${NGOS_PRICE_SUMMARY}           //p[@class="font-bold text-lg"]
${NGOS_RELOAD_PRICE}            //div[@class="flex flex-row justify-between m-3 text-lg"]
${NGOS_RELOAD_BUTTON}           //button[@id="payBtn"]

${NGOS_SUCCESS_PAGE_PATH}        //p[@class='font-bold text-2xl mb-2']
