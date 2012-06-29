import scala.io._
import scala.actors._
import Actor._

// START:loader
object PageLoader {
 def getPageInfo(url : String):(Int,List[String]) = {
 	val sourceString = Source.fromURL(url).mkString
 	val linkPattern = """<a.+href=["']([^'"]+)["']>[^<]+</a>""".r
 	val links = (for(m <- linkPattern.findAllIn(sourceString).matchData; 
 		grps <- m.subgroups) yield grps).toList
 	return (sourceString.length, links)
 }
}
// END:loader

val urls = List("http://www.amazon.com/", 
               "http://www.twitter.com/",
               "http://www.google.com/",
               "http://www.cnn.com/" )

// START:time
def timeMethod(method: () => Unit) = {
 val start = System.nanoTime
 method()
 val end = System.nanoTime
 println("Method took " + (end - start)/1000000000.0 + " seconds.")
}
// END:time

// START:sequential
def getPageSizeSequentially() = {
 for(url <- urls) {
   val info = PageLoader.getPageInfo(url)
   println("Size for " + url + ": " + info._1 + ", num links: " + info._2.length)
 }
}
// END:sequential

// START:concurrent
def getPageSizeConcurrently() = {
 val caller = self

 for(url <- urls) {
   actor { caller ! (url, PageLoader.getPageInfo(url)) }
 }

 for(i <- 1 to urls.size) {
   receive {
     case (url, (size, links:List[String])) =>
       println("Size for " + url + ": " + size + ", num links: " + links.length)            
   }
 }
}
// END:concurrent

// START:script
println("Sequential run:")
timeMethod { getPageSizeSequentially }

println("Concurrent run")
timeMethod { getPageSizeConcurrently }
// END:script