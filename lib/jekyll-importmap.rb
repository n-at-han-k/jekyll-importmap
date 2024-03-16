require "jekyll"
require "jekyll-importmap/version"
require "jekyll-importmap/map"
require "importmap-rails"

module Jekyll
    module Importmap; end

    ES_MODULE_SHIM = "https://ga.jspm.io/npm:es-module-shims@1.8.3/dist/es-module-shims.js"

    class ImportmapTag < Liquid::Tag
        def initialize(tag_name, text, tokens)
            super
            @entry_point = "application"
            @importmap = Jekyll::Importmap::Map.new
        end

        def render(context)
            import_map_tags(@entry_point, @importmap)
        end

        private

            def import_map_tags(entry_point, importmap)
                [
                    inline_importmap_tags(importmap.to_json),
                    importmap_module_preload_tags(importmap),
                    import_module_tag(entry_point),
                    es_module_shim_tag
                ].join('')
            end

            def inline_importmap_tags(importmap_json)
                "<script type='importmap'>#{importmap_json}</script>"
            end
            def importmap_module_preload_tags(importmap)
                #module_preload_tag(*importmap.preloaded_module_paths)
            end
            def module_preload_tag(*paths)
                Array(paths).collect {|p| %(<link rel="modulepreload" href="#{p}">)}.join('\n')
            end
            def import_module_tag(*entry_points)
                imports = Array(entry_points).collect {|e| %(import '#{e}')}.join('\n')
                "<script type='module'>#{imports}</script>"
            end
            def es_module_shim_tag
                "<script src='#{ES_MODULE_SHIM}' async='async'></script>"
            end
    end
end

Liquid::Template.register_tag("importmap", Jekyll::ImportmapTag)