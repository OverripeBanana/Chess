extends Node2D

class_name Piece

@export var color : Piece_Color
@onready var movement = $Movement
@onready var mousebox : Area2D = $Mousebox
enum Piece_Color {BLACK, WHITE}
var selected = false
var clicked = false
var released = false
var mostRecentPos : Vector2
var legal_squares = []
var NOW_DATS_STUPID = 4500

func initPiece():
	mousebox.input_event.connect(_on_mousebox_input_event)
	mostRecentPos = global_position
	
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
			if isOverlappingOppositeColor():
				capture()
			clicked = false
			selected = false
			released = true
			snapToClosestSquare()
			mostRecentPos = global_position
			parentRayCast()
			
func searchForClosestSquare():
	#now returns a position, not an Area2D
	if len(legal_squares) != 0:
		var closest_square = mostRecentPos
		for value in legal_squares:
			if position.distance_squared_to(value.position) < position.distance_squared_to(closest_square):
				closest_square = value.position
		if position.distance_squared_to(closest_square) > NOW_DATS_STUPID:
			return mostRecentPos
		return closest_square
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
	
func capture():

	var piece = mousebox.get_overlapping_areas()[0].get_parent()
	mostRecentPos = piece.mostRecentPos
	piece.queue_free()
	
func isOverlappingOppositeColor():
	var overlapping_areas = mousebox.get_overlapping_areas()
	if len(overlapping_areas) > 0:
		var overlapping_piece =  overlapping_areas[0].get_parent()
		return overlapping_piece.color != self.color
	else:
		return false


