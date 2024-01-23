*** Settings ***
Documentation      This is a bot for download something
Library            SeleniumLibrary
Library            Process
Library            BuiltIn

*** Variables ***
${BROWSER}          Chrome
${URL}              http://www.google.com
${BROWSER_DIR}      ${CURDIR}$/chromedriver-win64/chromedriver.exe

*** Tasks ***


*** Keywords ***
    Set Environment Variable    webdriver.chrome.driver    ${CHROME_DRIVER_PATH}