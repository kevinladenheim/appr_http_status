#!/usr/bin/env ruby

require_relative "fetcher"

#unless ARGV.length == 1
#  print "need url\n\n"
#  exit
#end

report = Fetchers::HTTPStatus.new(ARGV[0])
status = report.fetch

if status != nil
  print "\n\nreturned status: ", status, "\n\n"
else
  print "\n\nreturn value is nil\n\n"
end


