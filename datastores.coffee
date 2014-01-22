fs = require 'fs'
{LevelDBWrapper, LevelDBClient} = require 'rs-leveldb-wrapper'


add_datastores = ({apps, data_dir}, c) ->
  fs.mkdirSync(data_dir) if not fs.existsSync(data_dir)
  _add_leveldb apps, data_dir
  c null


_add_leveldb = (apps, data_dir) ->
  leveldb_dir = "#{data_dir}/leveldb"
  fs.mkdirSync(leveldb_dir) if not fs.existsSync(leveldb_dir)
  leveldb_client = new LevelDBClient leveldb_dir
  for app in apps
    app.db = new LevelDBWrapper leveldb_client, {prefix: "#{app.slug}:"}


module.exports = {add_datastores}
