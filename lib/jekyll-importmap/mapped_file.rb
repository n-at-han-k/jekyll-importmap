require 'jekyll'
require 'jekyll-importmap'
require 'jekyll-importmap/mappable'

module Jekyll::Importmap

    # MappedFile = Struct.new(:name, :path, :preload, keyword_init: true)
    # MappedDir = Struct.new(:dir, :under, :path, :preload, keyword_init: true)

    class MappedFile < Jekyll::Importmap::Mappable
        attr_reader :name

        def initialize(hash)
            super
            @name = hash[:name]
        end
    end
end