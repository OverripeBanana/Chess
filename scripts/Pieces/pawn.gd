extends Piece

class_name Pawn

@onready var pawn_movement = $Movement/PawnMovement

var enPassant : bool = false
var turnsMoved : int = 0
var pieces

func _ready():
	initPiece()
	self.finishedMovement.connect(_on_finished_movement)
	TurnManager.blackTurnFinished.connect(_on_black_turn_finished)
	TurnManager.whiteTurnFinished.connect(_on_white_turn_finished)
	pieces = self.get_parent().get_parent()
	
func _process(_delta):
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
	if self.color == 0:
		pieces.spawnPiece(pieces.black_queen, self.position)
	elif self.color == 1:
		pieces.spawnPiece(pieces.white_queen, self.position)
		
func _on_finished_movement():
	self.turnsMoved += 1
	if self.color == ChessColor.chess_color.BLACK:
		if self.position.y == 750:
			promote()
		if self.position.y == 350 and turnsMoved == 1:
			enPassant = true
	if self.color == ChessColor.chess_color.WHITE:	
		if self.position.y == 50:
			promote()
		if self.position.y == 450 and turnsMoved == 1:
			enPassant = true

	pawn_movement.oneSquare()
	
	
func _on_black_turn_finished():
	if self.color == ChessColor.chess_color.WHITE and enPassant == true:
		enPassant = false
	
func _on_white_turn_finished():
	if self.color == ChessColor.chess_color.BLACK and enPassant == true:
		enPassant = false
