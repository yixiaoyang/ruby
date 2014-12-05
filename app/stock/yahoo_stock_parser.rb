#!/usr/bin/ruby -w
# -*- coding: utf-8 -*-

# load current path
$LOAD_PATH.unshift(File.dirname(__FILE__)) unless $LOAD_PATH.include?(File.dirname(__FILE__))

require 'open-uri'
require 'yaml'
require 'yahoo_finance'

class YahooStockParser
   def initialize(ws,yamlFile)
      @format='%-10s %-10s %-10s %-10s %-10s %-16s %-16s %-16s %-16s %-12s %s'
      @reg=Regexp.new('var hq_str_(.*)=\"(.*)\";')
     
      @ws=ws
      @yamlFile=yamlFile
      config = YAML::load(File.open(yamlFile))
      @code=config[@ws]['code'].split(',')
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
   
   def downloadAllCvs
      @code.each{ |code|
          puts "request for #{code}..."
          YahooFinance.historical_quotes_save(code, { :save => true, :savename => "#{code}.cvs" } ) # entire historical data
      }
   end
   
   def parse()
       appleData=YahooFinance.historical_quotes_save("AAPL", { :save => true, :savename => "APPL.cvs" } ) # entire historical data\
       puts appleData
=begin
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
=end
   end

   def test(code)
      url=@prefix+code
      open(url) { |f|
         puts f.read
      }
   end
end

yahooParser=YahooStockParser.new('yahoo','StockParse.yaml')
yahooParser.downloadAllCvs