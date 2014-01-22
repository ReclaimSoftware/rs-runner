require('coffee-script');
var run = require('./runner').run;

run({
  app_dirs: [process.cwd()],
  data_dir: (process.cwd() + '/db'),
  listen_on_host: process.env.RS_RUNNER_HOST
});
