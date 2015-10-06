// 'use strict';

// global.step = function (msg, fn) {
//     if (fn.length === 0) {
//         global.it.call(this, msg, function () {
//             if (this.failed) return;
//             var result = fn.call(this);

//             return result;
//         })

//     } else { // fn.length > 0
//         global.it.call(this, msg, function (done) {

//         });
//     }

//     global.it.call(this, msg, function () {

//     });

//     origDescribe.call(this, msg, function () {
//         afterEach(function () {
//             console.log("hello, world! i'm afterEach", this);
//         });

//         describeFn.call(this);
//     });
// };


// global.step = function(msg, specFn) {
//     global.it.call(this, msg, function () {
//         var result = stepFn.apply(this, arguments);
//     });
// }

// global.step = function(msg, fn) {

//   //
//   // sync tests
//   //

//   function sync() {

//     var context = this;

//     try {
//       fn.call(context);
//     } catch (ex) {
//       context.test.parent._bail = true;
//       throw ex;
//     }

//   }

//   //
//   // async tests
//   //

//   function async(done) {

//     var context = this;

//     function onError() {
//       context.test.parent._bail = true;
//       process.removeListener('uncaughtException', onError);
//     }

//     process.addListener('uncaughtException', onError);

//     try {
//       fn.call(context, function(err) {
//         if (err) {
//           onError();
//           done(err);
//         } else {
//           process.removeListener('uncaughtException', onError);
//           done(null);
//         }
//       });
//     } catch(ex) {
//       onError();
//       throw ex;
//     }

//   }

//   if (fn.length === 0) {
//     console.log("sync", fn);
//     console.log("BLARGH?", it.BLARGH);
//     it(msg, sync);
//   } else {
//     console.log("async", fn);
//     it(msg, async);
//   }

// };

// global.xstep = function(msg, fn) {
//   it(msg, null);
// };
