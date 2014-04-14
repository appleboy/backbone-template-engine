({
  appDir: "../app/",
  baseUrl: "assets/js/",
  dir: "../dist",
  name: "main",
  mainConfigFile: "../app/assets/js/main.js",
  preserveLicenseComments: false,
  fileExclusionRegExp: /^(\.|node_modules)/
  // support generate Source Maps, make sure requirejs version in 2.1.2
  // optimize: "uglify2",
  // generateSourceMaps: true,
})
