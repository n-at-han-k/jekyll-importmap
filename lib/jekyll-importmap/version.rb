# frozen_string_literal: true

# Prevent bundler errors
module Liquid; class Tag; end; end

module Jekyll
  class ImportmapTag < Liquid::Tag
    VERSION = "0.2.0"
  end
end