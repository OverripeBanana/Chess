extends Node2D

class_name Piece

@export var color : ChessColor.chess_color
@onready var movement = $Movement
@onready var mousebox : Area2D = $Mousebox
var selected = false
var clicked = false
var released = false
var mostRecentPos : Vector2
var legal_squares = []
var NOW_DATS_STUPID = 6000
var mostRecentSquare

func initPiece():
	mousebox.input_event.connect(_on_mousebox_input_event)
	mostRecentPos = global_position
	
func move():
	if selected:
		followMouse()

func _on_mousebox_input_event(_viewport, event, _shape_idx):
		if event is InputEventMouseButton:
			if event.pressed and self.color == TurnManager.currentTurn:
				unparentRayCast()
				selected = true
				clicked = true
				released = false
			if !event.pressed and clicked:
				
				if isOverlappingOppositeColor():
					capture()
				else:	
					snapToClosestSquare()
				
				mostRecentSquare.occupied = ChessColor.chess_color.NEITHER
				clicked = false
				selected = false
				released = true
				parentRayCast()
				setMostRecentSquare()
				
				await get_tree().create_timer(0.2).timeout
				if GameManager.gameState == GameManager.States.ILLEGAL:
					print("you can't do that! stupid butt nugget...")
					TurnManager.setTurn(self.color)
					returnToRecentPos()
					setMostRecentSquare()
					
				mostRecentPos = global_position
				
					
func searchForClosestSquare():
	#now returns a position, not an Area2D
	if len(legal_squares) != 0:
		var closest_square = mostRecentPos
		for value in legal_squares:
			if is_instance_valid(value):
				if position.distance_squared_to(value.position) < position.distance_squared_to(closest_square):
					closest_square = value.position
		if position.distance_squared_to(closest_square) > NOW_DATS_STUPID:
			return mostRecentPos
		else:
			if closest_square != mostRecentPos:
				TurnManager.switchTurn()
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
	var piece
	for area in mousebox.get_overlapping_areas():
		if area.collision_layer == 2:
			piece = area.get_parent()
			break
	piece.resetMovementComponents()
	piece.queue_free()
	self.position = piece.position
	#piece.call_deferred("resetMovementComponents")
	TurnManager.switchTurn()
	
func isOverlappingOppositeColor():
	var overlapping_areas = mousebox.get_overlapping_areas()
	var overlapping_piece
	if len(overlapping_areas) > 0:
		for area in overlapping_areas: 
			if area.collision_layer == 2:
				overlapping_piece = area
				break
		if overlapping_piece != null:
			return overlapping_piece.get_parent().color != self.color
		else:
			return false
	else:
		return false

func resetMovementComponents():
	if $Movement/HorizontalMovement != null:
		var horizontal_movement = $Movement/HorizontalMovement
		horizontal_movement.clearProtect(self)
		horizontal_movement.objects_collide.clear()
		for ray in horizontal_movement.directions:
			ray.clear_exceptions()
		
	if $Movement/DiagonalMovement != null:
		var diagonal_movement = $Movement/DiagonalMovement
		diagonal_movement.clearProtect(self)
		diagonal_movement.objects_collide.clear()
		for ray in diagonal_movement.directions:
			ray.clear_exceptions()

func setMostRecentSquare():
	var overlapping_areas = mousebox.get_overlapping_areas()
	if len(overlapping_areas) > 0:
		for area in overlapping_areas:
			if area.collision_layer == 1:
				mostRecentSquare = area
				break
		mostRecentSquare.occupied = self.color

func inCheck():
	if self.color == ChessColor.chess_color.BLACK:
		return Check.blackInCheck
	elif self.color == ChessColor.chess_color.WHITE:
		return Check.whiteInCheck

func returnToRecentPos():
	self.position = mostRecentPos

func removeOccupiedSquares():
	if len(legal_squares) > 0:
		for square in legal_squares:
			if square.occupied == self.color:
				legal_squares.erase(square)
