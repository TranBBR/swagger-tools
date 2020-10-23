#!/usr/bin/env node

'use strict';

var resolve = require('json-refs').resolveRefs;
var YAML = require('js-yaml');
var fs = require('fs');
var program = require('commander');

const DEFAULT_OUTPUT = './swagger_api'

program
  .version('2.0.0')
  .option('-f --format [format]',
          'output format. Choices are "json" and "yaml" (Default is json)',
          'json')
  .usage('[options] <yaml file ...>')
  .option('-o --output [output]',
          'output file without extension. Default is ' + DEFAULT_OUTPUT,
          DEFAULT_OUTPUT)
  .usage('[options] <yaml file ...>')
  .parse(process.argv);

if (program.format !== 'json' && program.format !== 'yaml') {
  console.error(program.help());
  process.exit(1);
}

var file = program.args[0];

if (!fs.existsSync(file)) {
  console.error('File does not exist. ('+file+')');
  process.exit(1);
}

var root = YAML.safeLoad(fs.readFileSync(file).toString());
var options = {
  filter        : ['relative', 'remote'],
  loaderOptions : {
    processContent : function (res, callback) {
      callback(null, YAML.safeLoad(res.text));
    }
  }
};

resolve(root, options).then(function (results) {
  let content = null;
  if (program.format === 'yaml') {
    content = YAML.safeDump(results.resolved);

  } else if (program.format === 'json') {
    content = JSON.stringify(results.resolved, null, 2);
  }
  const fileName = program.output + '.' + program.format;
  fs.writeFileSync(fileName, content);
  console.log('Writed in ' + fileName);
});