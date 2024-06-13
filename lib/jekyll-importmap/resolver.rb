module Jekyll::Importmap
    JS_PATH = '/'

    class Resolver
        def self.path_to_asset(path)
            return path if path.start_with?('http')
            Jekyll.configuration['baseurl'] + JS_PATH + path
        end
    end
end