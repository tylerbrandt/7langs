class Board(positions:Array[Array[String]] = null) {
	private var boardState = positions
	if (positions == null) {
		reset
	}

	def emptyBoard:Array[Array[String]] = {
		return Array.tabulate(3,3)((x,y) => "")
	}

	def reset {
		boardState = emptyBoard
	}

	def play(position:Array[Int], player:String):String = {
		val i = position(0)
		val j = position(1)
		if(boardState(i)(j) == "") {
			boardState(i)(j) = player
			display
			return result
		} else {
			println("That space is already occupied by: " + boardState(i)(j))
			return "RETRY"
		}
	}

	def display {
		for (i <- 0 until boardState.length) {
			println(
				boardState(i).map((value) =>
					value match {
						case "" => " "
						case _ => value
					}).reduceLeft(_ + "|" + _))
		}
	}

	object ResultType extends Enumeration {
		type ResultType = Value
		val Win, Draw, Unknown = Value
	}
	import ResultType._

	def result():String = {
		// all winning positions occur contain one along this diagonal:
		// x__
		// _x_
		// __x
		val anchorPositions = List(
			(1,1),	// _x_  x_x (4 winners)
					// xxx  xxx
					// _x_  x_x
			
			(0,0),	// xxx (2 winners)
					// x__  
					// x__
			
			(2,2)	// __x (2 winners)
					// __x
					// xxx
		)
		var draws = 0
		for (position <- anchorPositions) {
			var (i,j) = position
			if (boardState(i)(j) != "") {
				var result = checkPos(position)
				if (result == ResultType.Win) {
					return "Winner: " + boardState(i)(j)
				} else if (result == ResultType.Draw) {
					draws += 1
				}
			}
		}

		if(draws == anchorPositions.length) {
			return "Cat's game!"
		}
		return ""
	}

	private def checkPos(position:(Int,Int)):ResultType = {
		// check row || column || diag
		val (i,j) = position
		val rowBounds = (math.max(i - 2, 0),math.min(i + 2, boardState.length - 1))
		val colBounds = (math.max(j - 2, 0),math.min(j + 2, boardState.length - 1))

		val rowResult = checkRows(position,colBounds)

		if(rowResult == ResultType.Win) {
			return rowResult
		}

		val colResult =	checkCols(position,rowBounds)

		if(colResult == ResultType.Win) {
			return colResult
		}
		
		if (position == (1,1)) {
			// only check diagonal on the center anchor point
			val diagResult = checkDiags
			if(diagResult == ResultType.Win) {
				return diagResult
			} else if(rowResult == ResultType.Draw && 
					colResult == ResultType.Draw && 
					diagResult == ResultType.Draw) {
				return ResultType.Draw
			}
			return ResultType.Unknown
		}
		if (rowResult == ResultType.Draw && 
					colResult == ResultType.Draw) {
			return ResultType.Draw
		}
		return ResultType.Unknown
	}

	private def checkRows(position:(Int,Int), 
					bounds:(Int,Int)):ResultType = {
		val (i,j) = position
		val (min,max) = bounds

		for (jj <- min to max) {
			if (boardState(i)(jj) != boardState(i)(j)) {
				if (boardState(i)(jj) != "") {
					// no win possible
					return ResultType.Draw
				}
				return ResultType.Unknown
			}
		}
		return ResultType.Win
	}

	private def checkCols(position:(Int,Int), 
					bounds:(Int,Int)):ResultType = {
		val (i,j) = position
		val (min,max) = bounds

		for (ii <- min to max) {
			if (boardState(ii)(j) != boardState(i)(j)) {
				if (boardState(ii)(j) != "") {
					// no win possible
					return ResultType.Draw
				}
				return ResultType.Unknown
			}
		}
		return ResultType.Win
	}

	private def checkDiags:ResultType = {
		val (i,j) = (1,1)
		val matchChar = boardState(i)(j)

		val res = boardState(i-1)(j-1) == matchChar && 
			boardState(i+1)(j+1) == matchChar
		
		if (!res) {
			val res2 = boardState(i-1)(j+1) == matchChar &&
				boardState(i+1)(j-1) == matchChar

			if (res2) {
				return ResultType.Win
			}
			
			val draw = ((boardState(i-1)(j-1) != "" && boardState(i-1)(j-1) != matchChar) ||
						(boardState(i+1)(j+1) != "" && boardState(i+1)(j+1) != matchChar)) &&
						((boardState(i-1)(j+1) != "" && boardState(i-1)(j+1) != matchChar) ||
						(boardState(i+1)(j-1) != "" && boardState(i+1)(j-1) != matchChar))

			if (draw) {
				return ResultType.Draw
			}
			return ResultType.Unknown
		}

		return ResultType.Win
	}
	
}

class Game {
	val players = List("X","O")	
	var currentPlayer = 0
	val board = new Board

	def reset {
		board.reset
		currentPlayer = 0
	}

	def play {
		reset
		var result = ""

		while (result == "") {
			print("Player " + players(currentPlayer) + " (x,y): ")
			var move = readLine()
			if (move == "d") {
				board.display
			} else {
				result = board.play(move.split(",").map(_.toInt), players(currentPlayer))
				if (result == "RETRY") {
					result = ""
				} else {
					currentPlayer = (currentPlayer + 1) % players.length
				}
			}
			
		}
		println(result)

		print("Play again (y/n)? ")
		if (readLine() == "y") {
			play
		}
	}
}

val game = new Game
game.play