*** Settings ***
Library    RequestsLibrary
Library    JSONLibrary
Library    Collections
Library    jsonschema
Library    OperatingSystem

Resource    api_request.robot

*** Keywords ***
# Validation reponse
Post And Vaidation
    [Arguments]    ${is_flash_deal}          ${flash_deal_enable}    ${sort}                 ${type_id}         ${typeid}        ${flash_deal_from}
    ...            ${flash_deal_from_day}    ${flash_deal_to}        ${flash_deal_to_day}    ${x_subject_id}    ${visibility}
    ...            ${status}                 ${cookie}               ${x-newrelic-id}        ${x-store-code}    ${api_url}       ${response_code}

    ${status}    ${resp}=                  BuiltIn.Run Keyword And Ignore Error    api_request.Post Request    ${is_flash_deal}    ${flash_deal_enable}    ${sort}    ${type_id}    ${typeid}    ${flash_deal_from}
    ...          ${flash_deal_from_day}    ${flash_deal_to}                        ${flash_deal_to_day}        ${x_subject_id}     ${visibility}
    ...          ${status}                 ${cookie}                               ${x-newrelic-id}            ${x-store-code}     ${api_url}

    Run Keyword If    '${status}'=='PASS'    Status Should Be    ${resp}    ${response_code}
    Run Keyword If    '${status}'=='FAIL'    Should Contain      ${resp}    ${response_code}    
