require 'rubygems'
require 'net/http'
require 'net/https'
require 'uri'
require 'xml-object'
require 'xml-object/adapters/libxml'

module HAPI
    class APICall
        attr_accessor :params
        def initialize(url)
            @uri = URI.parse(url)
        end

        def url
            "#{@uri.scheme}://#{@uri.host}#{@uri.path}"
        end

        def url=(url)
            @uri = URI.parse(url)
        end

        def post
            call("post")
        end

        def get
            call("get")
        end

        def call(method)
            http = Net::HTTP.new(@uri.host, @uri.port)
            http.use_ssl = (@uri.scheme == 'https')
            if http.use_ssl
                http.verify_mode = OpenSSL::SSL::VERIFY_NONE
            end
            if method == 'post'
                request = Net::HTTP::Post.new(@uri.path)
                request.set_form_data(@params)
            else
                params = @params.keys.map { |r|
                    "#{r}=#{@params[r]}"
                }.join("&")
                request = Net::HTTP::Get.new("#{@uri.path}?#{params}")
            end
            response = http.request(request)
            response = response.body.gsub(/^\<\?xml.+\?\>/, '')
            XMLObject.new(response)
        end
    end
end
