fs = require "fs"
path = require "path"
crypto = require 'crypto'
_ = require 'lodash'

module.exports = (grunt) ->
  grunt.registerMultiTask 'manifest', 'Generate assets manifest', ->
    manifest = {}
    files = @data.files
    dest = @data.dest
    _(files).each (file) ->
      _file = file.file
      _name = file.dest

      algorithmHash = crypto.createHash "MD5"
      hash = algorithmHash.update(grunt.file.read(_file)).digest("hex")
      destWithHash = "#{dest}/#{path.basename _file, ".js"}-#{hash}.js"
      nameWithHash =  "#{path.basename _file, ".js"}-#{hash}"
      grunt.file.write destWithHash, grunt.file.read _file

      manifest[_name] = nameWithHash

    # grunt.file.write "#{dest}/assets.json", JSON.stringify manifest
    @data.done(JSON.stringify manifest)
