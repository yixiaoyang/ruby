#!/usr/bin/ruby

=begin
Description:
	this is a test programme for the basic attribute of ruby.
Log:
	1.
	2
=end

# 1.print hello
print "hello ruuby\r\n"

# 2.basic type
CONST_STR="hello ruby const type\r\n"
print CONST_STR

a,b,c,d = 1,2,3,4
print "a.class= #{a.class}\r\n"
a.kind_of? Integer
print a,b,c,d,"\r\n"

words = ["one", "two", "three", "four"]
print words, "\r\n"
words.index("three")


