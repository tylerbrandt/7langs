// Parser calls squareBrackets when '[]' encountered
squareBrackets := method(
	call message arguments map(arg,
		doMessage(arg)
	)
)

strs := list("[1,2,3]", "[\"a\", 2, false]", "[1,[2,3],4,5]")
strs foreach (str,
	myList := doString(str)
	writeln("#{str} => #{myList}" interpolate)
)