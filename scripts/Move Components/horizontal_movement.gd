extends Movement

class_name HorizontalMovement

var up = RayCast2D.new()
var down = RayCast2D.new()
var left = RayCast2D.new()
var right = RayCast2D.new()

func _ready():
	directions = [up, down, left, right]
	initRays()
	castRays(maxRayDistance)
	
func _physics_process(_delta):
	getAllObjects()
	
func castRays(maxDistance):
	add_child(up)
	add_child(down)
	add_child(left)
	add_child(right)
	up.target_position = Vector2.UP * maxDistance
	down.target_position = Vector2.DOWN * maxDistance	
	left.target_position = Vector2.LEFT * maxDistance	
	right.target_position = Vector2.RIGHT * maxDistance	


