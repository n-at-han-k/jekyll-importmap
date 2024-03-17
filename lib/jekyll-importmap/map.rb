require 'jekyll'
require 'jekyll-importmap'

module Jekyll::Importmap
    class Map
        attr_reader :packages, :directories

        class InvalidFile < StandardError; end

        def initialize
            @packages, @directories = {}, {}
            @resolver = Jekyll::Importmap::Resolver
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
            else
                raise InvalidFile, "You must provide a file path or a block to draw the importmap, given: #{path}"
            end

            self
        end

        def pin(name, to: nil, preload: false)
            @packages[name] = Jekyll::Importmap::MappedFile.new(name: name, path: to || "#{name}.js", preload: preload)
        end
        def pin_all_from(dir, under: nil, to: nil, preload: false)
            @directories[dir] = Jekyll::Importmap::MappedDir.new(dir: dir, under: under, path: to, preload: preload)
        end

        def preloaded_module_paths
            preloaded_resolved_asset_paths.values
        end

        def to_json
            JSON.pretty_generate({
                "imports" => resolved_asset_paths
            })
        end

        private
            def resolved_asset_paths
                expanded_packages_and_directories.transform_values do |mapped_file|
                    begin
                        mapped_file.resolved_path
                    rescue => e
                        raise e
                    end
                end.compact
            end
            def preloaded_resolved_asset_paths
                preloaded_expanded_packages_and_directories
            end

            def expanded_packages_and_directories
                @packages.dup.tap do |packages|
                    @directories.values.each do |mapped_directory|
                        mapped_directory.expanded_paths.each do |mapped_file|
                            packages[mapped_file.name] = mapped_file
                        end
                    end
                end
            end
            def preloaded_expanded_packages_and_directories
                expanded_packages_and_directories.select do |name, mapped_file|
                    mapped_file.preload == true
                end
            end
    end
end