fs = require 'fs'
http = require 'http'
_ = require 'underscore'
async = require 'async'
express = require 'express'
connect_assets = require 'connect-assets'
frontend_libs = require 'rs-frontend-libs'


run = ({app_dirs, listen_on_host, first_app_port}) ->
  listen_on_host ?= '127.0.0.1'
  first_app_port ?= 3000

  apps = for app_dir, i in app_dirs
    create_app {
      app_dir
      listen_on_host
      port: (first_app_port + i)
    }

  async.forEach apps, ((app, c) -> app.listen c), (e) ->
    throw e if e


create_app = ({app_dir, listen_on_host, port}) ->

  app = express()

  app.dir = fs.realpathSync app_dir
  app.slug = _.last(app.dir.split('/')).replace /-/g, '_'
  assert_app_file_layout app.dir
  app_module = require "#{app.dir}/app"

  app.set 'view engine', 'jade'
  app.set 'views', "#{app.dir}/views"
  use_connect_assets app
  app.use express.methodOverride()
  app.use express.static frontend_libs.PUBLIC_DIR
  app.use app.router

  app_module app

  app.listen = (c) ->
    app.listen = null
    app.server = http.createServer app
    app.server.listen port, listen_on_host, () ->
      console.log "[#{app.slug}] Listening on http://#{listen_on_host}:#{port}"
      c null

  app


assert_app_file_layout = (dir) ->
  for name in ['app.coffee', 'views', 'assets']
    path = "#{dir}/#{name}"
    if not fs.existsSync(path)
      console.log "Missing path: #{JSON.stringify path}"
      process.exit 1


use_connect_assets = (app) ->
  connect_assets_object_name = "#{app.slug}_app"
  global[connect_assets_object_name] ?= {}
  app.use connect_assets {
    src: "#{app.dir}/assets"
    helperContext: global[connect_assets_object_name]
  }


module.exports = {run}
