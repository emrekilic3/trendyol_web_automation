*** Settings ***
Library  SeleniumLibrary
Resource  locators.resource

*** Keywords ***

Create web driver session
    ${options}=    Evaluate  sys.modules['selenium.webdriver.chrome.options'].Options()    sys
    Call Method    ${options}   add_argument    --disable-notifications
    ${driver}=    Create Webdriver    Chrome    options=${options}

Element is visible with timeout
    [Arguments]  ${element}  ${timeout}=5s
    ${retVal}=  Run Keyword And Return Status  Wait Until Element Is Visible  ${element}  timeout=${timeout}
    [return]  ${retVal}

Check visibility of the pop-up element
    ${returnValue}=  Element Is Visible With Timeout  class=popup-heading
    IF  "${returnValue}"=="True"
        Click element    ${HOMEPAGE_OVERLAY}
    END

Open Trendyol home page on Chrome
    Go to  https://www.trendyol.com/
    Maximize browser window
    Handle cookies by accepting it

Verify home page opens
    Element should be visible  ${TRENDYOL_HOMEPAGE_LOGO}  timeout=10

Handle cookies by accepting it
    ${returnValue2}=  Element Is Visible With Timeout  id:onetrust-accept-btn-handler
    IF  "${returnValue2}"=="True"
        Click element    ${COOKIES_ACCEPT_BUTTON}
    END

Search the product name
    [Arguments]  ${product_name}
    Wait until page contains element  class:search-box
    Input text  ${SEARCH_BOX_CONTAINER}  ${product_name}
    Sleep  1
    Click element  ${SEARCH_ICON_BUTTON}
    Check visibility of the pop-up element

Filter free shipping products
    Click element  ${FREE_SHIPPING_BUTTON}

Select the most rated filter option
    Select from list by value    //select    MOST_RATED

Select the most rated product in free shipping products then add it to the basket
    Wait until element is visible  ${FREE SHIPPING_MOST_RATED_ITEM}
    Click element  ${FREE SHIPPING_MOST_RATED_ITEM}
    Switch Window  new
    Sleep  2
    Wait until page contains element  ${ADD_TO_BASKET_BUTTON}
    Click element  ${ADD_TO_BASKET_BUTTON}

Verify the product is added to the basket by checking basket preview appearance
    Element should be visible  ${BASKET_PREVIEW_CONTAINER}

Verify no results were for found for the searched product
    Wait until element is visible  ${NO_RESULT_ICON}
