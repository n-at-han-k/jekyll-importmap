module Jekyll::Importmap
    JS_PATH = ''

    class Resolver
        def self.path_to_asset(path)
            'https://' + self.url + JS_PATH + '/' + path
        end

        def self.host_or_url
            if Jekyll.configuration['url']
                Jekyll.configuration['url']
            else
                Jekyll.configuration['host']
            end
        end
        def self.base_url
            if Jekyll.configuration['baseurl']
                '/' + Jekyll.configuration['baseurl']
            else
                ''
            end
        end
        #def self.port
            #if Jekyll.configuration['port'] && Jekyll.configuration['port'].length > 0
                #':' + Jekyll.configuration['port']
            #else
                #''
            #end
        #end

        def self.url
            #self.host_or_url + self.port + self.base_url
            self.host_or_url + self.base_url
        end
    end
end