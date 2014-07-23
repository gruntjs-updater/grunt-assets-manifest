crypto = require 'crypto'
_ = require 'lodash'
module.exports = (grunt) ->
  grunt.registerMultiTask 'manifest', 'Generate assets manifest', ->
    manifest = {}
    console.log @
