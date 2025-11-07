*** Settings ***
Documentation    This file will only store libraries and resources.

#LIBRARY
Library    RequestsLibrary
Library    JSONLibrary
Library    Collections
Library    String
Library     DateTime

#VARIABLES
Resource    ../MOLI/TestVariables/moli-variables1.robot

#KEYWORDS
Resource    ../MOLI/TestKeywords/moli-keywords.robot
