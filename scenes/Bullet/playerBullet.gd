extends KinematicBody2D

export var velocity = Vector2()

	
func _ready():
	set_process(true)
	pass
	#
func _process(delta):
	translate(velocity * delta)
	pass
	
#func _on_body_enter(other):
#	if(other.get_name() != "Player"):
#		queue_free()
#	pass
#	
#func _on_area_enter(other):
#	if(other.get_collision_mask() == 4):
#		other.life -= 1
#		queue_free()

func _on_bullet_area_enter( area ):
	if(area.get_collision_mask() == 4):
#		other.life -= 1
		queue_free()


func _on_bullet_body_enter( body ):
	if(body.get_name() != "Player"):
		queue_free()
	pass
