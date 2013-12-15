#!/usr/bin/ruby

def scan_rename_dir(dir,type)
  Dir[dir+"/"+type].each do |file|
    if File.file?(file)
      File.rename(file,file+'.txt')
    else
      scan_rename_dir(file,type)
    end
  end
end

scan_rename_dir("ruby-china-master","*")