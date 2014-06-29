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
> backbone-template-engine@1.0.0 start /xxxx/backbone-template-engine
> gulp

[22:46:39] Requiring external module coffee-script/register
[22:46:40] Using gulpfile /xxxx/backbone-template-engine/gulpfile.coffee
[22:46:40] Starting 'default'...
[22:46:40] Starting 'coffee'...
[22:46:40] Starting 'compass'...
[22:46:40] Finished 'coffee' after 459 ms
directory app/assets/css/ 
   create app/assets/css/main.css 

[22:46:41] Finished 'compass' after 1.04 s
[22:46:41] Starting 'connect:app'...
[22:46:41] Server started http://localhost:1337
[22:46:41] LiveReload started on port 35729
[22:46:41] Finished 'connect:app' after 23 ms
[22:46:41] Starting 'watch'...
[22:46:41] Finished 'watch' after 16 ms
[22:46:41] Finished 'default' after 1.32 s
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
