fs = require 'fs'
async = require 'async'
{sha1_hex_of} = require 'rs-util'


prep_models = ({apps}, c) ->
  for app in apps
    _add_model app
    seed_rows = _load_seed_rows app
    async.forEach seed_rows, (([k, v], c) -> app.db.put k, v, c), c


_add_model = (app) ->
  model_path = "#{app.dir}/models/model.coffee"
  if fs.existsSync model_path
    app.Model = require(model_path).Model
    return c new Error "expected model.coffee to contain Model" if not app.Model
    app.Model.init app


_load_seed_rows = (app) ->
  seed_rows = []
  seed_path = "#{app.dir}/db/seed.coffee"
  if fs.existsSync seed_path
    seed_module = require seed_path

    for plural, arr of seed_module
      cls = app.Model.classes_by_plural[plural]
      return c new Error "unexpected key #{JSON.stringify plural} in seed file" if not cls
      _add_missing_ids plural, arr

      for attributes in arr
        model = new cls attributes
        return c new Error "a seed model is invalid" if not model.isValid()
        seed_rows.push ["#{plural}:#{model.id}", JSON.stringify model]
  seed_rows


_add_missing_ids = (plural, arr) ->
  for attributes, i in arr
    if not attributes.id
      id_json = JSON.stringify [plural, i, attributes]
      attributes.id = sha1_hex_of(id_json).substr 0, 8


module.exports = {prep_models}
