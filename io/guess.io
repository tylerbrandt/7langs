Guesser := Object clone do(
	guess := method(x,
		if(x == actual, true,
			if(lastGuess == nil, "Try again",
				dist := (x - actual) abs
				if(dist < (x - lastGuess) abs, "Warmer", "Colder")
			)
		)
	)

	start := method(
		self lastGuess := nil
		self actual := Random value(99) ceil
		in := File standardInput
		10 repeat(
			"Guess a number between 1 and 100" println
			guessed := in readLine asNumber

			result := guess(guessed)
			if(result == true,
				break
				,
				result println
			)

			lastGuess = guessed
		)

		if(result == true, "You got it!" println, 
			actual println
			"Better luck next time" println)
	)
)

guesser := Guesser clone
guesser start
