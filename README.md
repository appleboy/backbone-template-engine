# Backbone-Template-Engine

[![Build Status](https://travis-ci.org/appleboy/backbone-template-engine.png)](http://travis-ci.org/appleboy/backbone-template-engine) [![Build Status](https://drone.io/github.com/appleboy/backbone-template-engine/status.png)](https://drone.io/github.com/appleboy/backbone-template-engine/latest)

## Features

* The latest [html5boilerplate.com](http://html5boilerplate.com/) source code.
* Includes [Normalize.scss](https://github.com/appleboy/normalize.scss) v3.0.x and v1.1.x.
* The latest [jQuery](http://jquery.com/) and [Modernizr](http://modernizr.com/) via [Bower](http://bower.io/) package manager.
* Support [CoffeeScript](http://coffeescript.org/), [RequireJS](http://requirejs.org/), [Compass](http://compass-style.org/), html minification (via [html-minifier](http://kangax.github.io/html-minifier/)).
* A lightweight web server listen to 1337 port.
* Support JavaScript test framework [Mocha](http://visionmedia.github.io/mocha/)
* Support The streaming build system [GulpJS](http://gulpjs.com)
* Support [Backbone.js](http://backbonejs.org) MV* Framework
* Support [Handlebars.js](http://handlebarsjs.com) Mustache templating language

## Installation

Please install node.js first (>0.10) and [bower](http://bower.io/) package manager

```bash
$ npm install -g bower
$ npm install && bower install
```

Start App

```bash
$ npm start
```

Excuting above command will output the following message.

```
[16:32:54] Requiring external module coffee-script/register
[16:32:55] Using gulpfile /home/git/backbone-template-engine/gulpfile.coffee
[16:32:55] Starting 'default'...
[16:32:55] Starting 'coffee'...
[16:32:55] Starting 'compass'...
[16:32:55] Finished 'coffee' after 233 ms
directory app/assets/css/
   create app/assets/css/ie.css

   create app/assets/css/print.css

   create app/assets/css/screen.css

[16:32:56] Finished 'compass' after 1.23 s
[16:32:56] Starting 'connect:app'...
[16:32:56] Server started http://localhost:1337
[16:32:56] LiveReload started on port 35729
[16:32:56] Finished 'connect:app' after 27 ms
[16:32:56] Starting 'watch'...
[16:32:56] Finished 'watch' after 9.92 ms
[16:32:56] Finished 'default' after 1.39 s
```

Open browser like chrome or firefox and enter http://localhost:1337 URL.

## Release

Execute the following command will generate `dist` folder.

```bash
$ npm release
```

## Test

To test release process by following command.

```bash
$ npm test
```
