describe "visitor to a regular, no-frills article", ->

    before browser.resetMobileWeb
    afterEach screenshotIfFailed
    afterEach skipRestIfFailed

    before ->
        capabilities = (yield browser.session()).value
        @isRotatable = (capabilities.rotatable or capabilities.platformName == 'iOS')

    she "loads the page", ->
        yield browser.url('/2014/12/31/business/media/sony-attack-first-a-nuisance-swiftly-grew-into-a-firestorm-.html')
        yield browser.awaitMobileWebJS()

    she "doesn't see a growl within a couple seconds", ->
        yield browser.pause(2000)
        assert not yield browser.isVisible("#growl")

    she "sees span image", ->
        assert yield browser.isVisible(".span-image a img")

    she "taps image", ->
        yield browser.click(".span-image a img")

    she "sees modal lightbox and caption, credit, and close button within a half second", ->
        yield [
            browser.waitForVisible(".modal-lightbox", 500)
            browser.waitForVisible(".modal-footer", 500)
            browser.waitForVisible(".modal-lightbox .modal-close", 500)
        ]

    she "sees modal lightbox caption and credit", ->
        assert yield browser.isVisible('.modal-footer')

    she "taps lightbox", ->
        yield browser.click('.modal-touch-container .modal-body .center-container')

    she "sees modal lightbox caption, credit, and close button disappear within a half second", ->
        yield [
            browser.waitForVisible(".modal-footer", 500, true)
            browser.waitForVisible(".modal-lightbox button i.close", 500, true)
        ]

    she "still sees modal lightbox", ->
        assert yield browser.isVisible('.modal-lightbox')

    she "taps lightbox again", ->
        yield browser.click('.modal-touch-container .modal-body .center-container')

    she "sees modal lightbox caption, credit, and close button reappear within a half second", ->
        yield [
            browser.waitForVisible(".modal-footer", 500)
            browser.waitForVisible(".modal-lightbox .modal-close", 500)
        ]

    she "rotates device to landscape", ->
        do @skip unless @isRotatable
        yield browser.rotate("LANDSCAPE")
        yield browser.pause(1000)

    she "still sees close button in the right place", ->
        do @skip unless @isRotatable
        assert yield browser.isVisible(".modal-lightbox .modal-close")
        size = yield browser.getElementSize(".modal-lightbox .modal-close")
        width = size.width + 10 # 10 px of wiggle room for margin
        location = yield browser.getLocationInView(".modal-lightbox .modal-close")
        assert location.x >= (500 - width)
        assert location.y <= 10

    she "sees footer in the right place", ->
        do @skip unless @isRotatable
        assert yield browser.isVisible(".modal-lightbox .modal-footer")
        modalSize = yield browser.getElementSize(".modal-lightbox")
        footerSize = yield browser.getElementSize(".modal-lightbox .modal-footer")
        location = yield browser.getLocationInView(".modal-lightbox .modal-footer")
        assert location.x == 0
        assert location.y >= (modalSize.height - footerSize.height - 1) # wiggle room because Selenium
        assert location.y <= (modalSize.height - footerSize.height + 1) # wiggle room because Selenium

    she "rotates device back to portrait", ->
        do @skip unless @isRotatable
        yield browser.rotate("PORTRAIT")
        yield browser.pause(1000)

    she "closes the modal lightbox", ->
        yield browser.click(".modal-lightbox .modal-close")

    she "sees the modal lightbox disappear within a half second", ->
        yield browser.waitForVisible(".modal-lightbox", 500, true)
