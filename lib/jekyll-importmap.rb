# frozen_string_literal: true

require "jekyll"
require "jekyll-importmap/version"
require "importmap-rails"

module Jekyll
    class ImportmapTag < Liquid::Tag
        def initialize(_tag_name, text, _tokens)
            super
        end

        def render(context)
            return "Proof of concept"
        end
    end
end

Liquid::Template.register_tag("importmap", Jekyll::ImportmapTag)