fs = require 'fs'
{LevelDBWrapper, LevelDBClient} = require 'rs-leveldb-wrapper'
levelup = require 'levelup'


add_datastores = ({apps, data_dir}, c) ->

  # dirs
  leveldb_dir = "#{data_dir}/leveldb"
  fs.mkdirSync(data_dir) if not fs.existsSync(data_dir)
  fs.mkdirSync(leveldb_dir) if not fs.existsSync(leveldb_dir)

  # db
  leveldb_client = new LevelDBClient leveldb_dir
  for app in apps
    app.db = new LevelDBWrapper leveldb_client, {prefix: "#{app.slug}:"}

  c null


module.exports = {add_datastores}
