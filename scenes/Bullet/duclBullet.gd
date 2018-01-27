extends KinematicBody2D

export var life = 3 setget set_life
var sprite_node
var collision_node
var playDeath = false
var playDeathTimer = 30
var cannon

export var velocity = Vector2()


func _ready():

	sprite_node = get_node("Sprite")#
	collision_node = get_node("Area2D/CollisionShape2D")
	set_process(true)
	pass
	
func _process(delta):
	translate(velocity * delta)
	if(playDeath):
		playDeathTimer -= 1
		if(playDeathTimer == 0):
			queue_free()
	
func _on_Area2D_body_enter( other ):
	if (cannon == null):
		cannon = other
	if(other.get_name() == "Player" and not playDeath):
		other._got_hit()
	if(other.get_name() != "Player" and other != cannon and 
		not ((other.get_collision_mask_bit(6) and velocity.normalized().x == -1) 
		or (other.get_collision_mask_bit(7) and velocity.normalized().x == 1))):
		if(velocity.normalized().x < 0):
			set_pos(Vector2(get_global_pos().x + 8, get_global_pos().y))
		else:
			set_pos(Vector2(get_global_pos().x - 8, get_global_pos().y))
		sprite_node.play("death")
		get_node("Area2D").set_scale(Vector2(0,0))
		playDeath = true
		velocity.x = 0

func set_life(new_value):
	life = new_value
	if(life <= 0):
		queue_free()
		
func _on_time_freeze():
	set_process(false)
	sprite_node.set_process(false)

func _on_time_freeze_end():
	set_process(true)
	sprite_node.set_process(true)
		
