extends KinematicBody2D

# Variables
var sprite_node
var animation_player
var rayCastDownRight
var rayCastDownLeft
var rayCastRight
var rayCastLeft

var direction = 1
var justChangedDirections = false

var speed = Vector2()
var velocity = Vector2()

var got_hit = false

# Constants
export var MAX_SPEED_WALK = 200
export var MAX_SPEED_SRINT = 700
export var ACCELERATION = 1000
export var SPEED_DIVISOR = 7

export var JUMP_FORCE = 2000
var jumpPossible = true

export var GRAVITY = 6000

var start_life = [1,2,3]
var life setget set_life

func _ready():
	set_process(true)
	sprite_node = get_node("Sprite")
	rayCastDownRight = get_node("RayCastDownRight")
	rayCastDownLeft = get_node("RayCastDownLeft")
	rayCastRight = get_node("RayCastRight")
	rayCastLeft = get_node("RayCastLeft")
	#animation_player = get_node("/root/World/AnimationPlayer")
	#set_life(start_life[SaveFile._get_save_dictionary()["progress"]["life"]])
	#animation_player.play("Idle")
 
 
func _process(delta):
	#		speed.y = -JUMP_FORCE

	if direction == 1:
		sprite_node.set_flip_h(true)
		rayCastRight.set_enabled(false)
		rayCastDownRight.set_enabled(true)
		rayCastLeft.set_enabled(false)
		rayCastDownLeft.set_enabled(false)
	elif direction == -1:
		sprite_node.set_flip_h(false)
		rayCastRight.set_enabled(false)
		rayCastDownRight.set_enabled(false)
		rayCastLeft.set_enabled(true)
		rayCastDownLeft.set_enabled(false)

	if((rayCastDownRight.is_enabled() && !rayCastDownRight.is_colliding()) || 
	(rayCastDownLeft.is_enabled() && !rayCastDownLeft.is_colliding()) || 
	(rayCastRight.is_enabled() && rayCastRight.is_colliding() && rayCastRight.get_collider().get_name() != "Player") ||
	(rayCastLeft.is_enabled() && rayCastLeft.is_colliding() && rayCastLeft.get_collider().get_name() != "Player")):
		direction = direction * -1

	print(str(direction))
	# MOVEMENT
	if justChangedDirections:
		speed.x /= SPEED_DIVISOR
		justChangedDirections = false

	speed.x += ACCELERATION * delta
		
	speed.x = clamp(speed.x, 0, MAX_SPEED_WALK)
	
	speed.y += GRAVITY * delta
		
	velocity.x = speed.x * delta * direction
	velocity.y = speed.y * delta
	
	var movement_remainder = move(velocity)
	
	if (is_colliding()):
		var normal = get_collision_normal()
		var final_movement = normal.slide(movement_remainder)
		speed.y = normal.slide(Vector2(0,speed.y)).y
		
		move(final_movement)
		
		if (normal.y <= -0.7):
			jumpPossible = true
	
	if( (not is_colliding() or get_collision_normal().y > -0.7) && speed.y > 0):
		# Todo: ghost jump
		jumpPossible = false 
		
func set_life(new_value):
	life = new_value
	if(life <= 0):
		get_tree().reload_current_scene()
		print("DIED!")
	pass

func _got_hit():
	#if(invis_timer <= 0):
	#	got_hit = true
	pass