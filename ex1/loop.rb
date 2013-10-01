#
#
#

# 1.loop
i = 20
loop do
    i -= 1
    print "#{i}"
    break if i <= 0
end


for i in (1..50)
    print i
end

#2.hash
my_hash = { "name" => "Eric",
    "age" => 26,
    "hungry?" => true
}

puts my_hash["name"]
puts my_hash["age"]
puts my_hash["hungry?"]

#3.hash histogram 
puts "Text please: "
text = gets.chomp

words = text.split(" ")
frequencies = Hash.new(0)
words.each { |word| frequencies[word] += 1 }
frequencies = frequencies.sort_by {|a, b| b }
frequencies.reverse!
frequencies.each { |word, frequency| puts word + " " + frequency.to_s }

#4.string...
puts "hello?"*3
