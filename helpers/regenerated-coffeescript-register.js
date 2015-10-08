// Use this file instead of coffee-script/register

require('coffee-script/register');
require('regenerator/runtime');
var CoffeeScript = require('coffee-script');
var recast = require('recast');
var regenerator = require('regenerator');
var convertSourceMap = require('convert-source-map');

require.extensions['.coffee'] = function (module, filename) {
  var answer = CoffeeScript._compileFile(filename, true);

  var ast = recast.parse(answer.js, {sourceFileName: 'source'});
  ast = regenerator.transform(ast);
  var result = recast.print(ast, {
    inputSourceMap: JSON.parse(answer.v3SourceMap),
    sourceMapName: 'map'
  });

  var inlineSourceMap = convertSourceMap
    .fromObject(result.map)
    .setProperty('file', '')
    .setProperty('sources', ['file://' + filename])
    .toComment();

  var js = result.code + '\n' + inlineSourceMap;
  module._compile(js, filename);
};
