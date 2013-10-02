#
# constant and inspect
#
class Nums
    C1="hello"
    def show
        puts C1
        puts @param
        puts "param2=#{@param2}"
    end

     attr_accessor :param
     #attr_writer:param2
     attr_reader:param2
end

nums = Nums.new
nums.show()

nums.param="world"
nums.show()

nums.param2="nani???"
nums.show()

