# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path("../lib", __dir__)
require "jekyll"
require "jekyll-importmap"
require "jekyll-importmap/map"
require "jekyll-importmap/resolver"
require "importmap-rails"

TEST_IMPORTMAP_PATH = Dir.pwd + '/spec/test_importmap.rb'
TEST_JS_PATH = Dir.pwd + '/spec/test_js_files'

RSpec.configure do |config|
end