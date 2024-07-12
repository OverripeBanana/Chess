extends Piece

class_name Pawn

@onready var pawn_movement = $Movement/PawnMovement

var enPassant : bool = false
var turnsMoved : int = 0

func _ready():
	initPiece()
	self.finishedMovement.connect(_on_finished_movement)
	TurnManager.blackTurnFinished.connect(_on_black_turn_finished)
	TurnManager.whiteTurnFinished.connect(_on_white_turn_finished)
	
func _process(_delta):
	print(enPassant)
	if released:
		pawn_movement.oneSquare()
		enPassant = true
		
	if mostRecentSquare == null:
		setMostRecentSquare()
	legal_squares = pawn_movement.objects_collide
	removeOccupiedSquares()
	if Input.is_action_just_released("left_click"):
		await get_tree().create_timer(RESET_WAIT_TIME).timeout
		resetMovementComponents()
	move()

func promote():
	queue_free()
	
func _on_finished_movement():
	if self.color == ChessColor.chess_color.BLACK:
		if self.position.y == 750:
			promote()
	if self.color == ChessColor.chess_color.WHITE:	
		if self.position.y == 50:
			promote()

func _on_black_turn_finished():
	if self.color == ChessColor.chess_color.WHITE and self.released:
		enPassant = false
	
func _on_white_turn_finished():
	if self.color == ChessColor.chess_color.BLACK and self.released:
		enPassant = false