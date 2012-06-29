# 7langs

Exercises/scratch work from the book __Seven Languages in Seven Weeks__ by Bruce Tate (http://pragprog.com/book/btlang/seven-languages-in-seven-weeks). When it comes to the examples, the book expects you to go out and find stuff which is outside the text, which is a great approach.

## Notes & observations

### Ruby
  
  * Metaprogramming with `method_missing` is something I hadn't encountered before. I had an issue with the method name until I realized that you had to explicitly cast it into a string.
  * Got most info from ruby docs directly, a few hints from SO
  * The author really loves DSLs

### Io
  
  * Most annoying language name ever! It is virtually impossible to get anything useful about Io on Google or SO, so this was more challenging. http://www.iolanguage.com/scm/io/docs/IoGuide.html is esssential, as is http://www.iolanguage.com/scm/io/docs/reference/index.html. The reference page is difficult to search through, though, since they only show content if you explicitly select a package, and the search function in the page is only useful if you already know the method you want.
  * Prefix notation for message passing is a little tricky at first (especially `"string" println`) but it gets easier.
  * Everything is a method (even control structures) makes proper indentation/highlighting difficult. I went with a "if it's too jammed up to read, then add a newline" heuristic.
  * Really appreciate the guts to pick ONE method of inheritance and go all-in on it. Prototypal inheritance is intuitive and requires a lot less boilerplate than classical.
  * There's often more than one way to say the same thing in Io (e.g. if syntax, parentheses on method calls) which gets confusing.

### Prolog
  
  * Seem to be different dialects around. gprolog doesn't understand a lot of the terms you throw at it (inc, succ, etc) leading to the frustrating 'existence_error'.
  * `is` is not commutative. It actually behaves more like assignment
  * It's nice that you don't have to code the algorithms, but the syntax is pretty unforgiving, and it's hard to describe the problem in a way that prolog understands.
  * In the case of sort, I still had to code the algorithm, albeit in a declarative rather than imperative way.
  * `trace.` to turn on debugging. `notrace.` to turn it off.

### Scala
  
  * Functions which return void don't use `=`, functions which return a value do.
  * Really nice range syntax: `min to max by 2`
  * Like Ruby, functions with no arguments have optional parens (makes it difficult to tell what is a function and what is a property). Functions with a single argument still require parens unlike Ruby.
  * `Unit` = ???
  * It's been a long time since I've had to deal with types; it's a headache. Especially with Scala generic types (Any, Unit, Nothing, etc) it's pretty hard to decipher the errors.