#
# 01Oct13, xiaoyang, Shenzhen
# ref http:www.codecademy.com 
#

movies = {
    # title: rating
    :Memento => 3,
    :Primer => 4,
    :Ishtar => 1
}

puts "Movies Book"

loop{
    puts "--command:add/update/del/exit your movies lib"
    choice = gets.chomp.downcase

    case choice
    when 'add'
        puts "movie title?"
        title = gets.chomp
        if movies[title.to_sym].nil?
            puts "rating?(0-5)"
            rating = gets.chomp

            movies[title.to_sym] = rating.to_i
            puts "movie #{title} has been added with rating #{rating}"
        else
            puts "movie #{title} has been existed"
        end
    when 'update'
        puts "movie title?"
        title = gets.chomp
        if movies[title.to_sym].nil?
            puts "movie #{title} not found"
        else
            puts "rating?(0-5)"
            rating = gets.chomp
            movies[title.to_sym] = rating.to_i
            puts "movie #{title} has been updated with rating #{rating}"
        end
    when 'del'
        puts "movie title?"
        title = gets.chomp
        if movies[title.to_sym].nil?
            puts "movie #{title} not found"
        else
            movies.delete(title.to_sym)
            puts "movie #{title} has been deleted" 
        end
    when 'show'
        movies.each{
            |key,val| puts "#{key}:#{val}"
        }
    when 'exit'
        break
    else
        puts "Sorry, unkonwn cmd"
    end
}
