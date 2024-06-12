extends Node2D

class_name Piece

enum color {WHITE, BLACK}
var selected : bool = false
@onready var mousebox : Area2D = $Mousebox
@onready var movement : Area2D = $Movement

func _ready():
	mousebox.input_event.connect(_on_mousebox_input_event)
	disableMovementBox()
	#position = searchForClosestSquare().position
	movement.set_as_top_level(false)
	
func _process(delta):
	if selected:
		followMouse()

func _on_mousebox_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.pressed:
			selected = true
			enableMovementBox()
			freezeMovementBox()
		elif !event.pressed:
			selected = false
			disableMovementBox()
			snapToClosestSquare()
			unfreezeMovementBox()
			
func searchForClosestSquare():
	var legal_squares = movement.get_overlapping_areas()
	if len(legal_squares) != 0:
		var closest_square = legal_squares[0]
		for value in legal_squares:
			if position.distance_squared_to(value.position) < position.distance_squared_to(closest_square.position):
				closest_square = value
		return closest_square
	
func snapToClosestSquare():
	position = searchForClosestSquare().position

func freezeMovementBox():
	movement.set_as_top_level(true)
	movement.position = position
	
func unfreezeMovementBox():
	movement.set_as_top_level(false)
	
func disableMovementBox():
	movement.set_collision_layer_value(1, false)

func enableMovementBox():
	movement.set_collision_layer_value(1, true)
	
func followMouse():
	position = get_global_mouse_position()

