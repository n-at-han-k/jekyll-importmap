require 'jekyll'
require 'jekyll-importmap'

module Jekyll::Importmap
    class Mappable
        attr_reader :path, :preload, :keyword_init

        def initialize(hash, resolver=Jekyll::Importmap::Resolver)
            @path = hash[:path]
            @preload = hash[:preload]
            @keyword_init = hash[:keyword_init] ||= true
            @resolver = resolver
        end

        def resolved_path
            @resolver.path_to_asset(@path)
        end
        def absolute_root_path
            @pathname ||= calculate_absolute_root_path
        end
        def calculate_absolute_root_path
            pathname = Pathname.new(@dir || @path)
            if pathname.absolute?
                pathname
            else
                # this is where you can adjust whether we  allow adding js
                # files anywhere or just in the /assets/js directory

                Pathname.new(Dir.pwd).join(pathname)
            end
        end
    end
end