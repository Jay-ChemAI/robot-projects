*** Settings ***
Library    SeleniumLibrary
Library    OperatingSystem
Library    BuiltIn
Library    RPA.Desktop.Windows

*** Variables ***
${URL}            https://www.youtube.com
${USERNAME}       
${PASSWORD}       
${CHROME_DRIVER_PATH}     C:/Users/javie/Desktop/robot-projects-main/robot-projects/chromedriver-win64/chromedriver.exe

*** Test Cases ***
Download and statuss
    ${result_of_opening}=        Run Keyword And Return Status          Open_insta
    
*** Keywords ***
Open_insta
    Set Environment Variable    webdriver.chrome.driver    ${CHROME_DRIVER_PATH}
    ${chrome_options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    #Call Method    ${chrome_options}    add_argument    --headless
    Call Method    ${chrome_options}    add_argument    --disable-gpu
    Call Method    ${chrome_options}    add_argument    --no-sandbox
    Call Method    ${chrome_options}    add_argument    --disable-dev-shm-usage
    Create Webdriver    Chrome    options=${chrome_options}
    Sleep   1S
    Go To    ${URL}
    Sleep   10S
