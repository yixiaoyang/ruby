#
# 1
#
class A
    puts self
    def A=()
        puts self
    end

    def say
        puts "say hello"
        puts self
    end
end

a=A.new
a.say

puts "now puts a.say"
puts a.say


#
# 2
#
class Book
    @name
    @price

    def initialize(n="",p=0)
        @name = n
        @price = p
    end
    def name()
        @name
    end
    def name=(iname)
        @name=iname
    end
    def price=(iprice)
        @price=iprice
    end
    def show()
        print @name,":",@price,"\r\n"
    end
end

B1 = Book.new
B1.show()

B1.name="Ruby on Rails devolopment"
B1.price=12

B=B1
B.show()

B.name="C programing Language"
B.price = 10
B.show()
puts B.name
