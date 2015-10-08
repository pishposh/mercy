var merge = require('deepmerge');

exports.config = merge( require('./common.conf.js').config, {
    host: '127.0.0.1',
    port: 4723,
    capabilities: [
        { platformName: "iOS", deviceName: "iPhone 5s", platformVersion: "9.0", browserName: "Safari" }
    ],
    baseUrl: 'http://local.sbx.nytimes.com' // can be overriden with --base-url=...
} );
