describe "visitor to an article with a sprinkled thumb image", ->

    before browser.resetMobileWeb
    afterEach screenshotIfFailed
    afterEach skipRestIfFailed

    she "loads the page", ->
        yield browser.url("/2015/01/05/sports/on-el-capitans-dawn-wall-two-climbers-make-slow-progress-toward-a-dream.html")
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

    she "can see the sprinkled thumb image", ->
        yield browser.waitForVisible(".article-image.related-asset a img", 5000)

    she "clicks the sprinkled thumb image", ->
        unless browser.capabilities.platformName == 'iOS'
            yield browser.scroll(".article-image.related-asset a img", 0, -200) # leave room for fixed header
        else # workaround appium as of v1.4.13:
            yield browser.execute("document.querySelector('.article-image.related-asset a img').scrollIntoView(); scrollBy(0,-200)")
        yield browser.click(".article-image.related-asset a img")

    she "sees the modal lightbox", ->
        yield browser.waitForVisible(".modal-lightbox", 1000)
