*** Settings ***
Documentation     Bot for download dataset from chembl
Library           SeleniumLibrary
Library           OperatingSystem
Library           Process
Library           json
Library           BuiltIn
 
*** Variables ***
${URL}                    https://www.ebi.ac.uk/chembl/g/#browse/compounds
${BROWSER}                CHROME
${CHROME_DRIVER_PATH}     C:\Users\javie\Desktop\robot-projects-main\robot-projects\chromedriver-win64

*** Test Cases ***
run
   #${download}=    Download Full Dataset
   #${run_proces}=  process 
   ${csvring}=     csvring
   #${comparation}=  comparation
***Keywords***
Download Full Dataset
    ${new_folder}    Set Variable    dataset
    Create Directory    ${new_folder}
    ${DOWNLOAD_DIR}    Set Variable    ${CURDIR}${/}${new_folder}
    Set Environment Variable    webdriver.chrome.driver    ${CHROME_DRIVER_PATH}
    ${chrome_options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    Call Method    ${chrome_options}    add_argument    --headless
    Call Method    ${chrome_options}    add_argument    --disable-gpu
    Call Method    ${chrome_options}    add_argument    --no-sandbox
    Call Method    ${chrome_options}    add_argument    --disable-dev-shm-usage
    ${prefs}=    Create Dictionary    download.default_directory    ${DOWNLOAD_DIR}
    Call Method    ${chrome_options}    add_experimental_option    prefs    ${prefs}
    Create Webdriver    Chrome    options=${chrome_options}
    Go To    ${URL}
    Sleep   5S
    Click Element      xpath=(//a[contains(@class,'menu-button big')])[1]
    Sleep   2S
    Click Element      xpath=//div[@class='BCK-download-link-container']//a[1]
    Sleep   100S
    Close Browser
process 
    ${DOWNLOAD_DIR}    Set Variable    ${CURDIR}${/}dataset
    ${result}    Run Process    python    extract.py    ${DOWNLOAD_DIR}
csvring
    ${DOWNLOAD_DIR}    Set Variable    ${CURDIR}${/}dataset
    ${result}    Run Process    python    newcsv.py    ${DOWNLOAD_DIR}
    
comparation
    ${filtrated}    Set Variable    ${CURDIR}${/}dataset/FL.csv
    ${result}    Run Process    python    comparation.py    ${filtrated}   
   # Remove file      ${CURDIR}${/}dataset/compuestos_filtrados.csv 