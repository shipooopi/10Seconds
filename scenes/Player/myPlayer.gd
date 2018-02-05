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
export var MAX_BLINK_COUNTER = 3
export var MAX_INVIS_TIMER = 20

# Constants
export var MAX_SPEED = 900
export var ACCELERATION = 3500
export var DECELERATION = 6000
export var SPEED_DIVISOR = 7

export var JUMP_FORCE = 2000
export var RELEASED_JUMP_FORCE = 800
export var GRAVITY = 6000
export var MAX_FALL_SPEED = 1000

export var JUMP_FORCE_WATER = 400
export var RELEASED_JUMP_FORCE_WATER = 150
export var GRAVITY_WATER = 1250
export var MAX_FALL_SPEED_WATER = 500
# TODO: set to var to change on runtime
export var MAX_JUMP_COUNT = 2

const scn_bullet = preload("res://scenes/Bullet/BulletTest.tscn")
const scn_youDead = preload("res://scenes/YouDead/YouDead.tscn")
const scn_freeze = preload("res://scenes/Freeze/Freeze.tscn")
const scn_hit = preload("res://scenes/GotHit/GotHit.tscn")

var freeze_screen
var freeze_screen_path

var start_life = [1,2,3,4]
var life = 0 setget set_life

var time_freeze_time_array = [0,30,60,90]
var time_freeze_time = 0
var time_freeze_used = false

var damage = 0
var damage_Array = [0,2,3,6]

var playerInsideEnemy = false
var inWater = false

var state = "idle"

signal time_freeze
signal time_freeze_end

var shoot_timer
const SHOOT_TIMER_MAX = 3

var got_skills = false

func _ready():
	Globals.set("gameOver", false)
	set_process(true)
	set_process_input(true)
	sprite_node = get_node("Sprite")
	shoot_timer = SHOOT_TIMER_MAX
	
	
func create_bullet(pos):
	var bullet = scn_bullet.instance()
	bullet.set_pos(pos)
	if(direction > 0):
		bullet.get_node("AnimatedSprite").set_flip_h(false)
	else:
		bullet.get_node("AnimatedSprite").set_flip_h(true)
	bullet.velocity = bullet.velocity * direction
	bullet.damage = damage
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
			state = "jump"
			speed.y = -JUMP_FORCE_WATER
		if (event.is_action_released("jump") and speed.y < -RELEASED_JUMP_FORCE_WATER):
			speed.y = -RELEASED_JUMP_FORCE_WATER
	else:		
		if (jump_count < MAX_JUMP_COUNT and event.is_action_pressed("jump")):
			state = "jump"
			speed.y = -JUMP_FORCE
			jump_count += 1
		if (jump_count > 0 and event.is_action_released("jump") and speed.y < -RELEASED_JUMP_FORCE):
			speed.y = -RELEASED_JUMP_FORCE

	if(time_freeze_time > 0 and event.is_action_pressed("time_freeze") and not time_freeze_used):
		emit_signal("time_freeze")
		time_freeze_used = true
		freeze_screen = scn_freeze.instance()
		utils.main_node.add_child(freeze_screen)
		freeze_screen_path = freeze_screen.get_path()

			
	if (event.is_action_pressed("shoot") && damage > 0):
		shoot()
		state = "shoot"
 
func _process(delta):
	if(not got_skills):
		set_life(start_life[SaveFile._get_save_dictionary()["progress"]["life"]])
		time_freeze_time = time_freeze_time_array[SaveFile._get_save_dictionary()["progress"]["magic"]]
		damage = damage_Array[SaveFile._get_save_dictionary()["progress"]["attack"]]
		got_skills = true

	if input_direction:
		direction = input_direction

	if Input.is_action_pressed("move_left"):
		input_direction = -1
		sprite_node.set_flip_h(true)
		if(state != "jump" && state != "shoot"):
			state = "running"
	elif Input.is_action_pressed("move_right"):
		input_direction = 1
		sprite_node.set_flip_h(false)
		if(state != "jump" && state != "shoot"):
			state = "running"
	else:
		input_direction = 0
		if(state != "jump" && state != "shoot"):
			state = "idle"
	

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
	
	if(speed.y > 0 && floor(movement_remainder.y) != floor(velocity.y)):
		state = "fall"
	
	if(((is_colliding() && get_collider().get_collision_mask() in [4, 8]) or got_hit) && invis_timer <= 0):
		var hit = scn_hit.instance()
		utils.main_node.add_child(hit)
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
		if(invis_timer % 15 == 0):
			blink_counter = MAX_BLINK_COUNTER
			get_node("Sprite").hide()
		invis_timer -= 1
	if(blink_counter > 0):
		blink_counter -= 1
	else:
		get_node("Sprite").show()
		
	if((playerInsideEnemy || inWater) && invis_timer <= 0):
		_got_hit()
		
	if(time_freeze_used):
		if(time_freeze_time > 0):
			time_freeze_time -= 1
		elif(time_freeze_time <= 0):
			emit_signal("time_freeze_end")
			if(utils.main_node.has_node(freeze_screen_path)):
				freeze_screen.queue_free()
			
	if(state == "idle"):
		sprite_node.play("idle")
	elif(state == "running"):
		sprite_node.play("running")
	elif(state == "jump"):
		sprite_node.play("jump")
	elif(state == "fall"):
		sprite_node.play("fall")
	elif(state == "shoot"):
		sprite_node.play("shoot")
		if(sprite_node.get_frame() == 1):
			shoot_timer -= 1
		if(shoot_timer <= 0):
			state  = "notShoot"
			shoot_timer = SHOOT_TIMER_MAX
		
func set_life(new_value):
	life = new_value
	if(life <= 0):
		get_tree().set_pause(true)
		var youDead = scn_youDead.instance()
		utils.main_node.add_child(youDead)
		Globals.set("gameOver", true)
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
		_in_water()

func _on_Water_body_exit( body ):
	if(body.get_name() == "Player"):
		_out_water()


func _on_DuclBullet_body_enter( body ):
	if(body.get_name() == "Player"):
		if(!got_hit):
			_got_hit()

func _in_water():
	inWater = true
	_got_hit()
	
func _out_water():
	inWater = false

