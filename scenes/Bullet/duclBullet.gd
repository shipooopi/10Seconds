extends "res://scenes/Bullet/bullet.gd"

func _ready():
	connect("body_enter", self, "_on_body_enter")
	pass
	#
	
func _on_body_enter(other):
	if(other.get_name() == "Player"):
		other._got_hit()
	if(other.get_name() != "Player" and other.get_name() != "DackelCannon"):
		queue_free()
