# frozen_string_literal: true

require_relative "lib/jekyll-importmap/version"

Gem::Specification.new do |spec|
    spec.name = "jekyll-importmap"
    spec.version = Jekyll::ImportmapTag::VERSION
    spec.authors = ["Nathan Kidd"]
    spec.email = ["nathanblenheimkidd@gmail.com"]
    spec.summary = "A plugin for jekyll to utilize importmaps"
    spec.homepage = "https://github.com/n-at-han-k/jekyll-importmap"
    spec.license = "MIT"

    spec.files = Dir["lib/**/*"]
    spec.require_paths = ["lib"]

    spec.add_dependency "jekyll", ">= 3.8", "< 5.0"
    spec.add_dependency "importmap-rails", "~> 2.0.1"
    spec.add_development_dependency "bundler", ">= 1.15"
    spec.add_development_dependency "rspec", "~> 3.5"
end