*** Settings ***
Library     RequestsLibrary
Library     JSONLibrary
Library     Collections
Library     SeleniumLibrary
Resource    ../../Keywords/API/get_request.robot

Resource    ../../Keywords/Web/PageObjects/Home.robot
Library     DataDriver                                   ../../TestData/data.xlsx    sheet_name=APi_data

Variables    ../../TestData/test.evn.yaml

Test Template    Flash Sale - Home

Test Setup       Common_Keywords.Open browser to page    ${page_url}
Test Teardown    SeleniumLibrary.Close Browser

*** Test Cases ***
Verify Fash Sale - Home    ${is_flash_deal}    ${flash_deal_enable}      ${sort}             ${type_id}              ${typeid}          ${flash_deal_from}
                           ...                 ${flash_deal_from_day}    ${flash_deal_to}    ${flash_deal_to_day}    ${x_subject_id}    ${visibility}
                           ...                 ${status}                 ${cookie}           ${x-newrelic-id}        ${x-store-code}    ${response_code}

*** Keywords ***
Flash Sale - Home
    [Arguments]    ${is_flash_deal}          ${flash_deal_enable}    ${sort}                 ${type_id}         ${typeid}           ${flash_deal_from}
    ...            ${flash_deal_from_day}    ${flash_deal_to}        ${flash_deal_to_day}    ${x_subject_id}    ${visibility}
    ...            ${status}                 ${cookie}               ${x-newrelic-id}        ${x-store-code}    ${response_code}
    
    Home.Close popup if it appeared
# Verify lable of flash sale
     Home.Verfiy Label Flash Sales Title

#    Verify see more button
   Home.Verify Show More button

   # Verfiy add to add from flash sale
   Home.Verify Mini Cart By Using Click On Add Button Cart

#    Get response payload
     ${res}=                 get_request.Get Reponse Payload    ${is_flash_deal}    ${flash_deal_enable}    ${sort}            ${type_id}       ${typeid}    ${flash_deal_from}
     ...                     ${flash_deal_from_day}             ${flash_deal_to}    ${flash_deal_to_day}    ${x_subject_id}    ${visibility}
     ...                     ${status}                          ${cookie}           ${x-newrelic-id}        ${x-store-code}    ${api_url}

    ${json_object}=	Convert String to JSON	${res}
    ${product_info}=                                                                     Set variable                                    ${json_object['products']['products']}
    ${total_product}                                                                     Get Length                                      ${product_info}
    # # Verify product item infor
    FOR    ${i}    IN RANGE    ${total_product}
        ${product_name}    Set Variable     ${product_info}[${i}][name]
        ${sku}    Set Variable    ${product_info}[${i}][sku]
        ${price}    Convert To Number    ${product_info}[${i}][tier_prices][0][price]    2
        Home.Verify Product Infor    ${product_name}    ${sku}    ${price}
        Home.Verify Cart Button And Star Rate Should Be Displayed Below Each Product Item    ${product_name}
    END

    # Verify navigate to product page
    Home.Verify Page Should Be Naviagate When Select Any Product Item

