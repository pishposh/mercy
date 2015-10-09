describe "vistor to an article page with inline share tools", ->

    before Browser.resetMobileWeb
    afterEach screenshotIfFailed
    afterEach skipRestIfFailed

    she "loads the page", ->
        Browser.url("/2015/01/05/sports/on-el-capitans-dawn-wall-two-climbers-make-slow-progress-toward-a-dream.html")
        Browser.waitForMobileWebJS()

    she "sees inline icons to share on facebook, twitter, and to view more options", ->
        assertCollapsed SELECTORS.INLINE

    she "sees a sharing modal after tapping for more options", ->
        Browser.click("#{SELECTORS.INLINE} #{SELECTORS.CONTROLS.MORE}")
        assertExpanded SELECTORS.INLINE

    she "dismisses the modal by tapping the close button", ->
        Browser.click("#{SELECTORS.INLINE} #{SELECTORS.CONTROLS.CLOSE}")
        assertCollapsed SELECTORS.INLINE

    she "sees the fixed share tools after scrolling down a bit", ->
        Browser.scroll(0, 600)
        Browser.waitForVisible(SELECTORS.FIXED, 1000)

    she "sees a sharing modal after tapping for more options", ->
        Browser.click("#{SELECTORS.FIXED} #{SELECTORS.CONTROLS.MORE}")
        # proxying events from fixed nav to inline for MWR-5676
        assertCollapsed SELECTORS.FIXED
        assertExpanded SELECTORS.INLINE

    she "dismisses the modal by tapping the close button", () ->
        Browser.click("#{SELECTORS.INLINE} #{SELECTORS.CONTROLS.CLOSE}")
        assertCollapsed SELECTORS.FIXED
        assertCollapsed SELECTORS.INLINE


SELECTORS =
    INLINE: '[data-view="article-page"] .inline-share-wrapper [data-view="share-container"]'
    FIXED: '#main-header .fixed-share-nav-outer [data-view="share-container"]'
    CONTROLS:
        FACEBOOK: '[data-share="Facebook"] .share-link'
        TWITTER: '[data-share="Twitter"] .share-link'
        LINKEDIN: '[data-share="LinkedIn"] .share-link'
        WHATSAPP: '[data-share="WhatsApp"] .share-link'
        GPLUS: '[data-share="GooglePlus"] .share-link'
        REDDIT: '[data-share="Reddit"] .share-link'
        MORE: '[data-share="ShareModal"] .share-link'
        EMAIL: '[data-share="Email"] .share-link'
        SAVE: '[data-share="save"] .share-link'
        CLOSE: '.share-close-div .share-close'


assertCollapsed = (parentSelector) ->
    classes = Browser.getAttribute(parentSelector, 'class')
    assert classes.split(/\s+/).every (className) -> className != 'expanded'

    visible = [
        SELECTORS.CONTROLS.FACEBOOK,
        SELECTORS.CONTROLS.TWITTER,
        SELECTORS.CONTROLS.MORE
    ]

    hidden = [
        SELECTORS.CONTROLS.LINKEDIN,
        SELECTORS.CONTROLS.WHATSAPP,
        SELECTORS.CONTROLS.GPLUS,
        SELECTORS.CONTROLS.REDDIT,
        SELECTORS.CONTROLS.SAVE,
        SELECTORS.CONTROLS.EMAIL,
        SELECTORS.CONTROLS.CLOSE
    ]

    assert (
        visible.map (selector) -> Browser.isVisible("#{parentSelector} #{selector}")
    ).every (isVisible) -> isVisible

    assert (
        hidden.map (selector) -> Browser.isVisible("#{parentSelector} #{selector}")
    ).every (isVisible) -> not isVisible


assertExpanded = (parentSelector) ->
    classes = Browser.getAttribute(parentSelector, 'class')
    assert classes.split(/\s+/).some (className) -> className == 'expanded'

    visible = [
        SELECTORS.CONTROLS.FACEBOOK,
        SELECTORS.CONTROLS.TWITTER,
        SELECTORS.CONTROLS.EMAIL,
        SELECTORS.CONTROLS.SAVE,
        SELECTORS.CONTROLS.LINKEDIN,
        SELECTORS.CONTROLS.WHATSAPP,
        SELECTORS.CONTROLS.GPLUS,
        SELECTORS.CONTROLS.REDDIT,
        SELECTORS.CONTROLS.CLOSE
    ]

    hidden = [
        SELECTORS.CONTROLS.MORE
    ]

    assert (
        visible.map (selector) -> Browser.isVisible("#{parentSelector} #{selector}")
    ).every (isVisible) -> isVisible

    assert (
        hidden.map (selector) -> Browser.isVisible("#{parentSelector} #{selector}")
    ).every (isVisible) -> not isVisible



