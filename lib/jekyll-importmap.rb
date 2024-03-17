require "jekyll"
require "jekyll-importmap/version"
require "jekyll-importmap/map"
require "jekyll-importmap/mapped_dir"
require "jekyll-importmap/mapped_file"
require "jekyll-importmap/mappable"
require "jekyll-importmap/resolver"
require "importmap-rails"

module Jekyll
    module Importmap; end

    ES_MODULE_SHIM = "https://ga.jspm.io/npm:es-module-shims@1.8.3/dist/es-module-shims.js"
    IMPORTMAP_PATH = "importmap.rb"

    class ImportmapTag < Liquid::Tag
        def initialize(tag_name, text, tokens)
            super
            #root_path = Pathname.new(Jekyll.configuration['source']) + '/'
            root_path = Dir.pwd + '/'
            @importmap = Jekyll::Importmap::Map.new.draw(root_path.concat(IMPORTMAP_PATH))
            @entry_point = "application"
        end

        def render(context)
            import_map_tags(@entry_point, @importmap)
        end

        private

            def import_map_tags(entry_point, importmap)
                [
                    inline_importmap_tags,
                    importmap_module_preload_tags,
                    import_module_tag,
                    es_module_shim_tag
                ].join('')
            end

            def inline_importmap_tags
                "<script type='importmap'>#{@importmap.to_json}</script>"
            end
            def importmap_module_preload_tags
                #module_preload_tag(*importmap.preloaded_module_paths)
            end
            def module_preload_tag(*paths)
                Array(paths).collect {|p| %(<link rel="modulepreload" href="#{p}">)}.join('\n')
            end
            def import_module_tag
                imports = Array(@entry_points).collect {|e| %(import '#{e}')}.join('\n')
                "<script type='module'>#{imports}</script>"
            end
            def es_module_shim_tag
                "<script src='#{ES_MODULE_SHIM}' async='async'></script>"
            end
    end
end

Liquid::Template.register_tag("importmap", Jekyll::ImportmapTag)