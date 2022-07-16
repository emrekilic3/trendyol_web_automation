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
        Click element    //div[@class="overlay"]
    END

Open Trendyol home page on Chrome
    Go to  https://www.trendyol.com/
    Maximize browser window
    Handle cookies by accepting it

Verify home page opens
    Element should be visible  class:logo  timeout=10

Handle cookies by accepting it
    ${returnValue2}=  Element Is Visible With Timeout  id:onetrust-accept-btn-handler
    IF  "${returnValue2}"=="True"
        Click element    id:onetrust-accept-btn-handler
    END

Search the product name
    [Arguments]  ${product_name}
    Wait until page contains element  class:search-box
    Input text  class:search-box  ${product_name}
    Sleep  1
    Click element  class:search-icon
    Check visibility of the pop-up element

Filter free shipping products
    Click element  //div[contains(text(),'Kargo Bedava')]

Select the most rated filter option
    Select from list by value    //select    MOST_RATED

Select the most rated product in free shipping products then add it to the basket
    Wait until element is visible  class:image-overlay
    Click element  class:image-overlay
    Switch Window  new
    Sleep  2
    Wait until page contains element  class:add-to-basket
    Click element  class:add-to-basket

Verify the product is added to the basket by checking basket preview appearance
    Element should be visible  class:basket-preview-container

Verify no results were for found for the searched product
    Wait until element is visible  class:no-rslt-icon