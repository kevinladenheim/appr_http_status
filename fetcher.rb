require "net/http"
require "uri"

module Fetchers
   class HTTP_Status 

     TIMEOUT = 30

     def initialize(url)
       @url = url
     end

     def fetch
       begin
         uri = URI.parse(@url)
         
         if @url[4] == 's'
           http = Net::HTTP.new(uri.host, uri.port)
           http.use_ssl = true
           # fake cert? no problem!
           http.verify_mode = OpenSSL::SSL::VERIFY_NONE
         else
           http = Net::HTTP.new(uri.host, uri.port)
         end

         http.read_timeout = TIMEOUT
         
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



