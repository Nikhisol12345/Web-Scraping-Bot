# -*- coding: utf-8 -*-
*** Settings ***
Documentation   Propero RPA Challenge
Library         RPA.Browser
Library         RPA.HTTP
Library         RPA.core.notebook
Library         RPA.Tables
Library         RPA.Desktop
Library         RPA.Email.ImapSmtp   smtp_server=smtp.gmail.com  smtp_port=587
Task Setup      Authorize  account=${GMAIL_ACCOUNT}  password=${GMAIL_PASSWORD}

***keywords***
Open the rpa challenge website
    Open Available Browser  https://prsindia.org/
    Maximize Browser Window

***keywords***
Click on “Covid-19” in the Navigation Bar
    Click Element  //a[@class="nav-link" and text()="COVID-19"] 

***keywords***
Click on “Number of Cases” on the Side Bar
    Click Element  //a[@class="facetapi-inactive" and text()="Number of Cases"]

***keywords***
Download the “CSV”
    Download  https://prsindia.org/covid-19/cases/download  ${CURDIR}${/}download.csv
    Close Browser

*** Keywords ***
Extracted data and create new csv
    ${data}=  Read Table From Csv  download.csv
    Filter Table By Column  ${data}  Region  ==  Madhya Pradesh 
    Write table to CSV  ${data}  ${CURDIR}${/}Nikhil_Covid_19_cases.csv

*** Variables ***
${GMAIL_ACCOUNT}        solankinikhil520@gmail.com
${GMAIL_PASSWORD}       ***********
${RECIPIENT_ADDRESS}    XYZ@gmail.com

*** Keywords ***
Sending email
    Send Message      sender=${GMAIL_ACCOUNT}
        ...           recipients=${RECIPIENT_ADDRESS}
        ...           subject=RPA Robot
        ...           attachments=${CURDIR}${/}Nikhil_Covid_19_cases.csv

*** Tasks ***
Propero RPA Challenge
    Open the rpa challenge website
    Click on “Covid-19” in the Navigation Bar 
    Click on “Number of Cases” on the Side Bar 
    Download the “CSV” 
    Extracted data and create new csv
    Sending email
