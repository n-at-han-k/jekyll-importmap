# frozen_string_literal: true

# Prevent bundler errors
module Liquid; class Tag; end; end

module Jekyll
  class ImportmapTag < Liquid::Tag
    VERSION = "0.1.3"
  end
end