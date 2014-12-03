#!/usr/bin/ruby

#
# fetch stock data from sina
# by hityixiaoyang@gmail.com 09Oct14
#

module Log
   def Log.d(msg)
	  print "[DBG] #{msg}\n"
   end
   def Log.e(msg)
	  print "[ERR] #{msg}\n"
   end
end

class MessageItem
   attr_accessor :id, :title, :summary
   attr_accessor :savedFilename

   def serialize
	  file = File.new(@savedFilename, 'a')
	  
	  str = "[id]: " + @id + "\n"
	  file.puts str


	  str = "[title]: " + @title + "\n"
	  file.puts str

	  file.close
   end

class Page
   attr_accessor :url
end


