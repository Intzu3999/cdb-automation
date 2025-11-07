*** Settings ***
Documentation    This file will only store libraries and resources.

#LIBRARY
Library    RequestsLibrary
Library    JSONLibrary
Library    Collections
Library    String
Library    DateTime

#VARIABLES
# Resource    ../MOLI/TestVariables/moli-variables1.robot
Resource    ../MOLI/TestVariables/moli-shared-variable.robot
Resource    ../MOLI/TestVariables/moli-reload-variable.robot
Resource    ../MOLI/TestVariables/moli-reload-history-variable.robot
Resource    ../MOLI/TestVariables/moli-subscriber-variable.robot
Resource    ../MOLI/TestVariables/moli-invoice-info-variable.robot
Resource    ../MOLI/TestVariables/moli-invoice-bill-payment-history-variable.robot
Resource    ../MOLI/TestVariables/moli-addon-variable.robot
Resource    ../MOLI/TestVariables/moli-account-variable.robot
Resource    ../MOLI/TestVariables/moli-customer-variable.robot
Resource    ../MOLI/TestVariables/moli-eligibility-variable.robot
Resource    ../MOLI/TestVariables/moli-esim-variable.robot
Resource    ../MOLI/TestVariables/moli-msisdn-variable.robot
Resource    ../MOLI/TestVariables/moli-prepaid-registration-variable.robot
Resource    ../MOLI/TestVariables/moli-sipadan-variable.robot
