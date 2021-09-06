*** Setting ***

*** Variable ***
${GLOBALTIMEOUT}    ${30}

*** Keywords ***
Open Browser To Page
    [Arguments]                                ${url}               ${speed}=0.1
    ${options}=                                Evaluate             sys.modules['selenium.webdriver'].ChromeOptions()    sys
    ${exclude}=                                Create Dictionary    "fasp"=True
    ${prefs}=                                  Create Dictionary    protocol_handler.excluded_schemes=${exclude}
    Call Method                                ${options}           add_argument                                         --disable-infobars
    Call Method                                ${options}           add_argument                                         --disable-notifications
    Call Method                                ${options}           add_experimental_option                              prefs                      ${prefs}
    SeleniumLibrary.Create WebDriver           Chrome               chrome_options=${options}
    SeleniumLibrary.Maximize Browser Window
    SeleniumLibrary.Set Selenium Speed         ${speed}
    SeleniumLibrary.Go To                      ${url}

Click Element
    [Arguments]                                      ${locator}    ${timeout}=${GLOBALTIMEOUT}
    SeleniumLibrary.Wait Until Element Is Visible    ${locator}    timeout=${timeout}
    SeleniumLibrary.Click Element                    ${locator}

Wait To Element Visible
    [Arguments]                                         ${locator}
    SeleniumLibrary.Wait Until Page Contains Element    ${locator}    timeout=${GLOBALTIMEOUT}
    SeleniumLibrary.Wait Until Element Is Visible       ${locator}    timeout=${GLOBALTIMEOUT}

Close popup if it appeared
    [Arguments]                            ${elmement1}                                 ${element2}
    Run Keyword And Ignore Error           SeleniumLibrary.Element Should Be Visible    ${element1}
    BuiltIn.Wait Until Keyword Succeeds    3 x                                          1 sec          Common_Keywords.Clicck Element    ${element2}

Verify contains text in list
    [Arguments]                                    ${element}                         ${value}
    ${listElement}=                                SeleniumLibrary.Get WebElements    ${element}
    FOR                                            ${item}                            IN            @{listElement}
        ${text}=    SeleniumLibrary.Get Text           ${item}
        ${product_name}=    Convert To Upper Case    ${text}
        Should Contain    ${product_name}    ${value}
    END

Input data and verify text for web element
    [Arguments]                   ${locator}                   ${expect_text}
    SeleniumLibrary.Input Text    ${locator}                   ${expect_text}
    ${real_text}=                 SeleniumLibrary.Get Value    ${locator}
    Should Be Equal               '${real_text}'               '${expect_text}'

Input data
    [Arguments]                   ${locator}    ${value}
    Wait To Element Visible       ${locator} 
    SeleniumLibrary.Input Text    ${locator}    ${value}

Scroll To Element
    [Arguments]    ${locator}
    SeleniumLibrary.Scroll Element Into View    ${locator}

Scroll And Click Element
    [Arguments]    ${locator}
    Scroll To Element    ${locator}
    common_keywords.Click Element    ${locator}