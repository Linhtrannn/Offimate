*** Settings ***
Library    RequestsLibrary
Library    JSONLibrary
Library    Collections
Library    jsonschema
Library    OperatingSystem

# Resource    ${CURDIR}../../TestData/test.evn.yaml

*** Variables ***

*** Keywords ***
Get Request
    [Arguments]    ${is_flash_deal}          ${flash_deal_enable}    ${sort}                 ${type_id}         ${typeid}        ${flash_deal_from}
    ...            ${flash_deal_from_day}    ${flash_deal_to}        ${flash_deal_to_day}    ${x_subject_id}    ${visibility}
    ...            ${status}                 ${cookie}               ${x-newrelic-id}        ${x-store-code}    ${api_url}

    ${header}=    Create Dictionary    cookie=${cookie}    x-newrelic-id=${x-newrelic-id}    x-store-code=${x-store-code}
    ${resp}=      GET    ${api_url}/search/productSection/en
    ...        params=is_flash_deal=${is_flash_deal}&flash_deal_enable=${flash_deal_enable}&sort=${sort}&type_id=$neq&type_id=${typeid}&flash_deal_from=${flash_deal_from}&flash_deal_from=${flash_deal_from_day}&flash_deal_to=${flash_deal_to}&flash_deal_to=${flash_deal_to_day}&x_subject_id=${x_subject_id}&visibility=${visibility}&status=${status}
    ...           headers=${header}
    
    [Return]      ${resp}                                                                                                                                                

Post Request
    [Arguments]    ${is_flash_deal}          ${flash_deal_enable}    ${sort}                 ${type_id}         ${typeid}        ${flash_deal_from}
    ...            ${flash_deal_from_day}    ${flash_deal_to}        ${flash_deal_to_day}    ${x_subject_id}    ${visibility}
    ...            ${status}                 ${cookie}               ${x-newrelic-id}        ${x-store-code}    ${api_url}

    ${header}=    Create Dictionary    cookie=${cookie}    x-newrelic-id=${x-newrelic-id}    x-store-code=${x-store-code}
    ${resp}=      POST    ${api_url}/search/productSection/en
    ...        params=is_flash_deal=${is_flash_deal}&flash_deal_enable=${flash_deal_enable}&sort=${sort}&type_id=$neq&type_id=${typeid}&flash_deal_from=${flash_deal_from}&flash_deal_from=${flash_deal_from_day}&flash_deal_to=${flash_deal_to}&flash_deal_to=${flash_deal_to_day}&x_subject_id=${x_subject_id}&visibility=${visibility}&status=${status}
    ...           headers=${header}
    
    [Return]      ${resp} 