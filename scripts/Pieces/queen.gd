extends Piece

class_name Queen

@onready var diagonal_movement = $Movement/DiagonalMovement
@onready var horizontal_movement = $Movement/HorizontalMovement

func _ready():
	initPiece()
	
	
func _process(_delta):
	if released:
		horizontal_movement.objects_collide.clear()
		diagonal_movement.objects_collide.clear()
		for ray in horizontal_movement.directions:
			ray.clear_exceptions()
		for ray in diagonal_movement.directions:
			ray.clear_exceptions()	
	legal_squares = horizontal_movement.objects_collide + diagonal_movement.objects_collide
	move()
	
	

