#!/usr/bin/ruby -w
# -*- coding: utf-8 -*-

require 'open-uri'

class StockParser
   def initialize(prefix)
	  @prefix=prefix
   end
   
   def parse(code)
	  
   end

   def test(code)
	  url=@prefix+code
	  open(url) { |f|
		 puts f.read
	  }
   end
end

code="sh601006"
url_prefix = "http://hq.sinajs.cn/list="
sinaParser=StockParser.new(url_prefix)
sinaParser.test(code)
