describe "visitor to a regular, no-frills article", ->

    before Browser.resetMobileWeb
    afterEach screenshotIfFailed
    afterEach skipRestIfFailed

    she "loads the page", ->
        Browser.url('/2014/12/31/business/media/sony-attack-first-a-nuisance-swiftly-grew-into-a-firestorm-.html')
        Browser.waitForMobileWebJS()

    she "doesn't see a growl within a couple seconds", ->
        Browser.pause(2000)
        assert not Browser.isVisible("#growl")

    she "sees span image", ->
        assert Browser.isVisible(".span-image a img")

    she "taps image", ->
        Browser.click(".span-image a img")

    she "sees modal lightbox and caption, credit, and close button within a half second", ->
        Browser.waitForVisible(".modal-lightbox", 500)
        Browser.waitForVisible(".modal-footer", 500)
        Browser.waitForVisible(".modal-lightbox .modal-close", 500)

    she "sees modal lightbox caption and credit", ->
        assert Browser.isVisible('.modal-footer')

    she "taps lightbox", ->
        Browser.click('.modal-touch-container .modal-body .center-container')

    she "sees modal lightbox caption, credit, and close button disappear within a half second", ->
        Browser.waitForVisible(".modal-footer", 500, true)
        Browser.waitForVisible(".modal-lightbox button i.close", 500, true)

    she "still sees modal lightbox", ->
        assert Browser.isVisible('.modal-lightbox')

    she "taps lightbox again", ->
        Browser.click('.modal-touch-container .modal-body .center-container')

    she "sees modal lightbox caption, credit, and close button reappear within a half second", ->
        Browser.waitForVisible(".modal-footer", 500)
        Browser.waitForVisible(".modal-lightbox .modal-close", 500)

    she "rotates device to landscape", ->
        do @skip unless browser.capabilities.rotatable
        Browser.setOrientation("LANDSCAPE")
        Browser.pause(100)

    she "still sees close button in the right place", ->
        do @skip unless browser.capabilities.rotatable
        assert Browser.isVisible(".modal-lightbox .modal-close")
        size = Browser.getElementSize(".modal-lightbox .modal-close")
        width = size.width + 10 # 10 px of wiggle room for margin
        location = Browser.getLocationInView(".modal-lightbox .modal-close")
        assert location.x >= (500 - width)
        assert location.y <= 10

    she "sees footer in the right place", ->
        do @skip unless browser.capabilities.rotatable
        assert Browser.isVisible(".modal-lightbox .modal-footer")
        modalSize = Browser.getElementSize(".modal-lightbox")
        footerSize = Browser.getElementSize(".modal-lightbox .modal-footer")
        location = Browser.getLocationInView(".modal-lightbox .modal-footer")
        assert location.x == 0
        assert location.y >= (modalSize.height - footerSize.height - 1) # wiggle room because Selenium
        assert location.y <= (modalSize.height - footerSize.height + 1) # wiggle room because Selenium

    she "rotates device back to portrait", ->
        do @skip unless browser.capabilities.rotatable
        Browser.setOrientation("PORTRAIT")
        Browser.pause(100)

    she "closes the modal lightbox", ->
        Browser.click(".modal-lightbox .modal-close")

    she "sees the modal lightbox disappear within a half second", ->
        Browser.waitForVisible(".modal-lightbox", 500, true)
