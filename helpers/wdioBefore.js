'use strict';

module.exports = async function () {
    global.screenshotIfFailed = require('./screenshotIfFailed');
    global.skipRestIfFailed = require('./skipRestIfFailed');
    global.assert = require('assert');

    browser.awaitMobileWebJS = async () => {
        await browser.waitUntil(() => browser.execute("!window.MWR || MWR.isAppLoaded"));
    };

    browser.resetMobileWeb = async () => {
        await browser.url('/.status');
        await* [
            browser.deleteCookie()          .catch(err => null /*console.error("\nWARNING:" + err.message + "\n")*/),
            browser.localStorage('DELETE')  .catch(err => null /*console.error("\nWARNING:" + err.message + "\n")*/),
            browser.sessionStorage('DELETE').catch(err => null /*console.error("\nWARNING:" + err.message + "\n")*/),
        ];
        await browser.url('about:blank');
    };

    await* [
        browser.timeouts("page load", 10000),
        browser.timeouts("script", 10000),
        browser.timeouts("implicit", 0)
    ];

    if (browser.capabilities) throw new Error("refusing to overwrite browser.capabilities");
    browser.capabilities = (await browser.session()).value;
    // console.log("browser.capabilities", browser.capabilities);

    global.he = global.she = global.they = function () { it.apply(this, arguments) };
};
