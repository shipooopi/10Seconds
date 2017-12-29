extends "res://scenes/Bullet/bullet.gd"

func _ready():
	connect("area_enter", self, "_on_area_enter")
	connect("body_enter", self, "_on_body_enter")
	pass
	#
	
func _on_body_enter(other):
	if(other.get_name() == "Enemy"):
		other.life -= 1
	if(other.get_name() != "Player"):
		queue_free()
	pass
