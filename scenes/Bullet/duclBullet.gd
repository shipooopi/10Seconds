extends "res://scenes/Bullet/bullet.gd"

export var life = 3 setget set_life


func _ready():
	connect("body_enter", self, "_on_body_enter")
	pass
	#
	
func _on_body_enter(other):
	if(other.get_name() == "Player"):
		other._got_hit()
	if(other.get_name() != "Player" and other.get_name() != "DackelCannon" and 
		not ((other.get_collision_mask_bit(6) and velocity.normalized().x == -1) 
		or (other.get_collision_mask_bit(7) and velocity.normalized().x == 1))):
		queue_free()

func set_life(new_value):
	life = new_value
	if(life <= 0):
		queue_free()
		
