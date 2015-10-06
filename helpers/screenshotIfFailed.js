'use strict';

var path = require('path');
var mkdirp = require('mkdirp');
var moment = require('moment');

module.exports = function* screenshotIfFailed () {
    try {
        if (this.currentTest.state === "failed") {
            var capsSanitized = sanitizeCaps(browser.desiredCapabilities);
            var testTitleSanitized = sanitize(this.currentTest.fullTitle());
            var dtSanitized = moment().format().replace(/:/g,'.');
            var screenshotDir = path.resolve(
                process.cwd(),
                "errorShots",
                capsSanitized
            );
            mkdirp.sync(screenshotDir);
            var screenshotPath = path.join(
                screenshotDir,
                dtSanitized + "-" + testTitleSanitized + ".png"
            );
            yield browser.saveScreenshot(screenshotPath);
            console.error("\nSCREENSHOT: " + screenshotPath + "\n");
        }
    } catch (err) {
        console.error("\nSCREENSHOT failed: " + err.message + "\n")
    }
}

function sanitize(str) {
    if (str == null) return '';
    return String(str)
        .replace(/^\W+|\W+$/g, '')
        .replace(/\W+/g, '_');
}

/**
 * formats capability object into sanitized string for e.g.filenames
 * @param {Object} caps  Selenium capabilities
 */
function sanitizeCaps(caps) {
    var result;

    /**
     * mobile caps
     */
    if(caps.deviceName) {
        result = [sanitize(caps.deviceName), sanitize(caps.platformName), sanitize(caps.platformVersion)];
    } else {
        result = [sanitize(caps.browserName), sanitize(caps.version), sanitize(caps.platform)];
    }

    result = result.filter(function(n){
        return n !== undefined && n !== '';
    });
    return result.join('.');
};
