*** Settings ***
Documentation    This file to store test cases SIPADAN FEATURES only

# Resource    ../MOLI-testSettings.robot
# Resource    ../../TestKeywords/moli-sipadan-keywords.robot
Resource    ../../TestKeywords/all_keywords.robot

*** Test Cases ***

#     [Documentation]    
# ...    Ticket: https://celcomdigi.atlassian.net/browse/MOLI-1964   
# ...    API: [campaign-ms/offer-retrieve] add new parameter requestedStatistic
# ...    Apidog: https://app.apidog.com/link/project/696426/apis/api-12630191    Env:[moli-staging-uat]
# ...    Postman:
# ...    POST 'https://d1dvzfm7v42b0o.cloudfront.net/moli-campaign-ms/v1.0/campaign/offers-retrieve'

# ...    Description:    
# ...    This API allows users to search and retrieve available offers as per campaign based on given MSISDN on the CMP platform. 
# ...    This API will produce information such as how many offers are available for this particular MSISDN, the offers itself including the name of the offer, the campaign ID, the offer ID and some other characteristics of the campaign.     

# ...    Notes:    
# ...    - `msisdn` is mandatory.    
# ...    - `searchFilters`, `sortBy`, `channelId`, `transactionId`, `keyword`, and `requestedStatistic` are optional.     

TC01 : Post Campaign Offer Retrieve with valid subscriber[Digi]
    ${accessToken}=    Get Access Token NBC
    ${f1}=    Create Dictionary    channel=PULSE    zone=MSA_NBO_PRIMARY
    ${searchFilters}=    Create List    ${f1}
    ${sortBy}=    Create Dictionary    params=offer:campaignPriority    order=Asc
    ${k1}=    Create Dictionary    text=SA Message - EN
    ${k2}=    Create Dictionary    text=SA Message - BM
    ${k3}=    Create Dictionary    text=SA Message - MD
    ${k4}=    Create Dictionary    text=Opt-in Keyword
    ${k5}=    Create Dictionary    text=Postpaid/Prepaid Indicator
    ${keyword}=    Create List    ${k1}    ${k2}    ${k3}    ${k4}    ${k5}
    ${idList}=    Create List    37199    137825
    ${requestedStatistic}=    Create Dictionary    id=${idList}
    ${campaignOfferRetrieveResponse}    ${status_code}=    Post Campaign Offer Retrieve    ${accessToken}    phoneNo=${NBC_DIGI_PREPAID_OFFER_RETRIEVAL}    searchFilters=${searchFilters}    sortBy=${sortBy}    channelId=223    keyword=${keyword}    requestedStatistic=${requestedStatistic}    
    Should Be Equal As Strings    ${status_code}    200

TC02 : Post Campaign Offer Retrieve with invalid subscriber[non CelcomDigi]
    ${accessToken}=    Get Access Token NBC
    ${f1}=    Create Dictionary    channel=PULSE    zone=MSA_NBO_PRIMARY
    ${searchFilters}=    Create List    ${f1}
    ${sortBy}=    Create Dictionary    params=offer:campaignPriority    order=Asc
    ${k1}=    Create Dictionary    text=SA Message - EN
    ${k2}=    Create Dictionary    text=SA Message - BM
    ${k3}=    Create Dictionary    text=SA Message - MD
    ${k4}=    Create Dictionary    text=Opt-in Keyword
    ${k5}=    Create Dictionary    text=Postpaid/Prepaid Indicator
    ${keyword}=    Create List    ${k1}    ${k2}    ${k3}    ${k4}    ${k5}
    ${idList}=    Create List    37199    137825
    ${requestedStatistic}=    Create Dictionary    id=${idList}
    ${campaignOfferRetrieveResponse}    ${status_code}=    Post Campaign Offer Retrieve    ${accessToken}    phoneNo=${NBC_NONCD}    searchFilters=${searchFilters}    sortBy=${sortBy}    channelId=223    keyword=${keyword}    requestedStatistic=${requestedStatistic}    
    Should Be Equal As Strings    ${status_code}    400  

TC03 : Post Campaign Offer Retrieve without mandatory parameter(msisdn)
    ${accessToken}=    Get Access Token NBC
    ${f1}=    Create Dictionary    channel=PULSE    zone=MSA_NBO_PRIMARY
    ${searchFilters}=    Create List    ${f1}
    ${sortBy}=    Create Dictionary    params=offer:campaignPriority    order=Asc
    ${k1}=    Create Dictionary    text=SA Message - EN
    ${k2}=    Create Dictionary    text=SA Message - BM
    ${k3}=    Create Dictionary    text=SA Message - MD
    ${k4}=    Create Dictionary    text=Opt-in Keyword
    ${k5}=    Create Dictionary    text=Postpaid/Prepaid Indicator
    ${keyword}=    Create List    ${k1}    ${k2}    ${k3}    ${k4}    ${k5}
    ${idList}=    Create List    37199    137825
    ${requestedStatistic}=    Create Dictionary    id=${idList}
    ${campaignOfferRetrieveResponse}    ${status_code}=    Post Campaign Offer Retrieve    ${accessToken}    searchFilters=${searchFilters}    sortBy=${sortBy}    channelId=223    keyword=${keyword}    requestedStatistic=${requestedStatistic}    
    Should Be Equal As Strings    ${status_code}    422  

TC04 : Post Campaign Offer Retrieve without optional parameter(searchFilters, sortBy, channelId, transactionId, keyword, requestedStatistic)
    ${accessToken}=    Get Access Token NBC
    ${campaignOfferRetrieveResponse}    ${status_code}=    Post Campaign Offer Retrieve    ${accessToken}    phoneNo=${NBC_DIGI_PREPAID_OFFER_RETRIEVAL}    transactionId=ANYVALUE
    Should Be Equal As Strings    ${status_code}    200  

TC05 : Post Campaign Offer Retrieve without request body
    ${accessToken}=    Get Access Token NBC
    ${campaignOfferRetrieveResponse}    ${status_code}=    Post Campaign Offer Retrieve    ${accessToken}    transactionId=ANYVALUE
    Should Be Equal As Strings    ${status_code}    422  

TC06 : Post Campaign Offer Retrieve with empty string
    ${accessToken}=    Get Access Token NBC
    ${f1}=    Create Dictionary    channel=${EMPTY}    zone=${EMPTY}
    ${searchFilters}=    Create List    ${f1}
    ${sortBy}=    Create Dictionary    params=${EMPTY}    order=${EMPTY}
    ${k1}=    Create Dictionary    text=${EMPTY}
    ${k2}=    Create Dictionary    text=${EMPTY}
    ${k3}=    Create Dictionary    text=${EMPTY}
    ${k4}=    Create Dictionary    text=${EMPTY}
    ${k5}=    Create Dictionary    text=${EMPTY}
    ${keyword}=    Create List    ${k1}    ${k2}    ${k3}    ${k4}    ${k5}
    ${idList}=    Create List    ${EMPTY}    ${EMPTY}
    ${requestedStatistic}=    Create Dictionary    id=${idList}
    ${campaignOfferRetrieveResponse}    ${status_code}=    Post Campaign Offer Retrieve    ${accessToken}    phoneNo=${EMPTY}    searchFilters=${searchFilters}    sortBy=${sortBy}    channelId=${EMPTY}   transactionId=${EMPTY}     keyword=${keyword}    requestedStatistic=${requestedStatistic}    
    Should Be Equal As Strings    ${status_code}    422  

TC07 : Post Campaign Offer Retrieve with invalid subscriber(invalid service number-incorrect format & less than 10 char)
    ${accessToken}=    Get Access Token NBC
    ${f1}=    Create Dictionary    channel=PULSE    zone=MSA_NBO_PRIMARY
    ${searchFilters}=    Create List    ${f1}
    ${sortBy}=    Create Dictionary    params=offer:campaignPriority    order=Asc
    ${k1}=    Create Dictionary    text=SA Message - EN
    ${k2}=    Create Dictionary    text=SA Message - BM
    ${k3}=    Create Dictionary    text=SA Message - MD
    ${k4}=    Create Dictionary    text=Opt-in Keyword
    ${k5}=    Create Dictionary    text=Postpaid/Prepaid Indicator
    ${keyword}=    Create List    ${k1}    ${k2}    ${k3}    ${k4}    ${k5}
    ${idList}=    Create List    37199    137825
    ${requestedStatistic}=    Create Dictionary    id=${idList}
    ${campaignOfferRetrieveResponse}    ${status_code}=    Post Campaign Offer Retrieve    ${accessToken}    phoneNo=${INVALID_FORMAT_MSISDN_SHORT}    searchFilters=${searchFilters}    sortBy=${sortBy}    channelId=223    keyword=${keyword}    requestedStatistic=${requestedStatistic}    
    Should Be Equal As Strings    ${status_code}    422  

TC08 : Post Campaign Offer Retrieve with invalid subscriber(invalid service number-incorrect format & more than 12 char)
    ${accessToken}=    Get Access Token NBC
    ${f1}=    Create Dictionary    channel=PULSE    zone=MSA_NBO_PRIMARY
    ${searchFilters}=    Create List    ${f1}
    ${sortBy}=    Create Dictionary    params=offer:campaignPriority    order=Asc
    ${k1}=    Create Dictionary    text=SA Message - EN
    ${k2}=    Create Dictionary    text=SA Message - BM
    ${k3}=    Create Dictionary    text=SA Message - MD
    ${k4}=    Create Dictionary    text=Opt-in Keyword
    ${k5}=    Create Dictionary    text=Postpaid/Prepaid Indicator
    ${keyword}=    Create List    ${k1}    ${k2}    ${k3}    ${k4}    ${k5}
    ${idList}=    Create List    37199    137825
    ${requestedStatistic}=    Create Dictionary    id=${idList}
    ${campaignOfferRetrieveResponse}    ${status_code}=    Post Campaign Offer Retrieve    ${accessToken}    phoneNo=${INVALID_FORMAT_MSISDN_LONG}    searchFilters=${searchFilters}    sortBy=${sortBy}    channelId=223    keyword=${keyword}    requestedStatistic=${requestedStatistic}    
    Should Be Equal As Strings    ${status_code}    422  

TC09 : Post Campaign Offer Retrieve with invalid subscriber(invalid service number-incorrect format)
    ${accessToken}=    Get Access Token NBC
    ${f1}=    Create Dictionary    channel=PULSE    zone=MSA_NBO_PRIMARY
    ${searchFilters}=    Create List    ${f1}
    ${sortBy}=    Create Dictionary    params=offer:campaignPriority    order=Asc
    ${k1}=    Create Dictionary    text=SA Message - EN
    ${k2}=    Create Dictionary    text=SA Message - BM
    ${k3}=    Create Dictionary    text=SA Message - MD
    ${k4}=    Create Dictionary    text=Opt-in Keyword
    ${k5}=    Create Dictionary    text=Postpaid/Prepaid Indicator
    ${keyword}=    Create List    ${k1}    ${k2}    ${k3}    ${k4}    ${k5}
    ${idList}=    Create List    37199    137825
    ${requestedStatistic}=    Create Dictionary    id=${idList}
    ${campaignOfferRetrieveResponse}    ${status_code}=    Post Campaign Offer Retrieve    ${accessToken}    phoneNo=${INVALID_FORMAT}    searchFilters=${searchFilters}    sortBy=${sortBy}    channelId=223    keyword=${keyword}    requestedStatistic=${requestedStatistic}    
    Should Be Equal As Strings    ${status_code}    422  

TC10 : Post Campaign Offer Retrieve with invalid subscriber(invalid service number-less than 10 char)
    ${accessToken}=    Get Access Token NBC
    ${f1}=    Create Dictionary    channel=PULSE    zone=MSA_NBO_PRIMARY
    ${searchFilters}=    Create List    ${f1}
    ${sortBy}=    Create Dictionary    params=offer:campaignPriority    order=Asc
    ${k1}=    Create Dictionary    text=SA Message - EN
    ${k2}=    Create Dictionary    text=SA Message - BM
    ${k3}=    Create Dictionary    text=SA Message - MD
    ${k4}=    Create Dictionary    text=Opt-in Keyword
    ${k5}=    Create Dictionary    text=Postpaid/Prepaid Indicator
    ${keyword}=    Create List    ${k1}    ${k2}    ${k3}    ${k4}    ${k5}
    ${idList}=    Create List    37199    137825
    ${requestedStatistic}=    Create Dictionary    id=${idList}
    ${campaignOfferRetrieveResponse}    ${status_code}=    Post Campaign Offer Retrieve    ${accessToken}    phoneNo=${INVALID_MSISDN_SHORT}    searchFilters=${searchFilters}    sortBy=${sortBy}    channelId=223    keyword=${keyword}    requestedStatistic=${requestedStatistic}    
    Should Be Equal As Strings    ${status_code}    422  

TC11 : Post Campaign Offer Retrieve with invalid subscriber(invalid service number-more than 12 char)
    ${accessToken}=    Get Access Token NBC
    ${f1}=    Create Dictionary    channel=PULSE    zone=MSA_NBO_PRIMARY
    ${searchFilters}=    Create List    ${f1}
    ${sortBy}=    Create Dictionary    params=offer:campaignPriority    order=Asc
    ${k1}=    Create Dictionary    text=SA Message - EN
    ${k2}=    Create Dictionary    text=SA Message - BM
    ${k3}=    Create Dictionary    text=SA Message - MD
    ${k4}=    Create Dictionary    text=Opt-in Keyword
    ${k5}=    Create Dictionary    text=Postpaid/Prepaid Indicator
    ${keyword}=    Create List    ${k1}    ${k2}    ${k3}    ${k4}    ${k5}
    ${idList}=    Create List    37199    137825
    ${requestedStatistic}=    Create Dictionary    id=${idList}
    ${campaignOfferRetrieveResponse}    ${status_code}=    Post Campaign Offer Retrieve    ${accessToken}    phoneNo=${INVALID_MSISDN_LONG}    searchFilters=${searchFilters}    sortBy=${sortBy}    channelId=223    keyword=${keyword}    requestedStatistic=${requestedStatistic}    
    Should Be Equal As Strings    ${status_code}    422  
