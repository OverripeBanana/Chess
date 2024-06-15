extends Node2D

class_name Piece

@onready var movement = $Movement
@onready var mousebox : Area2D = $Mousebox
var selected = false
var clicked = false
var released = false
var mostRecentPos : Vector2
var legal_squares = []

func initPiece():
	mousebox.input_event.connect(_on_mousebox_input_event)

func move():
	if selected:
		followMouse()
		
func _on_mousebox_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton:
		if event.pressed:
			unparentRayCast()
			selected = true
			clicked = true
			released = false
		if !event.pressed and clicked:
			clicked = false
			selected = false
			released = true
			snapToClosestSquare()
			mostRecentPos = position
			parentRayCast()
			
func searchForClosestSquare():
	if len(legal_squares) != 0:
		var closest_square = legal_squares[0]
		for value in legal_squares:
			if position.distance_squared_to(value.position) < position.distance_squared_to(closest_square.position):
				closest_square = value
		return closest_square.position
	else:
		return mostRecentPos
		
func snapToClosestSquare():
	position = searchForClosestSquare()
	
func unparentRayCast():
	movement.set_as_top_level(true)
	movement.global_position = position
	
func parentRayCast():
	movement.set_as_top_level(false)
	movement.global_position = position
	
func followMouse():
	position = get_global_mouse_position()

