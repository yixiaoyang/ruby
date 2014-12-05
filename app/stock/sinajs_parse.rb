#!/usr/bin/ruby -w
# -*- coding: utf-8 -*-

require 'open-uri'
require 'yaml'

class StockParser
   def initialize(ws,yamlFile)
	  @format='%-10s %-10s %-10s %-10s %-10s %-16s %-16s %-16s %-16s %-12s %s'
	  @reg=Regexp.new('var hq_str_(.*)=\"(.*)\";')
	 
	  @ws=ws
	  @yamlFile=yamlFile
	  config = YAML::load(File.open(yamlFile))
	  @prefix=config[@ws]['prefix']
	  @code=config[@ws]['code']
   end
   
   def print_hdr
	  formatStr=sprintf(@format,
						"Last",
						"Open",
						"Yestdy",
						"Chg",
						"Chg%",
						"Hands",
						"Volum",
						"Sel1",
						"Buy1",
						"Code", "Name")
	  puts formatStr 
   end

   def print
	  #todayStartP=@stockData[1].to_f
	  yestodayEndP=@stockData[2].to_f
	  currentP=@stockData[3].to_f
	  chg=currentP-yestodayEndP
	  chgStr="%.6s" % chg
	  chgPerStr="%0.5s" % ((chg/yestodayEndP)*100)

	  formatStr=sprintf(@format,
						@stockData[3],
						@stockData[1],
						@stockData[2],
						chgStr,chgPerStr,
						@stockData[8],
						@stockData[9],
						@stockData[20]+"/"+@stockData[21],
						@stockData[10]+"/"+@stockData[11],
						@stockCode,
						@stockData[0].encode("utf-8"))
	  puts formatStr
   end
   
   def parse()
	  url=@prefix+@code
	  open(url){ |f|
		 @response=f.read.to_s
	  }
	  @response.each_line{ |stockStr|
		 @reg =~ stockStr
		 @stockCode=$1
		 @stockData=$2.split(',')
		 self.print
	  }
   end

   def test(code)
	  url=@prefix+code
	  open(url) { |f|
		 puts f.read
	  }
   end
end

sinaParser=StockParser.new('sina','StockParse.yaml')
sinaParser.print_hdr
sinaParser.parse()
