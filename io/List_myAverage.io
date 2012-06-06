List myAverage := method(
	nums := select(proto == Number)
	s := 0
	len := 0
	nums foreach(v, 
		s = s + v
		len = len + 1
	)
	if(len == 0, 0, s / len)
)

l := list(1,10,3,"12")
l myAverage println