extends Node2D

class_name Piece

@export var color : ChessColor.chess_color
@onready var movement = $Movement
@onready var mousebox : Area2D = $Mousebox
var selected = false
var clicked = false
var released = false
var hasMoved = false
var mostRecentPos : Vector2
var legal_squares = []
var NOW_DATS_STUPID = 28000
var mostRecentSquare
var RESET_WAIT_TIME = 0.2

signal finishedMovement

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
				snapToClosestSquare()
				mostRecentSquare.occupied = ChessColor.chess_color.NEITHER
				clicked = false
				selected = false
				released = true
				parentRayCast()
				setMostRecentSquare()
					
				await get_tree().create_timer(0.5).timeout
				if GameManager.gameState == GameManager.States.ILLEGAL:
					print("you can't do that! stupid butt nugget...")
					TurnManager.setTurn(self.color)
					returnToRecentPos()
					#if capturedPiece != null:
						#capturedPiece.enableMovement()
						#capturedPiece.visible = true
					#setMostRecentSquare()
				#else:
					#if capturedPiece != null:
						#capturedPiece.queue_free()	
				mostRecentPos = global_position
				
				if isOverlappingOppositeColor():
					capture()
				
				self.hasMoved = true
				
				
func searchForClosestSquare():
	#now returns a position, not an Area2D
	var closest_square
	if len(legal_squares) != 0:
		closest_square = mostRecentPos
		for value in legal_squares:
			if position.distance_squared_to(value.position) < position.distance_squared_to(closest_square):
				closest_square = value.global_position
		if position.distance_squared_to(closest_square) > NOW_DATS_STUPID:
			#print("stupid")
			#print(global_position.distance_squared_to(closest_square))
			return mostRecentPos
		else:
			if closest_square != mostRecentPos:
				TurnManager.switchTurn(self.color)
			#print("returned closest square")
			return closest_square
	else:
		#print("no legal squares")
		return mostRecentPos
		
func snapToClosestSquare():
	#print(searchForClosestSquare())
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
	#piece.disableMovement()
	#piece.visible = false
	piece.queue_free()
	self.position = piece.position
	TurnManager.switchTurn(self.color)
	
func isOverlappingOppositeColor():
	var overlapping_piece = getOverlappingPiece()
	if overlapping_piece != null:
		return overlapping_piece.color != self.color
	else:
		return false

func resetMovementComponents():
	if get_node_or_null("Movement") != null:
		if movement.get_node_or_null("HorizontalMovement") != null:
			var horizontal_movement = $Movement/HorizontalMovement
			horizontal_movement.clearProtect(self)
			horizontal_movement.objects_collide.clear()
			for ray in horizontal_movement.directions:
				ray.clear_exceptions()
				ray.collide_with_bodies = true
		
		if movement.get_node_or_null("DiagonalMovement") != null:
			var diagonal_movement = $Movement/DiagonalMovement
			diagonal_movement.clearProtect(self)
			diagonal_movement.objects_collide.clear()
			for ray in diagonal_movement.directions:
				ray.clear_exceptions()
				ray.collide_with_bodies = true
				
func setMostRecentSquare():
	var overlapping_areas = mousebox.get_overlapping_areas()
	if len(overlapping_areas) > 0:
		for area in overlapping_areas:
			if area.collision_layer == 1:
				mostRecentSquare = area
				break
		mostRecentSquare.occupied = self.color

func returnToRecentPos():
	self.position = mostRecentPos

func removeOccupiedSquares():
	if len(legal_squares) > 0:
		for square in legal_squares:
			if square.occupied == self.color:
				legal_squares.erase(square)

func disableMovement():
	remove_child(movement)

func enableMovement():
	add_child(movement)

func getOverlappingPiece():
	var overlapping_areas = mousebox.get_overlapping_areas()
	if len(overlapping_areas) > 0:
		for area in overlapping_areas: 
			if area.collision_layer == 2:
				return area.get_parent()
