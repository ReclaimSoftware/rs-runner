**Run zero or more RS-style apps in the same process.**

[![Build Status](https://secure.travis-ci.org/ReclaimSoftware/rs-runner.png)](http://travis-ci.org/ReclaimSoftware/rs-runner)

    require('rs-runner').run {
      app_dirs: [...]
      listen_on_host: '127.0.0.1'  # (default)
      first_app_port: 3000         # (default)
    }


### rs-dev

    cd my-app && rs-dev

This will serve the app on `localhost:3000`, reloading when files change.

Options:

    --host=           Default: "127.0.0.1". Use e.g. "0.0.0.0" to allow remote connections.
    --data-dir=...    Default: ./db/
    --storage-dir=... Default: ./db/storage/


### "RS-style app"

    app.coffee    "module.exports = (app) -> ..."
    views/        .jade files
    assets/
      css/        .styl files
      js/         .coffee files
    
    .gitignore    "db"

When you use `cd app && rs-dev`, it'll add these:

    db/           (.gitignore this)
      leveldb/    LevelDB database files
      storage/
        yourapp/  the root dir for app.storage


#### Additions to `app`

    app.dir       Your app's folder
    app.slug      Your app folder's name, with dashes replaced by underscores
    app.module    require(your app's app.coffee)
    app.server    The HTTP server, e.g. for your tests to .close
    app.storage   a StorageWrapper (see rs-storage-wrapper)
    app.db        This apps's LevelDBWrapper of the sole LevelDBClient
                    All keys are automatically prefixed with "#{app.slug}:"
    app.Model     require(app.dir + "/models/model"), if it exists


#### Additions to `global`

To use [connect-assets](https://github.com/adunkman/connect-assets) with multiple apps, we reluctantly create this global variable:

```coffee
global[app.slug + "_app"] = {
  css, js    # the connect-assets helpers
}
```

To use assets in your `.jade` files:

```jade
!= foo_app.js('...')
!= foo_app.css('...')
```

Future versions of connect-assets might let us avoid this.


### [License: MIT](LICENSE.txt)
