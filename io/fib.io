fib := method(n,
	if(n <= 2, 1, fib(n-1) + fib(n-2))
	)

fibiter := method(n,
	cur := 0; last := 1; second := 0
	for(i,1,n,
	second = last
	last = cur
	cur = last + second
	)
	cur
	)

list(1,2,3,4,5) foreach(i, fibiter(i) println)