class UnfilteredMessage(val text:String) {
	def say:String = text
}

trait Censored {
	val replacements = Map("Shoot" -> "Pucky", "shoot" -> "pucky",
							"Darn" -> "Beans", "darn" -> "beans")

	def censored(text:String):String = 
		replacements.foldLeft(text)((replaced_text,replacement) => 
			replacement match {
				case (pattern,repl) => replaced_text.replaceAll(pattern,repl)
			}
		)
}

class FilteredMessage(override val text:String) extends UnfilteredMessage(text) with Censored {
	override def say:String = censored(text)
}

val msg = "Shoot that duck, you darn pig! Shoot!"
val unfilteredMessage = new UnfilteredMessage(msg)
println(unfilteredMessage.say)
val filteredMessage = new FilteredMessage(msg)
println(filteredMessage.say)