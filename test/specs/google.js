'use strict';

describe("visitor to www.google.com", function() {
    afterEach(screenshotIfFailed);
    afterEach(skipRestIfFailed);

    she("loads http://www.google.com", function* () {
        yield browser.url("http://www.google.com");
    });

    she("does a successful thing", function* () {
        yield browser.pause(100);
    })


    she("does a successful thing SYNC", function () {
        return;
    })

    she("does a successful thing ASYNC", function (done) {
        setTimeout(done, 100);
    })

    she("passes here with flying colors", async () => {
        assert(true);
    });

    she("fails here in webdriver about 1/3 the time", async () => {
        await browser.pause(100);
        if (Math.random() < 1/3) {
            await browser.click("#qjk q jkqjk qjkqjk");
        }
    });

    she("fails here in an assert about 1/3 the time", async () => {
        await browser.pause(100);
        assert(Math.random() < 1/3);
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


