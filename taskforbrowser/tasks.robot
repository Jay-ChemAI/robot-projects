*** Settings ***
Documentation      This is a bot for download something
Library            SeleniumLibrary
Library            Process
Library            BuiltIn

*** Variables ***
${BROWSER}          Chrome
${URL}              https://download.virtualbox.org/virtualbox/7.0.14/VirtualBox-7.0.14-161095-Win.exe
${BROWSER_DIR}      ${CURDIR}$/chromedriver-win64/chromedriver.exe

*** Test Cases ***
${Download} = Run Keyword and Return Status    Download VirtualBox
IF    ${Download} == True
    Log To Console    Download VirtualBox Success
ELSE
    Log To Console    Download VirtualBox Failed
END

*** Keywords ***
Download VirtualBox
    Set Environment Variable    webdriver.chrome.driver    ${CHROME_DRIVER_PATH}
    ${chrome_options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    Call Method    ${chrome_options}    add_argument    --headless
    Call Method    ${chrome_options}    add_argument    --disable-gpu
    Call Method    ${chrome_options}    add_argument    --no-sandbox
    Call Method    ${chrome_options}    add_argument    --disable-dev-shm-usage
    Create Webdriver    Chrome    options=${chrome_options}
    Go To    ${URL}