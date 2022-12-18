*** Settings ***
Documentation    Browser API Resources
Library          Brrowser
Library          OperatingSystem
Library          String

*** Variables ***
${BASE_URL}            https://company.com/app
${LOGIN_URL}           ${BASE_URL}/login/
${LOGIN_SUCCESS_URL}   ${BASE_URL}/
${BROWSER}             chromium
${headless}            False
${pauseOnFailure}      False

*** Keywords ***
APP Login
    ${LOGIN}=    Get Environment Variable    $LOGIN    
    Open Browser           ${LOGIN_URL}    ${BROWSER}    ${headless}    ${pauseOnFailure}
    Type Text              input[name=login]       ${LOGIN}
    Type Secret            input[name=password]    %PASSWORD
    Click                  button#login
    Wait For Navigation    ${LOGIN_SUCCESS_URL}

APP Logout
    Close Browser

APP Navigate To
    [Arguments]    ${url}
    Go To    ${url}
    Wait Until Network Is Idle    timeout=5s

APP Submit
    Click    button[type=submit]

APP Select Option
    [Arguments]    ${id}    ${name}    ${label}
    Run Keyword If    '${id}' != '${EMPTY}'    Select Options By    select[id=${id}]        label    ${label}
    Run Keyword If    '${name}' != '${EMPTY}'  Select Options By    select[name=${name}]    label    ${label}
