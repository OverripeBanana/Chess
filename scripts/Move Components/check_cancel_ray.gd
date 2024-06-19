extends RayCastMovement

class_name CheckCancel

var king

func _ready():
	initRays(self)
	king = self.get_parent().get_parent()

func _process(_delta):
	if len(king.attackers) == 1:
		self.enabled = true
		var attacker = king.attackers[0]
		self.target_position = attacker.global_position - self.global_position
		getAllObjects(self)
		print(objects_collide)
	else:
		self.enabled = false
