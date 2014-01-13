fs = require 'fs'
supervisor = require 'supervisor'


main = () ->
  supervisor.run [
    '--quiet'
    '--exec', 'node'
    '--no-restart-on', 'exit'
    '--extensions', 'coffee,js,json,yml'
    fs.realpathSync("#{__dirname}/devrun.js")
  ]


module.exports = {main}
