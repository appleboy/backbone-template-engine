# Backbone-Template-Engine
[ ![Codeship Status for appleboy/backbone-template-engine](https://www.codeship.io/projects/cd4cbb80-0a59-0131-b608-2ec31197f4f1/status?branch=master)](https://www.codeship.io/projects/7463) [![Build Status](https://travis-ci.org/appleboy/backbone-template-engine.png)](http://travis-ci.org/appleboy/backbone-template-engine) [![Build Status](https://drone.io/github.com/appleboy/backbone-template-engine/status.png)](https://drone.io/github.com/appleboy/backbone-template-engine/latest)

## Features

* The latest [html5boilerplate.com](http://html5boilerplate.com/) source code.
* Includes [Normalize.scss](https://github.com/appleboy/normalize.scss) v2.1.x and v1.1.x.
* The latest [jQuery](http://jquery.com/) and [Modernizr](http://modernizr.com/) via [Bower](http://bower.io/) package manager.
* Support [CoffeeScript](http://coffeescript.org/), [RequireJS](http://requirejs.org/), [Compass](http://compass-style.org/), html minification (via [htmlcompressor](http://code.google.com/p/htmlcompressor/)).
* A lightweight web server listen to 3000 port (Using [Node Express Framework](http://expressjs.com/)).
* Support JavaScript Task Runner [GruntJS](http://gruntjs.com/)
* Support JavaScript test framework [Mocha](http://visionmedia.github.io/mocha/)
* Support The streaming build system [GulpJS](http://gulpjs.com)

## Installation

Please install node.js first (>0.10) and [bower](http://bower.io/) package manager

```bash
$ npm install
$ bower install
```

Start App

```bash
$ npm start
```

Excuting above command will output the following message.

```
[gulp] Using gulpfile /home/repo/backbone-template-engine/gulpfile.js
[gulp] Starting 'clean'...
[gulp] Starting 'connect'...
[gulp] Server started http://localhost:1337
[gulp] LiveReload started on port 35729
[gulp] Finished 'connect' after 13 ms
[gulp] Starting 'watch'...
[gulp] Finished 'watch' after 20 ms
[gulp] Finished 'clean' after 43 ms
[gulp] Starting 'default'...
[gulp] Finished 'default' after 24 μs
```

Open browser like chrome or firefox and enter http://localhost:1337 URL.

# Test

To test source project, install the project dependencies once:

```bash
$ npm install
```

Then run the tests:

```bash
$ npm test
```
