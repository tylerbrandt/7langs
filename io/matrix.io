Matrix := List clone do(
	// Sets size to y rows and x columns and empties contents
	dim := method(x,y,
		self x := x
		self y := y

		setSize(y)

		for(i,0,y-1,
			row := List clone setSize(x)
			atPut(i, row)
		)
	)

	set := method(x,y,value,
		at(y) atPut(x, value)
	)

	get := method(x,y,
		at(y) at(x)
	)

	// Create a transposed Matrix with x rows and y columns
	transpose := method(
		new_matrix := Matrix clone
		new_matrix dim(y,x)
		for(i,0,y-1,
			for(j,0,x-1,
				new_matrix set(i, j, get(j,i))
			)
		)
		new_matrix
	)


)

d := Matrix clone
d dim(2,3)
d set(0,0,"foo")
d set(0,1,"bar")
d set(1,0,"baz")
d println
dt := d transpose
dt println