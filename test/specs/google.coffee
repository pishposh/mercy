describe "visitor to www.google.com", ->
    afterEach screenshotIfFailed
    afterEach skipRestIfFailed

    she "loads http://www.google.com", ->
        yield browser.url("http://www.google.com")

    she "succeeds", ->
        yield browser.pause(100)

    she "succeeds synchronously", ->
        assert(true)

    she "succeeds with mocha's built-in async callback", (done) ->
        setTimeout(done, 100)

    she "fails here in webdriver about 1/3 of the time", ->
        yield browser.pause(100)
        if (Math.random() < 1/3)
            yield browser.click("#qjk q jkqjk qjkqjk")

    she "fails here in an assert about 1/3 of the time", ->
        yield browser.pause(100);
        assert(Math.random() < 1/3)

    she "succeeds again", ->
        yield browser.pause(100)

    she "succeeds synchronously, again", ->
        assert(true)

    she "succeeds with mocha's built-in async callback, again", (done) ->
        setTimeout(done, 100)
