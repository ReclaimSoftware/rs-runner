supervisor = require 'supervisor'


main = () ->
  supervisor.run [
    '--quiet'
    '--exec', 'node'
    '--no-restart-on', 'exit'
    '--extensions', 'coffee,js,json,yml'
    '/Users/a/code/ReclaimSoftware/rs-runner/devrun.js'
  ]


module.exports = {main}
