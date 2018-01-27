extends KinematicBody2D

export var velocity = Vector2()
var damage setget set_damage
	
func _ready():
	set_process(true)
	pass
	#
func _process(delta):
	translate(velocity * delta)
	pass
	

func _on_bullet_area_enter( area ):
	print(str(area.get_collision_mask()))
	if(area.get_collision_mask_bit(2) == true):
		if(area.get("life") != null):
			area.life -= damage
		elif(area.get_parent().get("life") != null):
			area.get_parent().life -= damage
		queue_free()


func _on_bullet_body_enter( body ):
	if(body.get_name() != "Player"):
		if(not ((body.get_collision_mask_bit(6) and velocity.normalized().x == -1) 
			or (body.get_collision_mask_bit(7) and velocity.normalized().x == 1))):
			queue_free()
	pass

func set_damage(new_value):
	damage = new_value
