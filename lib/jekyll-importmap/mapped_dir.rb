require 'jekyll'
require 'jekyll-importmap'
require 'jekyll-importmap/mappable'

module Jekyll::Importmap

    # MappedFile = Struct.new(:name, :path, :preload, keyword_init: true)
    # MappedDir = Struct.new(:dir, :under, :path, :preload, keyword_init: true)

    class MappedDir < Jekyll::Importmap::Mappable

        attr_reader :dir, :under

        def initialize(hash, resolver=Jekyll::Importmap::Resolver)
            super
            @dir = hash[:dir]
            @under = hash[:under]
        end

        def javascript_files_in_tree
            selector = absolute_root_path.join("**/*.js{,m}")
            files = Dir[selector].sort
            files.collect do |file|
                Pathname.new(file)
            end.select(&:file?)
        end

        def expanded_paths
            javascript_files_in_tree.collect do |pathname|
                module_filename = pathname.relative_path_from(absolute_root_path)
                module_path = module_path_from(module_filename)
                module_name = module_name_from(module_filename)

                Jekyll::Importmap::MappedFile.new(
                    name: module_name,
                    path: module_path,
                    preload: @preload
                )
            end
        end

        def module_name_from(filename)
            filename = filename.to_s.gsub(filename.extname, '').gsub(/\/?index$/, '')
            filename = nil if filename.length < 1
            [@under, filename].compact.join('/')
        end
        def module_path_from(filename)
            [@path || @under, filename.to_s].compact.reject(&:empty?).join('/')
        end
    end
end