*** Settings ***
Documentation    Store NGPAY Variables

*** Variables ***
# NGPAY PAGE
${NGPAY_CD_LOGO}                     //img[@class="logo"]
${NGPAY_PAGE_BACK_BUTTON}            //button[@id="back"]
${NGPAY_TIMER}                       //div[@class="cd-timeout-wrapper"]
${NGPAY_PAGE_TITLE}                  //h2[normalize-space()="Summary of transaction"]
${NGPAY_PAGE_SUBTITLE}               //div[@class="cd-paragraph align-middle"]
${NGPAY_PAGE_AMOUNT}                 //div[@class="cd-paragraph-value price"]
${NGPAY_PAY_TO}                      //div[normalize-space()='Pay to']
${NGPAY_PAYMENT_OF}                  //div[normalize-space()='Payment of']
${NGPAY_REFERNCE_NUMBER}             //div[normalize-space()='Reference number']
${NGPAY_PAYMENT_METHOD_SECTION}      //div[@class="payment-method-selection"]
${NGPAY_PAYMENT_METHOD_TEXT}         //h2[text()="Select payment method"]
${NGPAY_PAYMENT_EWALLET}             //label[@id="eWallet"]
${NGPAY_PAYMENT_CREDIT_CARD}         //label[@id="Credit-debit-card"]
${NGPAY_PAYMENT_ONLINE_BANKING}      //label[@id="Online-banking"]
${NGPAY_PAYMENT_BNPL}                //label[@id="Buy-Now-Pay-Later"]
${NGPAY_PAYNOW_BUTTON_BOX}           //div[@class="cd-button-row"]
${NGPAY_PAYNOW_BUTTON}               //input[@id="proceed"]

#NGPAY - Online Banking
${NGPAY_FPX_DROPDOWN}                //div[@id="selected-bank-name"]
${NGPAY_MAYBANK2U}                   //a[@id="bank-1"]
${NGPAY_AFFINBANK}                   //a[@id="bank-0"]

#NGPAY - Online Banking - Success Page
${NGPAY_ONLINEBANKING_TEXT1}         //h2[normalize-space()="Summary of Transaction"]
${NGPAY_ONLINEBANKING_SUBTEXT1}      //div[normalize-space()="Payment amount"]
${NGPAY_ONLINEBANKING_AMOUNT}        //div[normalize-space()="RM 10.00"]
${NGPAY_ONLINEBANKING_PYMTMETHOD}    //div[normalize-space()="Payment method"]
${NGPAY_ONLINEBANKING_METHOD}        //div[normalize-space()="Online Banking - Maybank2U"]
${NGPAY_ONLINEBANKING_SUCCESS}       //a[@class="success-button"]
${NGPAY_ONLINEBANKING_FAILED}        //img[@alt="Fail"]

#FPX Simulator Main Page
${FPX_BANK_SIMULATOR}                //img[@class="img-thumbnail nav nav-pills pull-left"]
${FPX_LOGIN_USERNAME}                //input[@id="userId"]
${FPX_LOGIN_PASSWORD}                //input[@id="password"]
${FPX_SIGNIN_BUTTON}                 //button[normalize-space()="Sign in"]
${FPX_CANCEL_BUTTON}                 //button[normalize-space()="Cancel"]
${FPX_USERNAME}                       1234
${FPX_PASSWORD}                       1234

#FPX Simulator Page 2
${ACCOUNT_SELECTION}                 //select[@name="account"]
${FPX_CONFIRM_BUTTON}                //button[normalize-space()="Confirm"]
${FPX_CANCEL2_BUTTON}                //button[normalize-space()="Cancel"]
${FPX_TRXN_INFO}                     //body/div[@class="container"]/div[@class="panel panel-default"]/div[2]

#FPX Simulator Page 3
#${FPX_PAYMENT_DETAILS_TITLE}         //h3[@class="panel-title"]
#${FPX_PAYMENT_DETAILS_INFO}          //div[@class="panel-body"]
#${FPX_COMPLETED_TRXN}                //input[@value="Click Here to Complete Your Transaction"]

#NGPAY Pop-up cancelation
${NGPAY_PAGE_POPUP_INFO}             //img[@class="cd-popup-icon"]
${NGPAY_PAGE_POPUP_TEXT}             //div[@class="cd-popup-title"]
${NGPAY_PAGE_POPUP_YES_BUTTON}       //button[@id="cancel-transaction-yes"]
${NGPAY_PAGE_POPUP_NO_BUTTON}        //button[@id="cancel-transaction-no"]

#---- NGPAY/FaaS System ---
${NGPAY_FAAS_URL}                   https://dkxfwptp2ybrw.cloudfront.net/login
${NGPAY_FAAS_LOGINTEXT}             //h3[contains(text(),"Sign In To NGPAY-FAAS Dashboard")]
${NGPAY_FAAS_USERNAME}              //input[@id="email"]
${NGPAY_FAAS_PASSWORD}              //input[@id="password"]
${NGPAY_FAAS_SIGNINBUTTON}          //button[@id="kt_login_signin_submit"]
${NGPAY_FAAS_SSOBUTTON}             //button[@id="kt_login_sso"]

${NGPAY_FAAS_DASHBOARDTEXT}             //h5[normalize-space()="Dashboard"]
${NGPAY_FAAS_SUBTEXT}                  //div[@class="alert-text"]
${NGPAY_FAAS_DASHBOARDBUTTON}          //span[normalize-space()="Dashboard"]
${NGPAY_FAAS_RELOAD&BILLPYMTBUTTON}    (//span[@class='menu-text'][contains(text(),'Reloads')])[1]
${NGPAY_FAAS_ORDERSBUTTON}             //span[normalize-space()="Orders"]
${NGPAY_FAAS_PAYMENTBUTTON}             //span[normalize-space()="Payments"]
${NGPAY_FAAS_OTHERSBUTTON}              //span[normalize-space()="Others"]
${NGPAY_FAAS_SELFSERVEBUTTON}           //span[normalize-space()="Self-Serve Orders"]  
${NGPAY_FAAS_REPORTSBUTTON}            //span[normalize-space()="Reports"]
${NGPAY_FAAS_ORDER_SEARCHFIELD}       //input[@id="search_reference_id"]
