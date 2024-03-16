require 'jekyll'
require 'jekyll-importmap'

module Jekyll::Importmap
    class Map
        attr_reader :packages, :directories

        class InvalidFile < StandardError; end

        def initialize
            @packages, @directories = {}, {}
            @cache = {}
        end

        def draw(path = nil, &block)
            if path && File.exist?(path)
                begin
                    instance_eval(File.read(path), path.to_s)
                rescue StandardError => e
                    raise InvalidFile, "Unable to parse importmap file from #{path}: #{e.message}"
                end
            elsif block_given?
                instance_eval(&block)
            end

            self
        end

        def pin(name, to: nil, preload: true)
            clear_cache
            @packages[name] = MappedFile.new(name: name, path: to || "#{name}.js", preload: preload)
        end
        def pin_all_from(dir, under: nil, to: nil, preload: true)
            clear_cache
            @directories[dir] = MappedDir.new(dir: dir, under: under, path: to, preload: preload)
        end
        def preloaded_module_paths(resolver:, cache_key: preloaded_module_paths)
            cache_as(cache_key) do
                resolve_asset_paths(expanded_preloading_packages_and_directories, resolver: resolver).values
            end
        end
        def to_json(cache_key: :json)
            return 'example string'
            cache_as(cache_key) do
                JSON.pretty_generate({"imports" => resolve_asset_paths(expanded_packages_and_directories, resolver: resolver)})
            end
        end

        private
            MappedFile = Struct.new(:name, :path, :preload, keyword_init: true)
            MappedDir = Struct.new(:dir, :under, :path, :preload, keyword_init: true)

            def resolve_asset_paths(paths, resolver:)
                paths.transform_values do |mapping|
                    begin
                        resolver.path_to_asset(mapping.path)
                    rescue => e
                        if rescuable_asset_error?(e)
                            nil
                        else
                            raise e
                        end
                    end
                end.compact
            end
            def expanded_packages_and_directories
                @packages.dup.tap {|expanded| expand_directories_into expanded }
            end
            def expand_directories_into(paths)
                @directories.values.each do |mapping|
                end
            end
            
            def cache_as(key)
                if result = @cache[key.to_s]
                    result
                else
                    @cache[key.to_s] = yield
                end
            end
            def clear_cache
                @cache.clear
            end
    end
end