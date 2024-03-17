# frozen_string_literal: true

# Prevent bundler errors
module Liquid; class Tag; end; end

module Jekyll
  class ImportmapT4g < Liquid::Tag
    VERSION = "0.1.14"
  end
end