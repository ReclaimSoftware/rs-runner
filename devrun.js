require('coffee-script');
var run = require('./runner').run;

run({
  app_dirs: [process.cwd()]
});
