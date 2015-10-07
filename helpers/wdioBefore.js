'use strict';

module.exports = async function () {
    global.screenshotIfFailed = require('./screenshotIfFailed');
    global.skipRestIfFailed = require('./skipRestIfFailed');
    global.assert = require('assert');
    global.he = global.she = global.they = function () { global.it.apply(this, arguments) };

    if (browser.capabilities) throw new Error("refusing to overwrite browser.capabilities");
    browser.capabilities = (await browser.session()).value;

    browser.addCommand("waitForMobileWebJS", function() {
        return this.waitUntil(function () {
            return this.execute("!window.MWR || MWR.isAppLoaded");
        }, 10000);
    });

    browser.addCommand("resetMobileWeb", async function () {
        await this.url('/.status');
        await* [
            this.deleteCookie()          .catch(err => null /*console.error("\nWARNING:" + err.message + "\n")*/),
            this.localStorage('DELETE')  .catch(err => null /*console.error("\nWARNING:" + err.message + "\n")*/),
            this.sessionStorage('DELETE').catch(err => null /*console.error("\nWARNING:" + err.message + "\n")*/),
        ];
        await this.url('about:blank');
    });

    // patch browser.scroll() for appium (as of v1.4.13) being unable to scroll() on iOS:
    if (browser.capabilities.platformName = "iOS") {
        browser.addCommand("scroll", function (selector, xoffset, yoffset) {
            xoffset = typeof xoffset === 'number' ? xoffset : 0;
            yoffset = typeof yoffset === 'number' ? yoffset : 0;
            if (typeof selector === 'number' && typeof xoffset === 'number') {
                yoffset = xoffset;
                xoffset = selector;
                selector = null;
            }

            var cmd = selector ? `document.querySelector(${JSON.stringify(selector)}).scrollIntoView();` : "";
            cmd += `scrollBy(${xoffset}, ${yoffset});`
            return this.execute(cmd);
        }, true);
    }

    await* [
        browser.timeouts("page load", 10000),
        browser.timeouts("script", 10000),
        browser.timeouts("implicit", 0)
    ];
};
