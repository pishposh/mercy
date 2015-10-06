'use strict';

module.exports = function skipRestIfFailed () {
    if (this.currentTest.state === "failed") {
        this.skip();
    }
};
