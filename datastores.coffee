fs = require 'fs'
{LevelDBWrapper, LevelDBClient} = require 'rs-leveldb-wrapper'
{StorageWrapper} = require 'rs-storage-wrapper'


add_datastores = ({apps, data_dir, storage_dir}, c) ->
  fs.mkdirSync(data_dir) if not fs.existsSync(data_dir)
  _add_leveldb apps, data_dir
  _add_storage apps, storage_dir
  c null


_add_leveldb = (apps, data_dir) ->
  leveldb_dir = "#{data_dir}/leveldb"
  fs.mkdirSync(leveldb_dir) if not fs.existsSync(leveldb_dir)
  leveldb_client = new LevelDBClient leveldb_dir
  for app in apps
    app.db = new LevelDBWrapper leveldb_client, {prefix: "#{app.slug}:"}


_add_storage = (apps, storage_dir) ->
  fs.mkdirSync(storage_dir) if not fs.existsSync(storage_dir)
  for app in apps
    root_dir = "#{storage_dir}/#{app.slug}"
    fs.mkdirSync(root_dir) if not fs.existsSync(root_dir)
    app.storage = new StorageWrapper {root_dir}


module.exports = {add_datastores}
