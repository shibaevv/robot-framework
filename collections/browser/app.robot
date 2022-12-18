*** Settings ***
Documentation    App
...    vi ~/.bashrc
...    export LOGIN=<user_login>
...    export PASSWORD=<user_password>
...    ./run.sh collections/browser/app.robot
Resource          app-api.resource
Variables         app-data.py
Suite Setup       APP Login
Suite Teardown    APP Logout

*** Test Cases ***
App
    Set Suite Variable    ${env}    ${data[env]}
    ${path}=    Set Variable    ${data[path]}
    APP Navigate To    ${BASE_URL}/${path}
    Sleep    60s
    APP Submit
