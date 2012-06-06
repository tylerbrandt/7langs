OperatorTable addAssignOperator(":", "atPutNumber")

Map atPutNumber := method(
    self atPut(
        call evalArgAt(0) asMutable removePrefix("\"") removeSuffix("\""),
        call evalArgAt(1)
    )
)
        
curlyBrackets := method(
    r := Map clone
    call message arguments foreach(arg,
        r doMessage(arg)
    )
    r
)

Builder := Object clone do(
	numIndents := 0

	indents := method(
		str := ""
		numIndents repeat(str = str .. "   ")
		str
	)

	openTag := method(tagName,
		indents .. "<" .. tagName .. ""
	)

	closeTag := method(tagName,
		"</" .. tagName .. ">"
	)

	forward := method(
		tagName := call message name

		// first tag doesn't need a newline (since there can only be one root)
		if(numIndents > 0, writeln())
		
		// write the opening tag minus finishing ">"
		write(openTag(tagName))
		
		// will be true if this node does not contain any others
		textNode := false
		// true if this node has no contents
		empty := false
		if(call message arguments size == 0, empty = true; write(" />"))

		// increase the indenting level
		numIndents = numIndents + 1

		call message arguments foreach(
			i,arg,			
			// first curlyBrackets argument is an attribute set
			if(i == 0, 
				if(arg name == "curlyBrackets", write(attributes(doMessage(arg))))
				write(">")
			)
			// recursively generate content
			content := self doMessage(arg);
			// text node
			if(content type == "Sequence", textNode = true; write(content))
		)

		// decrease the indenting level
		numIndents = numIndents - 1
		
		// only non-empty nodes have a closing tag
		if(empty == false,
			if(textNode != true, writeln(); write(indents))
			write(closeTag(tagName))
		)
	)

	attributes := method(map,
		attrs := ""
		map foreach(k,v,
			attrs = attrs .. " #{k}=\"#{v}\"" interpolate 
		)
		attrs
	)
)	

s := File with("builderSample.txt") openForReading contents
doString(s)
writeln()