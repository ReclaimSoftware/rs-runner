require('coffee-script');
var run = require('./runner').run;

run({
  app_dirs: [process.cwd()],
  listen_on_host: process.env.RS_RUNNER_HOST
});
