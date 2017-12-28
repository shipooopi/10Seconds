extends KinematicBody2D

# Variables
var sprite_node
var animation_player

var input_direction = 0
var direction = 1

var speed = Vector2()
var velocity = Vector2()

var jump_count = 0

# Constants
const MAX_SPEED = 900
const ACCELERATION = 3500
const DECELERATION = 6000
const SPEED_DIVISOR = 7

const JUMP_FORCE = 2000
const RELEASED_JUMP_FORCE = 800
const GRAVITY = 6000
const MAX_FALL_SPEED = 1400
# TODO: set to var to change on runtime
const MAX_JUMP_COUNT = 2

const scn_bullet = preload("res://scenes/Bullet/playerBullet.tscn")

func _ready():
	set_process(true)
	set_process_input(true)
	sprite_node = get_node("Sprite")
	animation_player = get_node("/root/World/AnimationPlayer")
	animation_player.play("Idle")
	
func create_bullet(pos):
	var bullet = scn_bullet.instance()
	bullet.set_pos(pos)
	bullet.velocity = bullet.velocity * direction
	utils.main_node.add_child(bullet)
	
func shoot():
	var cannonPos
	if(direction > 0):
		cannonPos = get_node("cannon/right").get_global_pos()
	else:
		cannonPos = get_node("cannon/left").get_global_pos()
	create_bullet(cannonPos)

func _input(event):
	if (jump_count < MAX_JUMP_COUNT and event.is_action_pressed("jump")):
		speed.y = -JUMP_FORCE
		jump_count += 1
	if (jump_count > 0 and event.is_action_released("jump") and speed.y < -RELEASED_JUMP_FORCE):
		speed.y = -RELEASED_JUMP_FORCE
		
	if (event.is_action_pressed("shoot")):
		shoot()
 
 
func _process(delta):
	# INPUT
	if Input.is_action_pressed("Restart"):
		get_tree().reload_current_scene()
	
	if input_direction:
		direction = input_direction

	if Input.is_action_pressed("move_left"):
		input_direction = -1
		sprite_node.set_flip_h(true)
	elif Input.is_action_pressed("move_right"):
		input_direction = 1
		sprite_node.set_flip_h(false)
	else:
		input_direction = 0
	
	

	# MOVEMENT
	if input_direction == - direction:
		speed.x /= SPEED_DIVISOR

	if (input_direction):
		speed.x += ACCELERATION * delta
	else:
		speed.x -= DECELERATION * delta
		
	speed.x = clamp(speed.x, 0, MAX_SPEED)
	
	speed.y += GRAVITY * delta
	if (speed.y > MAX_FALL_SPEED):
		speed.y = MAX_FALL_SPEED
		
	velocity.x = speed.x * delta * direction
	velocity.y = speed.y * delta
	
	var movement_remainder = move(velocity)
	
	if (is_colliding()):
		if(get_collider().get_collision_mask() in [4, 8]):
			get_tree().reload_current_scene()
			
		var normal = get_collision_normal()
		var final_movement = normal.slide(movement_remainder)
		speed.y = normal.slide(Vector2(0,speed.y)).y
		
		move(final_movement)
		
		if (normal.y <= -0.7):
			jump_count = 0
	
	if( (not is_colliding() or get_collision_normal().y > -0.7) && speed.y > 0 && jump_count == 0):
		# Todo: ghost jump
		jump_count += 1
		
	
