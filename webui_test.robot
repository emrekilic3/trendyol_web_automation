*** Settings ***
Library  SeleniumLibrary
Library  helper.py
Resource  keywords.robot
Test Setup  Create web driver session
Test Teardown  Close all browsers

*** Variables ***

*** Test Cases ***

TC 1: Home page - Search a product and add most rated/free shipping product to the basket

    [Tags]  TC1
    [Documentation]  This test case search the products in the Excel file, respectively, and add the most rated product from the free shipping ones to the basket.
    @{product_list}=  Obtain product list from the dataset  words.xlsx  Aranacak Kelimeler

    # Step 1: Open Trendyol home page on Chrome
    Open Trendyol home page on Chrome
    Verify home page opens

    # Repeat rest of the steps for the other products

    FOR    ${item}  IN   @{product_list}

    # Step 2: Search the product name by parsing the dataset from the Excel file.
        Search the product name  ${item}
        Sleep  2

        # Verify no result will be found for the latest product name " ––––––––––"
        Exit for loop if  $item == ' ––––––––––'

    # Step 3: Select the free shipping option from the checkbox.
        Filter free shipping products
        Sleep  2

    # Step 4: Select the most rated option from sort filter container.
        Select the most rated filter option
        Sleep  2

    # Step 5: Select the most rated option from sort filter container and verify the product has been added to the basket.
        Select the most rated product in free shipping products then add it to the basket
        Sleep  2
        Verify the product is added to the basket by checking basket preview appearance
    END
    log to console  $item[6]
    Run keyword if  $item == ' ––––––––––'  Verify no results were for found for the searched product
    Capture page screenshot
