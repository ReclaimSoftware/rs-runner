require('coffee-script');
var run = require('./runner').run;

run({
  app_dirs: [process.cwd()],
  data_dir: process.env.RS_RUNNER_DATA_DIR,
  storage_dir: process.env.RS_RUNNER_STORAGE_DIR,
  listen_on_host: process.env.RS_RUNNER_HOST,
  first_app_port: process.env.RS_RUNNER_PORT
});
