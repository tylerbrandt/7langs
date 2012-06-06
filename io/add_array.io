List sumArray := method(
	s := 0
	foreach(v, s = s + v sum)
)

l := list(list(1,2,3), list(4,5,6), list(7,8,9))
l sumArray println