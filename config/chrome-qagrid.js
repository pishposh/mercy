var merge = require('deepmerge');

exports.config = merge( require('./common.conf.js').config, {
    host: '127.0.0.1',
    port: 4444,
    capabilities: [
        { browserName: 'chrome', chromeOptions: { mobileEmulation: { deviceName: "Apple iPhone 5" } } }
    ],
    baseUrl: 'http://local.sbx.nytimes.com' // can be overriden with --baseUrl=...
} );
