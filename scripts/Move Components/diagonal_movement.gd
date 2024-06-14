extends Movement

class_name DiagonalMovement

var upRight = RayCast2D.new()
var upLeft = RayCast2D.new()
var downLeft = RayCast2D.new()
var downRight = RayCast2D.new()

func _ready():
	initRays()
	directions = [upRight, upLeft, downLeft, downRight]

func castRays(upRight, upLeft, downLeft, downRight, maxRayDistance):
	add_child(upRight)
	add_child(upLeft)
	add_child(downLeft)
	add_child(downRight)
	upRight.target_position = Vector2.UP.rotated(45) * maxRayDistance
	upLeft.target_position = Vector2.UP.rotated(-45) * maxRayDistance	
	downLeft.target_position = Vector2.DOWN.rotated(-45) * maxRayDistance	
	downRight.target_position = Vector2.DOWN.rotated(45) * maxRayDistance	
