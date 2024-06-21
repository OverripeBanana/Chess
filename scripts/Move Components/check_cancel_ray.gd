extends RayCastMovement

class_name CheckCancel

var king

func _ready():
	initRays(self)
	king = self.get_parent().get_parent()

func _process(_delta):
	if Input.is_action_just_released("left_click"):
		objects_collide.clear()
	if len(king.attackers) == 1:
		self.enabled = true
		var attacker = king.attackers[0]
		self.target_position = attacker.global_position - self.global_position
		self.position = self.target_position * 0.1
		getAllObjects(self)
		#for square in objects_collide:
			#square.color_rect.color = Color(0, 0, 1, 1)
	else:
		self.enabled = false
		objects_collide.clear()
	updateGlobally()
	#print(Check.whiteCancelCheckSquares)
	#print(objects_collide)
	
func updateGlobally():
	if king.color == ChessColor.chess_color.BLACK:
		Check.blackCancelCheckSquares = objects_collide
	if king.color == ChessColor.chess_color.WHITE:	
		Check.whiteCancelCheckSquares = objects_collide
		
		
		
		
