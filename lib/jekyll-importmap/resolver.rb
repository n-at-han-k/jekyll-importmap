module Jekyll::Importmap
    JS_PATH = ''

    class Resolver
        def self.path_to_asset(path)
            'https://' + self.url + JS_PATH + '/' + path
        end

        def self.url
            if Jekyll.configuration['port'] && Jekyll.configuration['port'].length > 0
                Jekyll.configuration['host'] + ':' + Jekyll.configuration['port']
            else
                Jekyll.configuration['host']
            end
        end
    end
end