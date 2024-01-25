*** Settings ***
Library    SeleniumLibrary
Library    OperatingSystem
Library    BuiltIn
Library    RPA.Desktop.Windows

*** Variables ***
${URL}            https://download.virtualbox.org/virtualbox/7.0.14/VirtualBox-7.0.14-161095-Win.exe
${DOWNLOAD_DIR}   C:/Users/javie/Downloads
${CHROME_DRIVER_PATH}     ${CURDIR}${/}/chromedriver-win64/chromedriver.exe

*** Test Cases ***
Download and statuss
    #result_of_download}=  Run Keyword And Return Status           Download VirtualBox
    ${result_of_run_installer}=  Run Keyword And Return Status          Run the installer
    

*** Keywords ***
Download VirtualBox
    Set Environment Variable    webdriver.chrome.driver    ${CHROME_DRIVER_PATH}
    ${chrome_options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    #Call Method    ${chrome_options}    add_argument    --headless
    Call Method    ${chrome_options}    add_argument    --disable-gpu
    Call Method    ${chrome_options}    add_argument    --no-sandbox
    Call Method    ${chrome_options}    add_argument    --disable-dev-shm-usage
    ${prefs}=    Create Dictionary    download.default_directory    ${DOWNLOAD_DIR}
    Call Method    ${chrome_options}    add_experimental_option    prefs    ${prefs}
    ${prefs2}=    Create Dictionary     safebrowsing.enabled            False
    Call Method    ${chrome_options}    add_experimental_option    prefs    ${prefs2}
    Create Webdriver    Chrome    options=${chrome_options}
    Sleep   1s
    Go To    ${URL}
    Log    Waiting for download...
    Sleep   20s
    Log    Succesful download!

Run the installer
    ${status_of_open_installer}=    Run Executable    ${DOWNLOAD_DIR}/VirtualBox-7.0.14-161095-Win.exe
    Log    ${status_of_open_installer}