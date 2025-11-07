*** Settings ***
Documentation    Store ngos reload variables

*** Variables ***

#PayBill Path
${NGOS_BILLPAYMENT_URL}       /bill-payment/en

${POSTPAID_MSISDN}             60104369516
#Celcom Postpaid 601115919320
${BILL_AMOUNT}                 1.00
${operator}                    celcom
${CD_LOADING}                  //div[@id='cd-loading']

# PayBill Journey
${NGOS_BILL_AMOUNT_FIELD}       //input[@id='amount']
${NGOS_BILLPAY_BUTTON1}         //button[@id='payNowBtnMobile']
${NGOS_BILLPAY_BUTTON2}         //button[@id="payNowBtn"]

# ${NGOS_BILL_AMOUNT_FIELD}
${PAYBILL_CONTEXT2}            //p[@class="font-normal text-xs text-postpaid-tooltip mt-1"]
${PAYBILL_T&C_FULL}            //div[@class="text-start text-xs text-postpaid-tooltip my-2"]
${PAYBILL_T&C_CD}              //div[@class="text-start text-xs text-postpaid-tooltip my-2"]/p/a
${PAYBILL_AMOUNT_FULL}         //div[@class="sticky bottom-0 md:flex-auto md:pr-8"]

# TOTAL PAY BILL BOX WEB
${PAYBILL_AMOUNT_TXT1}         //div[@class="sticky bottom-0 md:flex-auto md:pr-8"]/div/div/div/p[@class="font-bold text-lg"]
${PAYBILL_AMOUNT_TXT2}         //div[@class="flex flex-row justify-between m-3 text-lg"]/p[1]
${PAYBILL_AMOUNT_TXT3}         //div[@class="flex flex-row justify-between m-3 text-lg"]/p[2]

# TOTAL PAY BILL BOX MOBILE
${PAYBILL_AMOUNT_TXT4}         //div[@class="sticky bottom-0 md:flex-auto md:pr-8"]/div
${PAYBILL_AMOUNT_TXT5}         //div[@class="sticky bottom-0 md:flex-auto md:pr-8"]/div//div/div[@class="flex flex-col"]/p[1]
${PAYBILL_AMOUNT_TXT6}         //div[@class="sticky bottom-0 md:flex-auto md:pr-8"]/div//div/div[@class="flex flex-col"]/p[2]

#Online banking Journey
${OB_USERNAME}                      1234
${OB_PASSWORD}                      1234

#Credit Card Journey
${NGOS_CARDNAME}                    NGOS TESTING
${CC_CARDVISA}                      4506186581373246
${CC_CARDAMEX}                      379186361866502
${CC_CVCVISA}                       123
${CC_CVCAMEX}                       1234
${CC_EX_MONTH}                      12
${CC_EX_YEARS}                      2028
${CC_Maybank}                       Maybank

# TAC 
# Normal Payment & Saved Card payment
${TAC_N$SPAYMENT}                   obDE8tbkbez
# Bind/Save card
${TAC_B$SCARD}                      4i7ahISi5Rg
# BROWSER
${BROWSER}                          chromium
${HEADLESS}                         False
${KEYWORD_TIMEOUT}                  5s
${BROWSER_TIMEOUT}                  10s
${EWALLET_PATH}                     //label[@id='eWallet']
${PAYMENT_LOADER_PATH}              //div[@class='loader']
${PAYMENT_PROCEED_BUTTON}           //input[@id='proceed']

################################## FAAS PAYMENT GATEWAY ###############################################
${PAYBILL_FAAS_GATEWAY}             //div[@class="cd-section"]/img[@class="logo"]
${PAYBILL_FAAS_TIMEOUT_1}           //div[@class="cd-timeout-wrapper"]/div[1]
${PAYBILL_FAAS_TIMEOUT_2}           //div[@id="the-final-countdown"]
${PAYBILL_SUMMARY_TRANS}            //div[@class="cd-section padding-top full-width"]/h2[@class="cd-h2"]
${PAYBILL_PAY_AMMOUNT_1}            //div[@class="cd-paragraph align-middle"]
${PAYBILL_PAY_AMMOUNT_2}            //div[@class="cd-paragraph-value price"]
${PAYBILL_PAY_TO}                   //div[4]/div[@class="cd-paragraph"]
# //div[contains(text(), 'Pay to')]
${PAYBILL_PAY_TO_CD}                //div[4]/div[@class="cd-paragraph-value"]
# //div[contains(text(), 'CelcomDigi Telecommunications Sdn Bhd')]
${PAYBILL_PAYMENT_OF}               //div[5]/div[@class="cd-paragraph"]
# //div[contains(text(), 'Payment of')]
${PAYBILL_PAYMENT_INFO}             //div[5]/div[@class="cd-paragraph-value"]
# //div[contains(text(), 'Bill Payment for')]
${PAYBILL_REF_NUMBER_1}             //div[6]/div[@class="cd-paragraph"]
# //div[contains(text(), 'Reference number')]
${PAYBILL_REF_NUMBER_2}             //div[6]/div[@class="cd-paragraph-value"]

# PAYMENT METHOD
${SELECT_PAY_METHOD_TITTLE}         //form[@id="payment-form"]/div[1]/div[1]/h2[1]

# Online Banking
${ONLINE_BANKING_PATH}              //label[@id='Online-banking']
${ONLINE_BANKING_DROPDOWN}          //div[@id='Online-Banking-Block']
${MAYBANK2U_PATH}                   //a[@id='bank-1']
${AFFINBANK_PATH}                   //a[@id='bank-0']
${OB_USERNAME_PATH}                 //input[@id='userId']
${OB_PASSWORD_PATH}                 //input[@id='password']
${OB_SELECT_SAVING_ACCOUNT_PATH}    //select[@class='form-control input-sm']
${OB_SUCCESS_PAYMENT_DEDUCT_PATH}   //div[@class='panel panel-success']/div[@class='panel-heading text-center']
${OB_SUBMIT_BUTTON}                 //button[@class='btn btn-primary btn-sm']
${OB_CONFIRM_BUTTON}                //button[@class='btn btn-primary btn-sm']
${OB_CONTINUE_TRANSACTION_PATH}     //input[@class='btn btn-primary btn-sm']
${OB_FAAS_CELCOM}                   CelcomDigi Mobile Sdn Bhd
${OB_FAAS_DIGI}                     CelcomDigi Telecommunications Sdn Bhd

############################### Credit Card #######################################################################
${CREDIT_CARD_PATH}                 //label[@id='Credit-debit-card']
${CC_DROPDOWN_PATH}                 //div[@class='credit_card']
${CC_HOLDER_NAME_PATH}              //fieldset/ol/li[3]/input
${CC_CARD_NO_PATH}                  //input[@id='CCNo']
${CC_CVC_CVV2_PATH}                 //fieldset/ol/li[5]/input
${CC_EXPIRY_M_PATH}                 //select[@name="CCMonth"]
${CC_EXPIRY_Y_PATH}                 //select[@name="CCYear"]
${CC_COUNTRY_PATH}                  //select[@id='CCCountry']
${CC_BANK_PATH}                     //select[@id='CCBank']
${CC_T&C_PATH}                      //input[@id='AcceptTC']
${CC_PROCEED_BUTTON}                //input[@id='proceed']
${CC_CANCEL_BUTTON}                 //input[@class='btn_cancel']
${CC_GET_REF_NO}                    //li[4]/div[@class='left']

################################################### E-Wallet ###################################################
${E_WALLET_PATH}                    //label[@id="eWallet"]
${E_WALLET_CHOOSE}                  //div[@id="eWallet-Block"]/h2[@class="cd-h2"]
${E_WALLET_SELECT}                  //div[@id="eWallet-Block"]/div[@class="x-cal-type"]/a[1]
${E_BOOST_WALLET}                   //a[@id="bank-0"]
${E_GRAB_WALLET}                    //a[@id="bank-1"]
${E_SHOPEE_WALLET}                  //a[@id="bank-2"]
${E_TNG_WALLET}                     //a[@id="bank-3"]

# TAC
${CC_TACPAGE}                       //div[@class='mainmessage mainmessage-visa']
${VISA_TAC_LOADING}                 //div[@id='light_div_2']/div[@class='modalcontent modalcontent-visa']/p[1]/b
${AMEX_TAC_LOADING}          
${TAC_PAGE}                         https://mbbmgatebeta.maybank.com/otp-listing
${TAC_INPUT_PATH}                   //input[@id='MGate Merchant Account ID']
${TAC_SEARCH_BUTTON}                //button[2]
${TAC_CLEAR_BUTTON}                 //button[1]
${TAC_LOADING_BAR}                  //div[@class='text-orange mx-8 MuiBox-root css-0']
${TAC_TABLE_LIST_HEADER}            //p[@class='pl-8 font-bold text-blue']
# OTP TABLE
${ROW_XPATH_TEMPLATE_1}             //div[@id="row-
${ROW_XPATH_TEMPLATE_2}             "]
${OTP_NUMBER_PATH}                  /div[7]
# OTP CODE
${OTP_CODE_PATH}                    //input[@class='info']
${OTP_SUBMIT_BUTTON}                //a[@id='submitBtn']
${OTP_RESEND_BUTTON}                //a[@id='resendBtn']
${OTP_CANCEL_BUTTON}                //a[@id='cancelBtn']
${found}                            Fail