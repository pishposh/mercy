'use strict';

const debug = true;

let deasync = require('deasync');

let deasyncPromise = deasync(function (promise, cb) {
    promise.then(cb.bind(null, null), cb);
});

function deasyncify(obj) {
    let objSync = { _async: obj };
    for (let propname in obj) {
        let propval = obj[propname];

        if (typeof propval === 'function') {
            objSync[propname] = function () {
                let retval = propval.apply(objSync, arguments);
                if (retval && typeof retval.then === 'function') {
                    retval = deasyncPromise(retval);
                }
                return retval;
            }
        } else {
            Object.defineProperty(objSync, propname, {
                enumerable: true,
                get: () => obj[propname],
                set: (newValue) => obj[propname] = newValue
            });
        }
    }
    return objSync;
}


// var browser = require('webdriverio').remote({ desiredCapabilities: { browserName: 'chrome', chromeOptions: { mobileEmulation: { deviceName: "Apple iPhone 5" } } } }), ok = console.log.bind(console, "ok"), cb = ok, err = console.log.bind(console, "err")


// var is = deasyncify(browser);




// function deasyncify(value, fnContext) {
//     let origValue;

//     let id = Math.random().toString(36).slice(2);
//     if (debug) console.error(id, "is: ", value);

//     // promises:
//     if (value && typeof value.then === 'function') {
//         if (debug) console.error(id, "recognized as promise")
//         value = deasyncify(deasyncPromise(value), fnContext);
//         if (debug) console.error(id, "...resolved to", retval);
//     }

//     // functions:
//     if (typeof value === 'function') {
//         if (debug) console.error(id, "recognized as function")
//         value = function () {
//             return deasyncify(value.apply(fnContext, arguments), fnContext);
//         }
//     }

//     // add properties:
//     if (value instanceof Object) {
//         if (retval == null) retval = (value instanceof Array) ? [] : { _async: value };
//         if (debug) console.error(id, "recognized as object; retval ", retval)
//         if (retval instanceof Object) {
//             if (debug) console.error(id, "adding properties to retval...")
//             for (let propname in value) {
//                 if (debug) console.error(id, propname);
//                 Object.defineProperty(retval, propname, {
//                     enumerable: true,
//                     get: () => {
//                         if (debug) console.error("getter for", propname);
//                         return deasyncify(value[propname], value)
//                     },
//                     set: (newValue) => {
//                         if (debug) console.error("setter for", propname);
//                         value[propname] = newValue;
//                     }
//                 });
//             }
//             if (debug) console.error(id, "done adding properties to proxy");
//         }
//     }

//     // simple scalar value:
//     if (retval !== undefined) {
//         if (debug) console.error(id, "returning processed value:", value)
//         return retval;
//     } else {
//         if (debug) console.error(id, "returning scalar:", retval)
//         return value;
//     }
// }


module.exports = deasyncify;

// // var Promise = require('bluebird');

// function dump(obj, path) {
//     path = path || "root";
//     console.log(path + ": " + String(obj))
//     for (let k in obj) {
//         let v = obj[k];
//         if (v instanceof Object) {
//             dump(v, path+"."+k);
//         } else {
//             console.log(path+"."+k + ": " + v);
//         }
//     }
// }
