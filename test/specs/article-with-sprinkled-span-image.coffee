describe "visitor to an article with a sprinkled span image", ->

    before browser.resetMobileWeb
    afterEach screenshotIfFailed
    afterEach skipRestIfFailed

    she "loads the page", ->
        yield browser.url("/2015/01/05/us/politics/republicans-say-theyll-act-fast-to-push-agenda.html")
        yield browser.awaitMobileWebJS()

    she "sees the ACM within a few seconds", ->
        yield browser.waitForVisible('#additional-content', 5000)

    she "taps the ACM's Show Full Article button", ->
        # scroll the ACM button into view:
        unless browser.capabilities.platformName == 'iOS'
            yield browser.scroll("#additional-content button", 0, -200) # leave room for fixed header
        else # workaround appium as of v1.4.13:
            yield browser.execute("document.querySelector('#additional-content button').scrollIntoView(); scrollBy(0,-200)")

        yield browser.click("#additional-content button")
        yield browser.pause(1000) # wait for ACM to slide away

    she "can see the sprinkled span image", ->
        yield browser.waitForVisible(".span-image.related-asset a img", 5000)

    she "clicks the sprinkled span image", ->
        unless browser.capabilities.platformName == 'iOS'
            yield browser.scroll(".span-image.related-asset a img", 0, -200) # leave room for fixed header
        else # workaround appium as of v1.4.13:
            yield browser.execute("document.querySelector('.span-image.related-asset a img').scrollIntoView(); scrollBy(0,-200)")
        yield browser.click(".span-image.related-asset a img")

    she "sees the modal lightbox", ->
        yield browser.waitForVisible(".modal-lightbox", 1000)
