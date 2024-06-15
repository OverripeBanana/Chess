extends Piece

@onready var diagonal_movement = $Movement/DiagonalMovement
@onready var horizontal_movement = $Movement/HorizontalMovement

func _ready():
	initPiece()
	
func _process(_delta):
	print(released)
	if released:
		horizontal_movement.objects_collide.clear()
		diagonal_movement.objects_collide.clear()
	move()
	legal_squares = horizontal_movement.objects_collide + diagonal_movement.objects_collide

