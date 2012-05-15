require "net/http"
require "uri"

module Fetchers
   class HTTPStatus 

     TIMEOUT = 30

     def initialize(url)
       @url = url
     end

     def fetch
       begin
         uri = URI.parse(@url)
         
         http = Net::HTTP.new(uri.host, uri.port)
         http.read_timeout = TIMEOUT
              
         if @url =~ /^https:\/\/.*/
           http.use_ssl = true
           # fake cert? no problem!
           http.verify_mode = OpenSSL::SSL::VERIFY_NONE
         end
         
         response = http.request(Net::HTTP::Get.new(uri.request_uri))
         print "\n\n", response.code, " ", response.message, "\n\n"

       rescue Timeout::Error
         printf "\n\nTimeout error\n\n"
       rescue Errno::ECONNREFUSED
         printf "\n\nConnection Refused\n\n"
       rescue Exception
         print "\n\nIllegal URL\n\n"
       end

       if response != nil
         response.code == 200 ? {:available => false} : {:available => true}
       else
         response
       end
    end
  end
end



