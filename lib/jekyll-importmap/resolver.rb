module Jekyll::Importmap
    JS_PATH = '/'

    class Resolver
        @@configuration = Jekyll.configuration.freeze

        def self.path_to_asset(path)
            return path if path.start_with?('http') 
            self.url + JS_PATH + path
        end

        def self.host_or_url
            if @@configuration['importmap'] && @@configuration['importmap']['devurl']

                @@configuration['importmap']['devurl']
            else @@configuration['url']
                'https://' + @@configuration['url']
            end
        end

        def self.base_url
            if @@configuration['baseurl']
                @@configuration['baseurl']
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