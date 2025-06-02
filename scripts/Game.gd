
# scripts/Game.gd
extends Control

var board := [
	[ "", "", "" ],
	[ "", "", "" ],
	[ "", "", "" ]
]

var my_symbol := "X"  # host is X, guest is O; tweak if you like
var turn := "X"

func _ready():
	if Net._is_host:
		my_symbol = "X"
	else:
		my_symbol = "O"
	$WhoseTurn.text = "Turn: %s" % turn

# Called by each of the 9 button nodes (signal)
func _on_Cell_pressed(row: int, col: int) -> void:
	if turn != my_symbol: return
	if board[row][col] != "": return
	_make_move(row, col)

@rpc("any_peer")  # everyone hears this
func _make_move(row: int, col: int) -> void:
	if board[row][col] != "": return  # already taken
	board[row][col] = turn
	$"Grid/Cell_%d_%d/Label".format(row, col).text = turn
	turn = turn == "X" ? "O" : "X"
	$WhoseTurn.text = "Turn: %s" % turn
	_check_winner()

func _check_winner():
	var lines = []
	lines += board                         # rows
	lines += [ [board[r][c] for r in 0..2] for c in 0..2 ]  # cols
	lines += [ [board[i][i] for i in 0..2 ],
			   [board[i][2-i] for i in 0..2] ]              # diagonals

	for line in lines:
		if line == ["X","X","X"] or line == ["O","O","O"]:
			$WhoseTurn.text = "%s wins!" % line[0]
			set_process(false)  # stop the game
			return

	if board.flatten().count("") == 0:
		$WhoseTurn.text = "Draw!"
		set_process(false)
