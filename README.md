**Run zero or more RS-style apps in the same process.**

    require('rs-runner').run {
      app_dirs: [...]
      listen_on_host: '127.0.0.1'  # (default)
      first_app_port: 3000         # (default)
    }


### rs-dev

    cd my-app && rs-dev

This will serve the app on `localhost:3000`, reloading when files change.


### "RS-style app"

    app.coffee    "module.exports = (app) -> ..."
    views/        .jade files
    assets/
      css/        .styl files
      js/         .coffee files

When you use `rs-dev`, it'll add these: (TODO)

    data/         a .gitignore'd folder for dev-mode data
      db/         a LevelDB database, created by rs-dev
      events/     various logging


#### Additions to `app`

    app.dir     Your app's folder
    app.slug    Your app folder's name, with dashes replaced by underscores
    app.server  The HTTP server, e.g. for your tests to .close
    app.db      This apps's LevelDB wrapper of the sole LevelDB client
                  All keys are automatically prefixed with "#{app.slug}:"


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
