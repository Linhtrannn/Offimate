*** Settings ***
Resource    ../Common/Common_Keywords.robot
Library     String

*** Variables ***
${flash_sale_title}      xpath://span[normalize-space()='FLASH SALES & HOT DEALS']
${show_more_button}      xpath://a[normalize-space()='SEE MORE' and @data-seemore-id='See More/Flash Deal']
${product_item_name}     xpath://a[normalize-space()='{param}']
${add_to_cart_button}    xpath://a[normalize-space()='{param}']//ancestor::div[@class='ERPfP']//following-sibling::div[@class='ERPfP']//div[contains(@id,'btn-addCart')]/span
${star_rate}             xpath://a[normalize-space()='{param}']//ancestor::div[@class='ERPfP']//following-sibling::div[@class='ERPfP']/div[@id='pnl-starRating']
${input_text_box}        xpath:(//input[contains(@id,'txt-AddToCartQty')])[1]
${product_title}         xpath://h1[normalize-space()='{param}']
${mini_cart}             xpath://span[@id['lbl-minicartQty'] and @data-testid='btn-viewMainHeader-CartQty']
${frame}                 xpath://iframe[contains(@classname,'sp-fancybox-iframe')]
${x_button}              xpath://i[@id='icon-close-button-1454703945249']
${add_cart_js}                     //a[normalize-space()='{param}']//ancestor::div[@class='ERPfP']//following-sibling::div[@class='ERPfP']//div[contains(@id,'btn-addCart')]/span
${sku}                    xpath://div[normalize-space()='{param}']
${price}    xpath://h3[normalize-space()='{param}']/ancestor::div[@class='ERPfP']/following-sibling::div//div[contains(@id,'lbl-ProductList-Price')]
*** Keywords ***
Verfiy Label Flash Sales Title
    Common_Keywords.Wait To Element Visible    ${flash_sale_title}

Verify Show More button
    Common_Keywords.Wait To Element Visible    ${show_more_button}

Enter The Quantity And Verify
    [Arguments]                   ${data_qty}                  ${qty}
    Common_Keywords.Input data    ${input_text_box}            ${data_qty}
    ${text_in_input_textbox}=     SeleniumLibrary.Get Value    ${text_in_input_textbox}
    Should Be Equal               ${text_in_input_textbox}     ${text_in_input_textbox}

Verify Maximum Quantity
    [Arguments]                                   ${qty}               ${maximum}
    Common_Keywords.Input data                    ${input_text_box}    ${qty}
    Common_Keywords.Get text and compare value    ${input_text_box}    ${maximum}

Verify Infor Of Product Item
    Common_Keywords.Wait To Element Visible    ${star_rate}
    Common_Keywords.Wait To Element Visible    ${add_to_cart_button}

Verify Product Infor
    [Arguments]                  ${product_name}    ${sku_name}    ${price_pro}
    ${product_item_name}=        Format String           ${product_item_name}    param=${product_name}
    ${sku}=        Format String           ${sku}    param=${sku_name}
    ${price}=    Format String           ${price}    param=${product_name}
    Element Should Be Visible    ${product_item_name}
    Element Should Be Visible    ${sku}

Verify Cart Button And Star Rate Should Be Displayed Below Each Product Item
    [Arguments]               ${product_name}
    ${add_to_cart_button}=    Format String      ${add_to_cart_button}    param=${product_name}    
    ${star_rate}=             Format String      ${star_rate}             param=${product_name}    

Verify Page Should Be Naviagate When Select Any Product Item
    ${product_name}                            Set Variable            OFM Copier Paper A4 80 gsm. 500 Sheets 5 Reams/Pack    
    ${product_item_name}=                      Format String           ${product_item_name}                                   param=${product_name}
    Click Element                              ${product_item_name}
    ${product_title}=                          Format String           ${product_title}                                       param=${product_name}
    Common_Keywords.Wait To Element Visible    ${product_title}

Verifu Maximum Amount Product
    ${maximum}                    Set Variable         1426
    Common_Keywords.Input Data    ${input_text_box}    9000

Verify Mini Cart By Using Click On Add Button Cart
    ${qty_cart}=               SeleniumLibrary.Get Text    ${mini_cart}
    ${qty_before_add_cart}=    Convert To Integer          ${qty_cart}
    ${product_name}=    Set Variable     OFM Copier Paper A4 80 gsm. 500 Sheets 5 Reams/Pack  
    ${add_cart_js}=        Format String           ${add_cart_js}    param=${product_name}
    SeleniumLibrary.Execute Javascript    document.evaluate("${add_cart_js}",document.body,null,9,null).singleNodeValue.click();
    # Add to cart from radom product
    ${add_cart}=               SeleniumLibrary.Get Text    ${mini_cart}
    ${qty_after_add_cart}=     Convert To Integer          ${add_cart}
    ${epxected_qty}    Evaluate    1+${qty_before_add_cart}

    Should Be Equal    ${qty_after_add_cart}    ${epxected_qty}

Verify Mini Cart By Using Input Text Box
    [Arguments]                ${qty}                      ${qty_in_mini_cart}
    ${qty_cart}=               SeleniumLibrary.Get Text    ${mini_cart}
    ${qty_before_add_cart}=    Convert To Integer          ${qty_cart}
    Input data                 ${input_text_box}           ${input_text_box}
    ${product_name}            Set Variable                OFM Copier Paper A4 80 gsm. 500 Sheets 5 Reams/Pack    
    # Add to cart from radom product
    Click Element              ${add_to_cart_button}       param=${product_name}
    ${add_cart}=               SeleniumLibrary.Get Text    ${mini_cart}
    ${qty_after_add_cart}=     Convert To Integer          ${add_cart}

    Run Keyword If    ${qty_after_add_cart}<99            Should Be Equal    ${qty_after_add_cart}    ${qty_before_add_cart}+${qty}
    Run Keyword If    ${qty_before_add_cart}+${qty}>99    Should Be Equal    99+                      ${qty_after_add_cart}

Close popup if it appeared
    Run Keyword And Ignore Error    SeleniumLibrary.Element Should Be Visible    ${frame}
    Run Keyword And Ignore Error    SeleniumLibrary.Select Frame                 ${frame}
    Run Keyword And Ignore Error    Click Element                                ${x_button}
    Run Keyword And Ignore Error    SeleniumLibrary.Unselect Frame




