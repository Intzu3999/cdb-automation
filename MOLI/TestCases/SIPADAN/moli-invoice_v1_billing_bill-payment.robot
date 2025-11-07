*** Settings ***
Documentation    This file to store test cases SIPADAN FEATURES only

# Resource    ../MOLI-testSettings.robot
# Resource    ../../TestKeywords/moli-sipadan-keywords.robot
Resource    ../../TestKeywords/all_keywords.robot

*** Test Cases ***

#     [Documentation]    
# ...    Ticket: https://celcomdigi.atlassian.net/browse/MOLI-2126
# ...    API: [invoice/make-bill-payment] add new request parameter referenceId
# ...    Apidog: https://app.apidog.com/link/project/652757/apis/api-20020024?branchId=1064759  Env:[moli-staging-uat]
# ...    Postman: https://digi-devops.postman.co/workspace/MOLI~d27d9e6a-6183-43fc-814c-c66688a09b8e/request/19640659…    Env:[moli-staging2]
# ...    POST 'https://d1dvzfm7v42b0o.cloudfront.net/moli-invoice/v1/billing/bill-payment?telco=DIGI'

# ...    Description:    
# ...    Update payment transaction in CRM/CBS.

# ...    Notes:    
# ...    - `sourceChannel`[CSG2]-both, `branchCode`[CSG2]-Digi, `amount`-both, `paymentMethod.code`-Celcom,`paymentMethod.name`-both, are mandatory
# ...    - ``branchCode`[CSG2]-Celcom, `paymentMethod.code`-Digi, msisdn`-both, `accountNumber`-both, `creditCardNumber`-both, `operationType`[IGW]-Celcom, `referenceId`-both, `sourceReferenceNumber`[CSG]-Digi, are optional

# Celcom                    Digi
# msisdn (O)                msisdn (O)
# accountNumber (O)         accountNumber (O)
# sourceChannel (M)         sourceChannel (M)
# branchCode (O)            branchCode (CM)
# amount (M)                amount (M)
# paymentMethod.code (M)    paymentMethod.code (O)
# paymentMethod.name (M)    paymentMethod.name (M)
# creditCardNumber (O)      creditCardNumber (O)
# operationType (CM)         
# referenceId (O)           referenceId (O)
#                           sourceReferenceNumber (O)

TC01 : Post Postpaid Bill Payment with valid subscriber (both msisdn and accountNumber is present)[Digi]   
    ${accessToken}=    Get Access Token NGPAY
    ${paymentMethod}=    Create Dictionary    code=1767    name=OnlineBanking
    ${postpaidBillPaymentResponse}    ${status_code}=    Post Postpaid Bill Payment    ${accessToken}    ${DIGITELCO}   phoneNo=${BAU_DIGI_POSTPAID_MSISDN}    accountNumber=${BAU_DIGI_POSTPAID_ACCOUNT_NUMBER}   sourceChannel=223    branchCode=PSFPX    amount=1.11    paymentMethod=${paymentMethod}    creditCardNumber=${VALID_CREDIT_CARD}
    Should Be Equal As Strings    ${status_code}    500    #Digi (CSG) - Expected error, should not submit both msisdn and accountNumber    #Error is coming from CSG2/IGW, hence the error messages are different

TC02 : Post Postpaid Bill Payment with valid subscriber (both msisdn and accountNumber is present)[Celcom]   
    ${accessToken}=    Get Access Token NGPAY
    ${paymentMethod}=    Create Dictionary    code=1751    name=OnlineBanking
    ${postpaidBillPaymentResponse}    ${status_code}=    Post Postpaid Bill Payment    ${accessToken}    ${CELCOMTELCO}   phoneNo=${BAU_CELCOM_POSTPAID_MSISDN}    accountNumber=${BAU_CELCOM_POSTPAID_ACCOUNT_NUMBER}   sourceChannel=223    branchCode=PSFPX    amount=2.22    paymentMethod=${paymentMethod}    creditCardNumber=${VALID_CREDIT_CARD}    operationType=1    sourceReferenceNumber=ANYVALUE
    Should Be Equal As Strings    ${status_code}    500    #Celcom (IGW) - Expected error, should not submit both msisdn and accountNumber    #Error is coming from CSG2/IGW, hence the error messages are different    

TC03 : Post Postpaid Bill Payment with valid subscriber (only msisdn is present - without telco in query param)[Digi]
    ${accessToken}=    Get Access Token NGPAY
    ${paymentMethod}=    Create Dictionary    code=1767    name=OnlineBanking
    ${postpaidBillPaymentResponse}    ${status_code}=    Post Postpaid Bill Payment    ${accessToken}    phoneNo=${BAU_DIGI_POSTPAID_MSISDN}    sourceChannel=223    branchCode=PSFPX    amount=1.11    paymentMethod=${paymentMethod}    creditCardNumber=${VALID_CREDIT_CARD}
    Should Be Equal As Strings    ${status_code}    200

TC04 : Post Postpaid Bill Payment with valid subscriber (only msisdn is present - without telco in query param)[Celcom]   
    ${accessToken}=    Get Access Token NGPAY
    ${paymentMethod}=    Create Dictionary    code=1751    name=OnlineBanking
    ${postpaidBillPaymentResponse}    ${status_code}=    Post Postpaid Bill Payment    ${accessToken}    phoneNo=${BAU_CELCOM_POSTPAID_MSISDN}    sourceChannel=223    branchCode=PSFPX    amount=2.22    paymentMethod=${paymentMethod}    creditCardNumber=${VALID_CREDIT_CARD}    operationType=1    sourceReferenceNumber=ANYVALUE
    Should Be Equal As Strings    ${status_code}    200

TC05 : Post Postpaid Bill Payment with valid subscriber (only msisdn is present - with telco in query param)[Digi]   
    ${accessToken}=    Get Access Token NGPAY
    ${paymentMethod}=    Create Dictionary    code=1767    name=OnlineBanking
    ${postpaidBillPaymentResponse}    ${status_code}=    Post Postpaid Bill Payment    ${accessToken}    ${DIGITELCO}   phoneNo=${BAU_DIGI_POSTPAID_MSISDN}    sourceChannel=223    branchCode=PSFPX    amount=2.01    paymentMethod=${paymentMethod}    creditCardNumber=${VALID_CREDIT_CARD}
    Should Be Equal As Strings    ${status_code}    200

TC06 : Post Postpaid Bill Payment with valid subscriber (only msisdn is present - with telco in query param)[Celcom]   
    ${accessToken}=    Get Access Token NGPAY
    ${paymentMethod}=    Create Dictionary    code=1751    name=OnlineBanking
    ${postpaidBillPaymentResponse}    ${status_code}=    Post Postpaid Bill Payment    ${accessToken}    ${CELCOMTELCO}   phoneNo=${BAU_CELCOM_POSTPAID_MSISDN}    sourceChannel=223    branchCode=PSFPX    amount=2.22    paymentMethod=${paymentMethod}    creditCardNumber=${VALID_CREDIT_CARD}    operationType=1    sourceReferenceNumber=ANYVALUE
    Should Be Equal As Strings    ${status_code}    200

TC07 : Post Postpaid Bill Payment with valid subscriber (only accountNumber is present - without telco in query param)[Digi]
    ${accessToken}=    Get Access Token NGPAY
    ${paymentMethod}=    Create Dictionary    code=1767    name=OnlineBanking
    ${postpaidBillPaymentResponse}    ${status_code}=    Post Postpaid Bill Payment    ${accessToken}    accountNumber=${BAU_DIGI_POSTPAID_ACCOUNT_NUMBER}    sourceChannel=223    branchCode=PSFPX    amount=1.11    paymentMethod=${paymentMethod}    creditCardNumber=${VALID_CREDIT_CARD}
    Should Be Equal As Strings    ${status_code}    422

TC08 : Post Postpaid Bill Payment with valid subscriber (only accountNumber is present - without telco in query param)[Celcom]   
    ${accessToken}=    Get Access Token NGPAY
    ${paymentMethod}=    Create Dictionary    code=1751    name=OnlineBanking
    ${postpaidBillPaymentResponse}    ${status_code}=    Post Postpaid Bill Payment    ${accessToken}    accountNumber=${BAU_CELCOM_POSTPAID_ACCOUNT_NUMBER}    sourceChannel=223    branchCode=PSFPX    amount=2.22    paymentMethod=${paymentMethod}    creditCardNumber=${VALID_CREDIT_CARD}    operationType=1    sourceReferenceNumber=ANYVALUE
    Should Be Equal As Strings    ${status_code}    422

TC09 : Post Postpaid Bill Payment with valid subscriber (only accountNumber is present - with telco in query param)[Digi]   
    ${accessToken}=    Get Access Token NGPAY
    ${paymentMethod}=    Create Dictionary    code=1767    name=OnlineBanking
    ${postpaidBillPaymentResponse}    ${status_code}=    Post Postpaid Bill Payment    ${accessToken}    ${DIGITELCO}   accountNumber=${BAU_DIGI_POSTPAID_ACCOUNT_NUMBER}    sourceChannel=223    branchCode=PSFPX    amount=1.11    paymentMethod=${paymentMethod}    creditCardNumber=${VALID_CREDIT_CARD}
    Should Be Equal As Strings    ${status_code}    200

TC10 : Post Postpaid Bill Payment with valid subscriber (only accountNumber is present - with telco in query param)[Celcom]   
    ${accessToken}=    Get Access Token NGPAY
    ${paymentMethod}=    Create Dictionary    code=1751    name=OnlineBanking
    ${postpaidBillPaymentResponse}    ${status_code}=    Post Postpaid Bill Payment    ${accessToken}    ${CELCOMTELCO}   accountNumber=${BAU_CELCOM_POSTPAID_ACCOUNT_NUMBER}    sourceChannel=223    branchCode=PSFPX    amount=2.22    paymentMethod=${paymentMethod}    creditCardNumber=${VALID_CREDIT_CARD}    operationType=1    sourceReferenceNumber=ANYVALUE
    Should Be Equal As Strings    ${status_code}    200

TC11 : Post Postpaid Bill Payment with invalid subscriber [non CelcomDigi]   
    ${accessToken}=    Get Access Token NGPAY
    ${paymentMethod}=    Create Dictionary    code=1767    name=OnlineBanking
    ${postpaidBillPaymentResponse}    ${status_code}=    Post Postpaid Bill Payment    ${accessToken}    ${MAXISTELCO}   phoneNo=${BAU_MAXIS_POSTPAID_MSISDN}    accountNumber=${BAU_DIGI_POSTPAID_ACCOUNT_NUMBER}   sourceChannel=223    branchCode=PSFPX    amount=1.11    paymentMethod=${paymentMethod}    creditCardNumber=${VALID_CREDIT_CARD}    operationType=1
    Should Be Equal As Strings    ${status_code}    500

TC12 : Post Postpaid Bill Payment without mandatory parameter(sourceChannel, branchCode, amount, paymentMethod.name)[Digi]     
    ${accessToken}=    Get Access Token NGPAY
    ${paymentMethod}=    Create Dictionary    code=1767
    ${postpaidBillPaymentResponse}    ${status_code}=    Post Postpaid Bill Payment    ${accessToken}    ${DIGITELCO}   phoneNo=${BAU_DIGI_POSTPAID_MSISDN}    paymentMethod=${paymentMethod}    creditCardNumber=${VALID_CREDIT_CARD}
    Should Be Equal As Strings    ${status_code}    422    #branchCode is conditional mandatory to Digi. For branchCode, will only see the error once mandatory field sourceChannel is fulfill

TC13 : Post Postpaid Bill Payment without mandatory parameter(sourceChannel, amount, paymentMethod.code, paymentMethod.name, operationType)[Celcom]     
    ${accessToken}=    Get Access Token NGPAY
    ${postpaidBillPaymentResponse}    ${status_code}=    Post Postpaid Bill Payment    ${accessToken}    ${CELCOMTELCO}   phoneNo=${BAU_CELCOM_POSTPAID_MSISDN}    branchCode=PSFPX    creditCardNumber=${VALID_CREDIT_CARD}    sourceReferenceNumber=ANYVALUE
    Should Be Equal As Strings    ${status_code}    422    #operationType is conditional mandatory to Celcom. For operationType, will only see the error once the rest of mandatory field is fulfill

TC14 : Post Postpaid Bill Payment without conditional mandatory parameter(only branchCode)[Digi]     
    ${accessToken}=    Get Access Token NGPAY
    ${paymentMethod}=    Create Dictionary    code=1767    name=OnlineBanking
    ${postpaidBillPaymentResponse}    ${status_code}=    Post Postpaid Bill Payment    ${accessToken}    ${DIGITELCO}   accountNumber=${BAU_DIGI_POSTPAID_ACCOUNT_NUMBER}   sourceChannel=223    amount=1.11    paymentMethod=${paymentMethod}    creditCardNumber=${VALID_CREDIT_CARD}
    Should Be Equal As Strings    ${status_code}    422     #if sourceChannel is fulfill, branchCode is mandatory

TC15 : Post Postpaid Bill Payment without conditional mandatory parameter(only operationType)[Celcom]     
    ${accessToken}=    Get Access Token NGPAY
    ${paymentMethod}=    Create Dictionary    code=1767    name=OnlineBanking
    ${postpaidBillPaymentResponse}    ${status_code}=    Post Postpaid Bill Payment    ${accessToken}    ${CELCOMTELCO}   accountNumber=${BAU_CELCOM_POSTPAID_ACCOUNT_NUMBER}    sourceChannel=223    branchCode=PSFPX    amount=2.22    paymentMethod=${paymentMethod}    creditCardNumber=${VALID_CREDIT_CARD}    sourceReferenceNumber=ANYVALUE
    Should Be Equal As Strings    ${status_code}    200     #if Celcom subscriber, operationType is mandatory

TC16 : Post Postpaid Bill Payment without optional parameter(paymentMethod.code, *msisdn, *accountNumber, creditCardNumber, referenceId, sourceReferenceNumber)[Digi]    
    ${accessToken}=    Get Access Token NGPAY
    ${paymentMethod}=    Create Dictionary    name=OnlineBanking
    ${postpaidBillPaymentResponse}    ${status_code}=    Post Postpaid Bill Payment    ${accessToken}    ${DIGITELCO}   phoneNo=${BAU_DIGI_POSTPAID_MSISDN}    sourceChannel=223    branchCode=PSFPX    amount=1.11    paymentMethod=${paymentMethod}    referenceId=ANYVALUE    sourceReferenceNumber=ANYVALUE
    Should Be Equal As Strings    ${status_code}    200   

TC17 : Post Postpaid Bill Payment without optional parameter(branchCode, *msisdn, *accountNumber, creditCardNumber, referenceId)[Celcom]    
    ${accessToken}=    Get Access Token NGPAY
    ${paymentMethod}=    Create Dictionary    code=1676    name=OnlineBanking
    ${postpaidBillPaymentResponse}    ${status_code}=    Post Postpaid Bill Payment    ${accessToken}    ${CELCOMTELCO}   phoneNo=${BAU_CELCOM_POSTPAID_MSISDN}    sourceChannel=223    amount=1.11    paymentMethod=${paymentMethod}    operationType=1    referenceId=ANYVALUE    sourceReferenceNumber=ANYVALUE
    Should Be Equal As Strings    ${status_code}    200   

TC18 : Post Postpaid Bill Payment without request body   
    ${accessToken}=    Get Access Token NGPAY
    ${postpaidBillPaymentResponse}    ${status_code}=    Post Postpaid Bill Payment    ${accessToken}    ${CELCOMTELCO}    referenceId=ANYVALUE    sourceReferenceNumber=ANYVALUE
    Should Be Equal As Strings    ${status_code}    422   

TC19 : Post Postpaid Bill Payment with empty string[Digi]  
    ${accessToken}=    Get Access Token NGPAY
    ${paymentMethod}=    Create Dictionary    code=${EMPTY}     name=${EMPTY}
    ${postpaidBillPaymentResponse}    ${status_code}=    Post Postpaid Bill Payment    ${accessToken}    ${DIGITELCO}   phoneNo=${EMPTY}    accountNumber=${EMPTY}   sourceChannel=${EMPTY}    branchCode=${EMPTY}    amount=${EMPTY}    paymentMethod=${paymentMethod}    creditCardNumber=${EMPTY}    referenceId=    sourceReferenceNumber=
    Should Be Equal As Strings    ${status_code}    422

TC20 : Post Postpaid Bill Payment with empty string[Celcom]  
    ${accessToken}=    Get Access Token NGPAY
    ${paymentMethod}=    Create Dictionary    code=${EMPTY}     name=${EMPTY}
    ${postpaidBillPaymentResponse}    ${status_code}=    Post Postpaid Bill Payment    ${accessToken}    ${CELCOMTELCO}   phoneNo=${EMPTY}    accountNumber=${EMPTY}   sourceChannel=${EMPTY}    branchCode=${EMPTY}    amount=${EMPTY}    paymentMethod=${paymentMethod}    creditCardNumber=${EMPTY}    operationType=    referenceId=
    Should Be Equal As Strings    ${status_code}    422

TC21 : Post Postpaid Bill Payment with invalid msisdn (invalid service number-incorrect format & less than 10 char)
    ${accessToken}=    Get Access Token NGPAY
    ${paymentMethod}=    Create Dictionary    code=1767    name=OnlineBanking
    ${postpaidBillPaymentResponse}    ${status_code}=    Post Postpaid Bill Payment    ${accessToken}    ${DIGITELCO}   phoneNo=${INVALID_FORMAT_MSISDN_SHORT}    sourceChannel=223    branchCode=PSFPX    amount=1.11    paymentMethod=${paymentMethod}    creditCardNumber=${VALID_CREDIT_CARD}
    Should Be Equal As Strings    ${status_code}    422    #validation format, validation length(min)

TC22 : Post Postpaid Bill Payment with invalid msisdn (invalid service number-incorrect format & more than 12 char)
    ${accessToken}=    Get Access Token NGPAY
    ${paymentMethod}=    Create Dictionary    code=1767    name=OnlineBanking
    ${postpaidBillPaymentResponse}    ${status_code}=    Post Postpaid Bill Payment    ${accessToken}    ${DIGITELCO}   phoneNo=${INVALID_FORMAT_MSISDN_LONG}    sourceChannel=223    branchCode=PSFPX    amount=1.11    paymentMethod=${paymentMethod}    creditCardNumber=${VALID_CREDIT_CARD}
    Should Be Equal As Strings    ${status_code}    422    #validation format, validation length(max)

TC23 : Post Postpaid Bill Payment with invalid msisdn (invalid service number-incorrect format)
    ${accessToken}=    Get Access Token NGPAY
    ${paymentMethod}=    Create Dictionary    code=1767    name=OnlineBanking
    ${postpaidBillPaymentResponse}    ${status_code}=    Post Postpaid Bill Payment    ${accessToken}    ${DIGITELCO}   phoneNo=${INVALID_FORMAT}    sourceChannel=223    branchCode=PSFPX    amount=1.11    paymentMethod=${paymentMethod}    creditCardNumber=${VALID_CREDIT_CARD}
    Should Be Equal As Strings    ${status_code}    422    #validation format

TC24 : Post Postpaid Bill Payment with invalid msisdn (invalid service number-less than 10 char)
    ${accessToken}=    Get Access Token NGPAY
    ${paymentMethod}=    Create Dictionary    code=1767    name=OnlineBanking
    ${postpaidBillPaymentResponse}    ${status_code}=    Post Postpaid Bill Payment    ${accessToken}    ${CELCOMTELCO}   phoneNo=${INVALID_MSISDN_SHORT}    sourceChannel=223    branchCode=PSFPX    amount=2.22    paymentMethod=${paymentMethod}    creditCardNumber=${VALID_CREDIT_CARD}    operationType=1    sourceReferenceNumber=ANYVALUE
    Should Be Equal As Strings    ${status_code}    422    #validation length(min)

TC25 : Post Postpaid Bill Payment with invalid msisdn (invalid service number-more than 12 char)
    ${accessToken}=    Get Access Token NGPAY
    ${paymentMethod}=    Create Dictionary    code=1767    name=OnlineBanking
    ${postpaidBillPaymentResponse}    ${status_code}=    Post Postpaid Bill Payment    ${accessToken}    ${CELCOMTELCO}   phoneNo=${INVALID_MSISDN_LONG}    sourceChannel=223    branchCode=PSFPX    amount=2.22    paymentMethod=${paymentMethod}    creditCardNumber=${VALID_CREDIT_CARD}    operationType=1    sourceReferenceNumber=ANYVALUE
    Should Be Equal As Strings    ${status_code}    422    #validation length(max)

TC26 : Post Postpaid Bill Payment with invalid accountNumber[Digi]
    ${accessToken}=    Get Access Token NGPAY
    ${paymentMethod}=    Create Dictionary    code=1767    name=OnlineBanking
    ${postpaidBillPaymentResponse}    ${status_code}=    Post Postpaid Bill Payment    ${accessToken}    ${DIGITELCO}   accountNumber=${INVALID_SHORT}    sourceChannel=223    branchCode=PSFPX    amount=1.11    paymentMethod=${paymentMethod}    creditCardNumber=${VALID_CREDIT_CARD}
    Should Be Equal As Strings    ${status_code}    500    #validation value, no validation length(min)    #Digi (CSG) - Expected error, due to invalid accountNumber    #Error is coming from CSG2/IGW, hence the error messages are different

TC27 : Post Postpaid Bill Payment with invalid accountNumber [Celcom]
    ${accessToken}=    Get Access Token NGPAY
    ${paymentMethod}=    Create Dictionary    code=1767    name=OnlineBanking
    ${postpaidBillPaymentResponse}    ${status_code}=    Post Postpaid Bill Payment    ${accessToken}    ${CELCOMTELCO}   accountNumber=${INVALID_SHORT}    sourceChannel=223    branchCode=PSFPX    amount=2.22    paymentMethod=${paymentMethod}    creditCardNumber=${VALID_CREDIT_CARD}    operationType=1    sourceReferenceNumber=ANYVALUE
    Should Be Equal As Strings    ${status_code}    500    #validation value, no validation length(min)    #Celcom (IGW) - Expected error, due to invalid accountNumber    #Error is coming from CSG2/IGW, hence the error messages are different

TC28 : Post Postpaid Bill Payment with invalid accountNumber (invalid accountNumber-more than 24 char)[Digi]
    ${accessToken}=    Get Access Token NGPAY
    ${paymentMethod}=    Create Dictionary    code=1767    name=OnlineBanking
    ${postpaidBillPaymentResponse}    ${status_code}=    Post Postpaid Bill Payment    ${accessToken}    ${DIGITELCO}   accountNumber=${INVALID_LONG}    sourceChannel=223    branchCode=PSFPX    amount=1.11    paymentMethod=${paymentMethod}    creditCardNumber=${VALID_CREDIT_CARD}
    Should Be Equal As Strings    ${status_code}    500    #validation length(max)    #Digi (CSG) - Expected error, due to invalid accountNumber    #Error is coming from CSG2/IGW, hence the error messages are different

TC29 : Post Postpaid Bill Payment with invalid accountNumber (invalid accountNumber-more than 24 char)[Celcom]
    ${accessToken}=    Get Access Token NGPAY
    ${paymentMethod}=    Create Dictionary    code=1767    name=OnlineBanking
    ${postpaidBillPaymentResponse}    ${status_code}=    Post Postpaid Bill Payment    ${accessToken}    ${CELCOMTELCO}   accountNumber=${INVALID_LONG}    sourceChannel=223    branchCode=PSFPX    amount=2.22    paymentMethod=${paymentMethod}    creditCardNumber=${VALID_CREDIT_CARD}    operationType=1    sourceReferenceNumber=ANYVALUE
    Should Be Equal As Strings    ${status_code}    500    #validation length(max)    #Celcom (IGW) - Expected error, due to invalid accountNumber    #Error is coming from CSG2/IGW, hence the error messages are different

TC30 : Post Postpaid Bill Payment with invalid sourceChannel[Digi]
    ${accessToken}=    Get Access Token NGPAY
    ${paymentMethod}=    Create Dictionary    code=1767    name=OnlineBanking
    ${postpaidBillPaymentResponse}    ${status_code}=    Post Postpaid Bill Payment    ${accessToken}    ${DIGITELCO}   phoneNo=${BAU_DIGI_POSTPAID_MSISDN}    sourceChannel=${INVALID_SHORT}    branchCode=PSFPX    amount=1.11    paymentMethod=${paymentMethod}    creditCardNumber=${VALID_CREDIT_CARD}
    Should Be Equal As Strings    ${status_code}    200    #no validation value

TC31 : Post Postpaid Bill Payment with invalid sourceChannel[Celcom]
    ${accessToken}=    Get Access Token NGPAY
    ${paymentMethod}=    Create Dictionary    code=1767    name=OnlineBanking
    ${postpaidBillPaymentResponse}    ${status_code}=    Post Postpaid Bill Payment    ${accessToken}    ${CELCOMTELCO}   phoneNo=${BAU_CELCOM_POSTPAID_MSISDN}    sourceChannel=${INVALID_SHORT}    branchCode=PSFPX    amount=2.22    paymentMethod=${paymentMethod}    creditCardNumber=${VALID_CREDIT_CARD}    operationType=1    sourceReferenceNumber=ANYVALUE
    Should Be Equal As Strings    ${status_code}    200    #no validation value

TC32 : Post Postpaid Bill Payment with invalid sourceChannel (invalid sourceChannel-more than 10 char)[Digi]
    ${accessToken}=    Get Access Token NGPAY
    ${paymentMethod}=    Create Dictionary    code=1767    name=OnlineBanking
    ${postpaidBillPaymentResponse}    ${status_code}=    Post Postpaid Bill Payment    ${accessToken}    ${DIGITELCO}   accountNumber=${BAU_DIGI_POSTPAID_ACCOUNT_NUMBER}    sourceChannel=${INVALID_LONG}    branchCode=PSFPX    amount=1.11    paymentMethod=${paymentMethod}    creditCardNumber=${VALID_CREDIT_CARD}
    Should Be Equal As Strings    ${status_code}    500    #validation length(max)    #Digi (CSG) - Expected error, due to invalid sourceChannel    #Digi (CSG) - sourceChannel is only mapped for CSG2, not IGW and there’s validation at CSG2 for the character length

TC33 : Post Postpaid Bill Payment with invalid sourceChannel (invalid sourceChannel-more than 10 char)[Celcom]
    ${accessToken}=    Get Access Token NGPAY
    ${paymentMethod}=    Create Dictionary    code=1767    name=OnlineBanking
    ${postpaidBillPaymentResponse}    ${status_code}=    Post Postpaid Bill Payment    ${accessToken}    ${CELCOMTELCO}   accountNumber=${BAU_CELCOM_POSTPAID_ACCOUNT_NUMBER}    sourceChannel=${INVALID_LONG}    branchCode=PSFPX    amount=2.22    paymentMethod=${paymentMethod}    creditCardNumber=${VALID_CREDIT_CARD}    operationType=1    sourceReferenceNumber=ANYVALUE
    Should Be Equal As Strings    ${status_code}    200    #no validation on length(max)    #Celcom (IGW) - sourceChannel is only mapped for CSG2, not IGW and there’s validation at CSG2 for the character length

TC34 : Post Postpaid Bill Payment with invalid branchCode[DIGI]
    ${accessToken}=    Get Access Token NGPAY
    ${paymentMethod}=    Create Dictionary    code=1767    name=OnlineBanking
    ${postpaidBillPaymentResponse}    ${status_code}=    Post Postpaid Bill Payment    ${accessToken}    ${DIGITELCO}   phoneNo=${BAU_DIGI_POSTPAID_MSISDN}    sourceChannel=223    branchCode=${INVALID_SHORT}    amount=1.11    paymentMethod=${paymentMethod}    creditCardNumber=${VALID_CREDIT_CARD}
    Should Be Equal As Strings    ${status_code}    500    #validation value    #Digi (CSG) - Expected error, due to invalid branchCode    #Digi (CSG) - branchCode is only mapped for CSG2, not IGW and there’s validation at CSG2 for the value

TC35 : Post Postpaid Bill Payment with invalid branchCode[Celcom]
    ${accessToken}=    Get Access Token NGPAY
    ${paymentMethod}=    Create Dictionary    code=1767    name=OnlineBanking
    ${postpaidBillPaymentResponse}    ${status_code}=    Post Postpaid Bill Payment    ${accessToken}    ${CELCOMTELCO}   phoneNo=${BAU_CELCOM_POSTPAID_MSISDN}    sourceChannel=223    branchCode=${INVALID_SHORT}    amount=2.22    paymentMethod=${paymentMethod}    creditCardNumber=${VALID_CREDIT_CARD}    operationType=1    sourceReferenceNumber=ANYVALUE
    Should Be Equal As Strings    ${status_code}    200    #no validation value    #Celcom (IGW) - branchCode is only mapped for CSG2, not IGW and there’s validation at CSG2 for the value

TC36 : Post Postpaid Bill Payment with invalid branchCode (invalid sourceChannel-more than 20 char)[DIGI]
    ${accessToken}=    Get Access Token NGPAY
    ${paymentMethod}=    Create Dictionary    code=1767    name=OnlineBanking
    ${postpaidBillPaymentResponse}    ${status_code}=    Post Postpaid Bill Payment    ${accessToken}    ${DIGITELCO}   accountNumber=${BAU_DIGI_POSTPAID_ACCOUNT_NUMBER}    sourceChannel=223    branchCode=${INVALID_LONG}    amount=1.11    paymentMethod=${paymentMethod}    creditCardNumber=${VALID_CREDIT_CARD}
    Should Be Equal As Strings    ${status_code}    500    #validation length(max)    #Digi (CSG) - Expected error, due to invalid branchCode    #Digi (CSG) - branchCode is only mapped for CSG2, not IGW and there’s validation at CSG2 for the character length

TC37 : Post Postpaid Bill Payment with invalid branchCode (invalid sourceChannel-more than 20 char)[Celcom]
    ${accessToken}=    Get Access Token NGPAY
    ${paymentMethod}=    Create Dictionary    code=1767    name=OnlineBanking
    ${postpaidBillPaymentResponse}    ${status_code}=    Post Postpaid Bill Payment    ${accessToken}    ${CELCOMTELCO}   accountNumber=${BAU_CELCOM_POSTPAID_ACCOUNT_NUMBER}    sourceChannel=223    branchCode=${INVALID_LONG}    amount=2.22    paymentMethod=${paymentMethod}    creditCardNumber=${VALID_CREDIT_CARD}    operationType=1    sourceReferenceNumber=ANYVALUE
    Should Be Equal As Strings    ${status_code}    200    #no validation on length(max)    #Celcom (IGW) - branchCode is only mapped for CSG2, not IGW and there’s validation at CSG2 for the character length

TC38 : Post Postpaid Bill Payment with invalid amount (incorrect format-negative)[Digi]
    ${accessToken}=    Get Access Token NGPAY
    ${paymentMethod}=    Create Dictionary    code=1767    name=OnlineBanking
    ${postpaidBillPaymentResponse}    ${status_code}=    Post Postpaid Bill Payment    ${accessToken}    ${DIGITELCO}   phoneNo=${BAU_DIGI_POSTPAID_MSISDN}    sourceChannel=223    branchCode=PSFPX    amount=-1.00    paymentMethod=${paymentMethod}    creditCardNumber=${VALID_CREDIT_CARD}
    Should Be Equal As Strings    ${status_code}    200    #no need enhancement at the moment, control by front channel

TC39 : Post Postpaid Bill Payment with invalid amount (incorrect format-negative)[Celcom]
    ${accessToken}=    Get Access Token NGPAY
    ${paymentMethod}=    Create Dictionary    code=1767    name=OnlineBanking
    ${postpaidBillPaymentResponse}    ${status_code}=    Post Postpaid Bill Payment    ${accessToken}    ${CELCOMTELCO}   accountNumber=${BAU_CELCOM_POSTPAID_ACCOUNT_NUMBER}    sourceChannel=223    branchCode=PSFPX    amount=-2.22    paymentMethod=${paymentMethod}    creditCardNumber=${VALID_CREDIT_CARD}    operationType=1    sourceReferenceNumber=ANYVALUE
    Should Be Equal As Strings    ${status_code}    500    #validation value

TC40 : Post Postpaid Bill Payment with invalid amount (incorrect format)[Digi]
    ${accessToken}=    Get Access Token NGPAY
    ${paymentMethod}=    Create Dictionary    code=1767    name=OnlineBanking
    ${postpaidBillPaymentResponse}    ${status_code}=    Post Postpaid Bill Payment    ${accessToken}    ${DIGITELCO}   phoneNo=${BAU_DIGI_POSTPAID_MSISDN}    sourceChannel=223    branchCode=PSFPX    amount=${INVALID_FORMAT}    paymentMethod=${paymentMethod}    creditCardNumber=${VALID_CREDIT_CARD}
    Should Be Equal As Strings    ${status_code}    422    #validation format

TC41 : Post Postpaid Bill Payment with invalid amount (incorrect format)[Celcom]
    ${accessToken}=    Get Access Token NGPAY
    ${paymentMethod}=    Create Dictionary    code=1767    name=OnlineBanking
    ${postpaidBillPaymentResponse}    ${status_code}=    Post Postpaid Bill Payment    ${accessToken}    ${CELCOMTELCO}   accountNumber=${BAU_CELCOM_POSTPAID_ACCOUNT_NUMBER}    sourceChannel=223    branchCode=PSFPX    amount=${INVALID_FORMAT}    paymentMethod=${paymentMethod}    creditCardNumber=${VALID_CREDIT_CARD}    operationType=1    sourceReferenceNumber=ANYVALUE
    Should Be Equal As Strings    ${status_code}    422    #validation format

TC42 : Post Postpaid Bill Payment with invalid paymentMethod.code (incorrect format)[Digi]   
    ${accessToken}=    Get Access Token NGPAY
    ${paymentMethod}=    Create Dictionary    code=${INVALID_FORMAT}    name=OnlineBanking
    ${postpaidBillPaymentResponse}    ${status_code}=    Post Postpaid Bill Payment    ${accessToken}    ${DIGITELCO}   phoneNo=${BAU_DIGI_POSTPAID_MSISDN}    sourceChannel=223    branchCode=PSFPX    amount=1.11    paymentMethod=${paymentMethod}    creditCardNumber=${VALID_CREDIT_CARD}
    Should Be Equal As Strings    ${status_code}    200    #no validation value    #Digi (CSG) - paymentMethod.code is only mapped for IGW, not CSG2 and there’s validation at IGW for the value

TC43 : Post Postpaid Bill Payment with invalid paymentMethod.code (incorrect format)[Celcom]   
    ${accessToken}=    Get Access Token NGPAY
    ${paymentMethod}=    Create Dictionary    code=${INVALID_FORMAT}    name=OnlineBanking
    ${postpaidBillPaymentResponse}    ${status_code}=    Post Postpaid Bill Payment    ${accessToken}    ${CELCOMTELCO}   phoneNo=${BAU_CELCOM_POSTPAID_MSISDN}    sourceChannel=223    branchCode=PSFPX    amount=2.22    paymentMethod=${paymentMethod}    creditCardNumber=${VALID_CREDIT_CARD}    operationType=1    sourceReferenceNumber=ANYVALUE
    Should Be Equal As Strings    ${status_code}    500    #validation value    #Celcom (IGW) - Expected error, due to invalid paymentMethod.code    #Celcom (IGW) - paymentMethod.code is only mapped for IGW, not CSG2 and there’s validation at IGW for the value  

TC44 : Post Postpaid Bill Payment with invalid paymentMethod.name (incorrect format)[Digi]   
    ${accessToken}=    Get Access Token NGPAY
    ${paymentMethod}=    Create Dictionary    code=    name=${INVALID_LONG}
    ${postpaidBillPaymentResponse}    ${status_code}=    Post Postpaid Bill Payment    ${accessToken}    ${DIGITELCO}   accountNumber=${BAU_DIGI_POSTPAID_ACCOUNT_NUMBER}    sourceChannel=223    branchCode=PSFPX    amount=1.11    paymentMethod=${paymentMethod}    creditCardNumber=${VALID_CREDIT_CARD}
    Should Be Equal As Strings    ${status_code}    422    #validation format  

TC45 : Post Postpaid Bill Payment with invalid paymentMethod.name (incorrect format)[Celcom]   
    ${accessToken}=    Get Access Token NGPAY
    ${paymentMethod}=    Create Dictionary    code=    name=${INVALID_LONG}
    ${postpaidBillPaymentResponse}    ${status_code}=    Post Postpaid Bill Payment    ${accessToken}    ${CELCOMTELCO}   accountNumber=${BAU_CELCOM_POSTPAID_ACCOUNT_NUMBER}    sourceChannel=223    branchCode=PSFPX    amount=2.22    paymentMethod=${paymentMethod}    creditCardNumber=${VALID_CREDIT_CARD}    operationType=1    sourceReferenceNumber=ANYVALUE
    Should Be Equal As Strings    ${status_code}    422    #validation format        

TC46 : Post Postpaid Bill Payment with invalid creditCardNumber (incorrect format)[Digi]    
    ${accessToken}=    Get Access Token NGPAY
    ${paymentMethod}=    Create Dictionary    code=1767    name=OnlineBanking
    ${postpaidBillPaymentResponse}    ${status_code}=    Post Postpaid Bill Payment    ${accessToken}    ${DIGITELCO}   accountNumber=${BAU_DIGI_POSTPAID_ACCOUNT_NUMBER}    sourceChannel=223    branchCode=PSFPX    amount=1.11    paymentMethod=${paymentMethod}    creditCardNumber=${INVALID_LONG}
    Should Be Equal As Strings    ${status_code}    422    #validation format, no validation length

TC47 : Post Postpaid Bill Payment with invalid creditCardNumber (incorrect format)[Celcom]    
    ${accessToken}=    Get Access Token NGPAY
    ${paymentMethod}=    Create Dictionary    code=1767    name=OnlineBanking
    ${postpaidBillPaymentResponse}    ${status_code}=    Post Postpaid Bill Payment    ${accessToken}    ${CELCOMTELCO}   accountNumber=${BAU_CELCOM_POSTPAID_ACCOUNT_NUMBER}    sourceChannel=223    branchCode=PSFPX    amount=2.22    paymentMethod=${paymentMethod}    creditCardNumber=${INVALID_LONG}    operationType=1    sourceReferenceNumber=ANYVALUE
    Should Be Equal As Strings    ${status_code}    422    #validation format, no validation length

TC48 : Post Postpaid Bill Payment with invalid operationType (incorrect format)[Celcom]      
    ${accessToken}=    Get Access Token NGPAY
    ${paymentMethod}=    Create Dictionary    code=1767    name=OnlineBanking
    ${postpaidBillPaymentResponse}    ${status_code}=    Post Postpaid Bill Payment    ${accessToken}    ${CELCOMTELCO}   phoneNo=${BAU_CELCOM_POSTPAID_MSISDN}    sourceChannel=223    branchCode=PSFPX    amount=2.22    paymentMethod=${paymentMethod}    creditCardNumber=${VALID_CREDIT_CARD}    operationType=${INVALID_FORMAT}    sourceReferenceNumber=ANYVALUE
    Should Be Equal As Strings    ${status_code}    422    #validation format

TC49 : Post Postpaid Bill Payment with invalid operationType (incorrect value)[Celcom]      
    ${accessToken}=    Get Access Token NGPAY
    ${paymentMethod}=    Create Dictionary    code=1767    name=OnlineBanking
    ${postpaidBillPaymentResponse}    ${status_code}=    Post Postpaid Bill Payment    ${accessToken}    ${CELCOMTELCO}   accountNumber=${BAU_CELCOM_POSTPAID_ACCOUNT_NUMBER}    sourceChannel=223    branchCode=PSFPX    amount=2.22    paymentMethod=${paymentMethod}    creditCardNumber=${VALID_CREDIT_CARD}    operationType=10    sourceReferenceNumber=ANYVALUE
    Should Be Equal As Strings    ${status_code}    500    #validation value

TC50 : Post Postpaid Bill Payment with invalid referenceId (incorrect format-exceeding 32 char)[Digi]   
    ${accessToken}=    Get Access Token NGPAY
    ${paymentMethod}=    Create Dictionary    code=1767    name=OnlineBanking
    ${postpaidBillPaymentResponse}    ${status_code}=    Post Postpaid Bill Payment    ${accessToken}    ${DIGITELCO}   accountNumber=${BAU_DIGI_POSTPAID_ACCOUNT_NUMBER}    sourceChannel=223    branchCode=PSFPX    amount=1.11    paymentMethod=${paymentMethod}    creditCardNumber=${VALID_CREDIT_CARD}    referenceId=${INVALID_LONG}
    Should Be Equal As Strings    ${status_code}    500    #validation length(max)    #Digi (CSG) - Expected error, due to invalid referenceId    #Error is coming from CSG2/IGW, hence the error messages are different

TC51 : Post Postpaid Bill Payment with invalid referenceId (incorrect format-exceeding 32 char)[Celcom]   
    ${accessToken}=    Get Access Token NGPAY
    ${paymentMethod}=    Create Dictionary    code=1767    name=OnlineBanking
    ${postpaidBillPaymentResponse}    ${status_code}=    Post Postpaid Bill Payment    ${accessToken}    ${CELCOMTELCO}   accountNumber=${BAU_CELCOM_POSTPAID_ACCOUNT_NUMBER}    sourceChannel=223    branchCode=PSFPX    amount=2.22    paymentMethod=${paymentMethod}    creditCardNumber=${VALID_CREDIT_CARD}    operationType=1    referenceId=6RGFH%$%HGSHBHSVHSHSBNHSTSYGDHSG6TRt    sourceReferenceNumber=ANYVALUE
    Should Be Equal As Strings    ${status_code}    500    #validation length(max)    #Celcom (IGW) - Expected error, due to invalid referenceId    #Error is coming from CSG2/IGW, hence the error messages are different

TC52 : Post Postpaid Bill Payment with invalid referenceId (duplicate-has been exist)[Digi]      
    ${accessToken}=    Get Access Token NGPAY
    ${paymentMethod}=    Create Dictionary    code=1767    name=OnlineBanking
    ${postpaidBillPaymentResponse}    ${status_code}=    Post Postpaid Bill Payment    ${accessToken}    ${DIGITELCO}   accountNumber=${BAU_DIGI_POSTPAID_ACCOUNT_NUMBER}    sourceChannel=223    branchCode=PSFPX    amount=3.00    paymentMethod=${paymentMethod}    creditCardNumber=${VALID_CREDIT_CARD}    referenceId=WT12WE3RE
    Should Be Equal As Strings    ${status_code}    200    #no validation[no error but in CRM transaction will only appear once(second transaction ignored)]    #response is identical to the first, except for the distinct referenceNumber

TC53 : Post Postpaid Bill Payment with invalid referenceId (duplicate-has been exist)[Celcom]      
    ${accessToken}=    Get Access Token NGPAY
    ${paymentMethod}=    Create Dictionary    code=1767    name=OnlineBanking
    ${postpaidBillPaymentResponse}    ${status_code}=    Post Postpaid Bill Payment    ${accessToken}    ${CELCOMTELCO}   accountNumber=${BAU_CELCOM_POSTPAID_ACCOUNT_NUMBER}    sourceChannel=223    branchCode=PSFPX    amount=1.04    paymentMethod=${paymentMethod}    creditCardNumber=${VALID_CREDIT_CARD}    operationType=1    referenceId=75WWREILY    sourceReferenceNumber=ANYVALUE
    Should Be Equal As Strings    ${status_code}    200    #validation value    #Celcom (IGW) - Expected error, due to duplicate referenceId    #Celcom (IGW) - there’s validation at IGW for duplicate referenceId    #eceived response 200 but transaction is actually failed (Celcom). DTE accepts transactions with response 201 but not necessary the transaction is success. For the failed transaction will not be recorded in CBS

TC54 : Post Postpaid Bill Payment with invalid sourceReferenceNumber (incorrect format-exceeding 30 char)[Digi]   
    ${accessToken}=    Get Access Token NGPAY
    ${paymentMethod}=    Create Dictionary    code=1767    name=OnlineBanking
    ${postpaidBillPaymentResponse}    ${status_code}=    Post Postpaid Bill Payment    ${accessToken}    ${DIGITELCO}   accountNumber=${BAU_DIGI_POSTPAID_ACCOUNT_NUMBER}    sourceChannel=223    branchCode=PSFPX    amount=1.11    paymentMethod=${paymentMethod}    creditCardNumber=${VALID_CREDIT_CARD}    sourceReferenceNumber=${INVALID_LONG}
    Should Be Equal As Strings    ${status_code}    500    #validation length(max)    #Digi (CSG) - Expected error, due to invalid SourceReferenceNumber    #Digi (CSG) - SourceReferenceNumber is only mapped for CSG2, not IGW and there’s validation at CSG2 for the character length

TC55 : Post Postpaid Bill Payment with different referenceId but same sourceReferenceNumber (duplicate-has been exist)[Digi]      
    ${accessToken}=    Get Access Token NGPAY
    ${paymentMethod}=    Create Dictionary    code=1767    name=OnlineBanking
    ${postpaidBillPaymentResponse}    ${status_code}=    Post Postpaid Bill Payment    ${accessToken}    ${DIGITELCO}   accountNumber=${BAU_DIGI_POSTPAID_ACCOUNT_NUMBER}    sourceChannel=223    branchCode=PSFPX    amount=1.42    paymentMethod=${paymentMethod}    creditCardNumber=${VALID_CREDIT_CARD}    sourceReferenceNumber=ADSE111
    Should Be Equal As Strings    ${status_code}    200    #no validation value

TC56 : Post Postpaid Bill Payment with same referenceId and same sourceReferenceNumber (duplicate-has been exist)[Digi]      
    ${accessToken}=    Get Access Token NGPAY
    ${paymentMethod}=    Create Dictionary    code=1767    name=OnlineBanking
    ${postpaidBillPaymentResponse}    ${status_code}=    Post Postpaid Bill Payment    ${accessToken}    ${DIGITELCO}   accountNumber=${BAU_DIGI_POSTPAID_ACCOUNT_NUMBER}    sourceChannel=223    branchCode=PSFPX    amount=1.61    paymentMethod=${paymentMethod}    creditCardNumber=${VALID_CREDIT_CARD}    referenceId=LTOSMQWUTAHH    sourceReferenceNumber=ADSE111
    Should Be Equal As Strings    ${status_code}    200    #no validation[no error but in CRM transaction will only appear once(second transaction ignored)]    #response is identical to the first, except for both referenceId and sourceReferenceNumber
