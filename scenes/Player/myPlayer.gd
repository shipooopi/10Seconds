extends KinematicBody2D

# Variables
var sprite_node
var animation_player

var input_direction = 0
var direction = 1

var speed = Vector2()
var velocity = Vector2()

var jump_count = 0

var got_hit = false
var invis_timer = 0
var blink_counter = 0
export var MAX_BLINK_COUNTER = 5
export var MAX_INVIS_TIMER = 100

# Constants
export var MAX_SPEED = 900
export var ACCELERATION = 3500
export var DECELERATION = 6000
export var SPEED_DIVISOR = 7

export var JUMP_FORCE = 2000
export var RELEASED_JUMP_FORCE = 800
export var GRAVITY = 6000
export var MAX_FALL_SPEED = 1400

export var JUMP_FORCE_WATER = 400
export var RELEASED_JUMP_FORCE_WATER = 150
export var GRAVITY_WATER = 1250
export var MAX_FALL_SPEED_WATER = 700
# TODO: set to var to change on runtime
export var MAX_JUMP_COUNT = 2

const scn_bullet = preload("res://scenes/Bullet/playerBullet.tscn")

var start_life = [1,2,3]
var life setget set_life

var playerInsideEnemy = false
var inWater = false

func _ready():
	set_process(true)
	set_process_input(true)
	sprite_node = get_node("Sprite")
	animation_player = get_node("/root/World/AnimationPlayer")
	set_life(start_life[SaveFile._get_save_dictionary()["progress"]["life"]])
	#animation_player.play("Idle")
	
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
	if (inWater):
		if (event.is_action_pressed("jump")):
			speed.y = -JUMP_FORCE_WATER
		if (event.is_action_released("jump") and speed.y < -RELEASED_JUMP_FORCE_WATER):
			speed.y = -RELEASED_JUMP_FORCE_WATER
	else:		
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
	
	if(inWater):
		speed.y += GRAVITY_WATER * delta
		if (speed.y > MAX_FALL_SPEED_WATER):
			speed.y = MAX_FALL_SPEED_WATER
	else:
		speed.y += GRAVITY * delta
		if (speed.y > MAX_FALL_SPEED):
			speed.y = MAX_FALL_SPEED
		
	velocity.x = speed.x * delta * direction
	velocity.y = speed.y * delta
	
	var movement_remainder = move(velocity)
	
	if(((is_colliding() && get_collider().get_collision_mask() in [4, 8]) or got_hit) && invis_timer <= 0):
		set_life(life - 1)
		got_hit = false
		invis_timer = MAX_INVIS_TIMER
	
	if (is_colliding()):
		var normal = get_collision_normal()
		var final_movement = normal.slide(movement_remainder)
		speed.y = normal.slide(Vector2(0,speed.y)).y
		
		move(final_movement)
		
		if (normal.y <= -0.7):
			jump_count = 0
	
	if( (not is_colliding() or get_collision_normal().y > -0.7) && speed.y > 0 && jump_count == 0):
		# Todo: ghost jump
		jump_count += 1
	
	if(invis_timer > 0):
		if(invis_timer % 20 == 0):
			blink_counter = MAX_BLINK_COUNTER
			get_node("Sprite").hide()
		invis_timer -= 1
	if(blink_counter > 0):
		blink_counter -= 1
	else:
		get_node("Sprite").show()
		
	if(playerInsideEnemy && invis_timer <= 0):
		_got_hit()
		
func set_life(new_value):
	life = new_value
	if(life <= 0):
		get_tree().reload_current_scene()
		print("DIED!")
	pass

func _got_hit():
	if(invis_timer <= 0):
		got_hit = true

func _on_Area2D_body_enter( body ):
	if(body.get_name() == "Player"):
		playerInsideEnemy = true
		if(!got_hit):
			_got_hit()

func _on_Hitbox_body_enter( body ):
	if(body.get_name() == "Player"):
		playerInsideEnemy = true
		if(!got_hit):
			_got_hit()

func _on_Hitbox_body_exit( body ):
	if(body.get_name() == "Player"):
		playerInsideEnemy = false


func _on_Area2D_body_exit( body ):
	if(body.get_name() == "Player"):
		playerInsideEnemy = false

func _on_Area2DFlip_body_enter( body ):
	if(body.get_name() == "Player"):
		playerInsideEnemy = true
		if(!got_hit):
			_got_hit()


func _on_Area2DFlip_body_exit( body ):
	if(body.get_name() == "Player"):
		playerInsideEnemy = false


func _on_Water_body_enter( body ):
	if(body.get_name() == "Player"):
		inWater = true
		_got_hit()

func _on_Water_body_exit( body ):
	if(body.get_name() == "Player"):
		inWater = false
