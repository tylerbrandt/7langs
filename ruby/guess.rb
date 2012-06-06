guess = nil
actual = rand(10)+1

puts "The secret number is between 1 and 10"

while guess != actual
	puts "Guess a number: "
	guess = gets.chomp().to_i
end

puts "You got it!"