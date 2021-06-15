*** Settings ***
Documentation       Tests for icon keywords
Library             QWeb
Suite Setup         OpenBrowser    about:blank    ${BROWSER}
Test Setup          GoTo    file://${CURDIR}/../resources/items.html
Suite Teardown      CloseBrowser
Library             Dialogs
Test Timeout        1min

*** Variables ***
${BROWSER}                  chrome
${BASE_IMAGE_PATH}          ${CURDIR}${/}..${/}resources${/}pics_and_icons${/}icons

*** Test Cases ***
Click icons
    [Tags]                  PROBLEM_IN_WINDOWS	PROBLEM_IN_FIREFOX  RESOLUTION_DEPENDENCY
    SetConfig               WindowSize          1920x1080
    Sleep                   2
    ClickIcon               person
    VerifyText              person is my tooltip value!
    ClickIcon               lock
    VerifyText              Lock is my title value!
    ClickIcon               screen
    VerifyText              screen is my data-icon value!

Verify icons
    [Tags]                  PROBLEM_IN_WINDOWS	PROBLEM_IN_FIREFOX  RESOLUTION_DEPENDENCY
    VerifyIcon              person
    VerifyIcon              power
    VerifyIcon              paperclip
    VerifyIcon              infinity
    VerifyIcon              Lock
    VerifyIcon              screen


Click icons new screenshot
    [Tags]                  PROBLEM_IN_WINDOWS	PROBLEM_IN_FIREFOX  RESOLUTION_DEPENDENCY
    ClickIcon               person
    ClickIcon               power
    ClickText               Hide
    Run Keyword And Expect Error   ClickIcon                   person   timeout=3
    Should Not Be True      ${status}


Capture icons and verify them
    [Tags]                  PROBLEM_IN_WINDOWS  PROBLEM_IN_FIREFOX  RESOLUTION_DEPENDENCY
    [Teardown]              RemoveFiles
    CaptureIcon             person     ${BASE_IMAGE_PATH}     capture_icon_1.png
    VerifyIcon              capture_icon_1
    CaptureIcon             power      ${BASE_IMAGE_PATH}     capture_icon_2.png
    VerifyIcon              capture_icon_2
    CaptureIcon             /html/body/table/tbody/tr[1]/td[6]/img      ${BASE_IMAGE_PATH}
    ...                     capture_icon_3.png
    VerifyIcon              capture_icon_3

IsIcon True
    [Tags]                  PROBLEM_IN_WINDOWS	PROBLEM_IN_FIREFOX  RESOLUTION_DEPENDENCY
    ${result}               isIcon                  paperclip
    Should Be True          ${result}

IsIcon False
    [Tags]                  PROBLEM_IN_WINDOWS  RESOLUTION_DEPENDENCY
    ${result}               isIcon                  plane
    Should Not Be True      ${result}

WriteText
    [Tags]                  jailed	PROBLEM_IN_FIREFOX      RESOLUTION_DEPENDENCY
    CloseAllBrowsers
    OpenBrowser             file://${CURDIR}/../resources/input.html    chrome
    ClickIcon               leftright
    WriteText               FooBar
    VerifyInputValue        odjdq               Foobar     selector=id


*** Keywords ***
RemoveFiles
    [Documentation]     Remove files used in CaptureIcon test
    RemoveFile          ${BASE_IMAGE_PATH}/capture_icon_1.png
    RemoveFile          ${BASE_IMAGE_PATH}/capture_icon_2.png
    RemoveFile          ${BASE_IMAGE_PATH}/capture_icon_3.png