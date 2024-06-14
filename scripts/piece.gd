extends Node2D

class_name Piece

@onready var mousebox : Area2D = $Mousebox

func initPiece():
	mousebox.input_event.connect(_on_mousebox_input_event)
	
func _on_mousebox_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton:
		if event.pressed:
			followMouse()
			
func searchForClosestSquare():
	var legal_squares = []
	if len(legal_squares) != 0:
		var closest_square = legal_squares[0]
		for value in legal_squares:
			if position.distance_squared_to(value.position) < position.distance_squared_to(closest_square.position):
				closest_square = value
		return closest_square
	
func snapToClosestSquare():
	position = searchForClosestSquare().position
	
func followMouse():
	position = get_global_mouse_position()

