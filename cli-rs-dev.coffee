fs = require 'fs'
supervisor = require 'supervisor'
{argv} = require 'optimist'


main = () ->
  process.env.RS_RUNNER_HOST = argv.host or '127.0.0.1'
  supervisor.run [
    '--quiet'
    '--exec', 'node'
    '--no-restart-on', 'exit'
    '--extensions', 'coffee,js,json,yml'
    fs.realpathSync("#{__dirname}/devrun.js")
  ]


module.exports = {main}
