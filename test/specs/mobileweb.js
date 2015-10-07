'use strict';

describe("visitor to /", function() {
    afterEach(screenshotIfFailed);
    afterEach(skipRestIfFailed);

    before(browser.resetMobileWeb);

    she("loads /", async () => {
        await browser.url("/");
        await browser.awaitMobileWebJS();
    });

    she("does a successful thing", function* () {
        yield browser.pause(100);
    })


    she("does a successful thing SYNC", function () {
        assert(true);
    })

    she("does a successful thing ASYNC", function (done) {
        setTimeout(done, 100);
    })

    she("fails here due to timeout, maybe", function* () {
        var n = Math.floor(Math.random() * 5000);
        yield browser.executeAsync("setTimeout(arguments[0], " + n + ")");
    })

    she("does another successful thing", function* () {
        yield browser.pause(100);
    })

    she("does another successful thing SYNC", function () {
        return;
    })

    she("does another successful thing ASYNC", function (done) {
        setTimeout(done, 100);
    })

});


