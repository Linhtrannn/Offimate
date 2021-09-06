*** Settings ***
Resource    ../../Keywords/API/post_request.robot
Library     DataDriver                              ../../TestData/data_api.xlsx    sheet_name=Post

Variables    ../../TestData/test.evn.yaml

Test Template    Post Request

*** Test Cases ***
Post And Validation    ${is_flash_deal}          ${flash_deal_enable}    ${sort}                 ${type_id}         ${typeid}        ${flash_deal_from}
    ...            ${flash_deal_from_day}    ${flash_deal_to}        ${flash_deal_to_day}    ${x_subject_id}    ${visibility}
    ...            ${status}                 ${cookie}               ${x-newrelic-id}        ${x-store-code}    ${response_code}

*** Keywords ***
Post Request
    [Arguments]    ${is_flash_deal}          ${flash_deal_enable}    ${sort}                 ${type_id}         ${typeid}        ${flash_deal_from}
    ...            ${flash_deal_from_day}    ${flash_deal_to}        ${flash_deal_to_day}    ${x_subject_id}    ${visibility}
    ...            ${status}                 ${cookie}               ${x-newrelic-id}        ${x-store-code}    ${response_code}

    post_request.Post And Vaidation    ${is_flash_deal}    ${flash_deal_enable}    ${sort}            ${type_id}       ${typeid}    ${flash_deal_from}
    ...      ${flash_deal_from_day}           ${flash_deal_to}    ${flash_deal_to_day}    ${x_subject_id}    ${visibility}
    ...      ${status}                        ${cookie}           ${x-newrelic-id}        ${x-store-code}    ${api_url}    ${response_code}    