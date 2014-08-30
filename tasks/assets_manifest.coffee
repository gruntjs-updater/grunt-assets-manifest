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
      algorithmHash = crypto.createHash "MD5"
      hash = algorithmHash.update(grunt.file.read(file)).digest("hex")
      name = "#{path.basename file, ".js"}"
      destWithHash = "#{dest}/#{path.basename file, ".js"}-#{hash}.js"
      nameWithHash =  "#{path.basename file, ".js"}-#{hash}"
      grunt.file.write destWithHash, grunt.file.read file

      manifest[name] = nameWithHash

    grunt.file.write "#{dest}/assets.json", JSON.stringify manifest
    @data.done("#{dest}/assets.json", JSON.stringify manifest)
