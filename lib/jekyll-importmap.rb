# frozen_string_literal: true

require "jekyll"
require "importmap-rails"

module Jekyll
    class ImportmapTag < Liquid::Tag
        def render(context)
            "Proof of concept"
        end
    end
end

Liquid::Template.register_tag("importmap", Jekyll::ImportmapTag)