extends KinematicBody2D

# Variables
var sprite_node
var area_node
var areaFlip_node
var animation_player

var input_direction = 0
var direction = 1
var lastDistanceToA = 100000
var lastDistanceToB = 100000

var speed = 0
var velocity = 0

export var pointA = Vector2()
export var pointB = Vector2()
var directionToA = Vector2()

var reachedPointA = false
var changedPointRightNow = false

# Constants
export var MAX_SPEED = 450
export var ACCELERATION = 500
export var DECELERATION = 400
export var DECELERATION_DISTANCE = 275
export var SPEED_DIVISOR = 5

export var life = 3 setget set_life

signal hit_the_player

func _ready():
	set_process(true)
	sprite_node = get_node("Sprite")
	area_node = get_node("Area2D")
	areaFlip_node = get_node("Area2DFlip")
	directionToA.x = pointA.x - pointB.x
	directionToA.y = pointA.y - pointB.y
	for index in range(get_parent().get_children().size()):
		var node = get_parent().get_child(index)
		if(node.get_name() == "Player"):
			connect("hit_the_player", node, "_got_hit")
	
	
 
func _process(delta):

	# MOVEMENT
	#if changedPointRightNow:
	#	speed /= SPEED_DIVISOR
	#	changedPointRightNow = false
	
#	if((get_pos().distance_to(pointA) < (DECELERATION_DISTANCE) and !reachedPointA) or 
#	(get_pos().distance_to(pointB) < (DECELERATION_DISTANCE) and reachedPointA)):
#		speed -= DECELERATION * delta
#	else:
#		speed += ACCELERATION * delta
#	speed = clamp(speed, 0, MAX_SPEED)
#		
#	velocity = speed * delta * directionToA.normalized()
#	
#	if get_pos().distance_to(pointA) < lastDistanceToA and !reachedPointA:
#		lastDistanceToA = get_pos().distance_to(pointA)
#		var movement_remainder = move(velocity)
#	elif get_pos().distance_to(pointA) >= lastDistanceToA and !reachedPointA:
#		reachedPointA = true
#		lastDistanceToB = 100000
#		changedPointRightNow = true
#		sprite_node.set_flip_h(false)
#	elif get_pos().distance_to(pointB) < lastDistanceToB and reachedPointA:
#		lastDistanceToB = get_pos().distance_to(pointB)
#		var movement_remainder = move(-velocity)
#	elif get_pos().distance_to(pointB) >= lastDistanceToB and reachedPointA:
#		reachedPointA = false
#		lastDistanceToA = 100000
#		changedPointRightNow = true
#		sprite_node.set_flip_h(true)

	if(sprite_node.is_flipped_h()):
		area_node.set_scale(Vector2(1,1))
		areaFlip_node.set_scale(Vector2(0,0))
	elif(!sprite_node.is_flipped_h()):
		area_node.set_scale(Vector2(0,0))
		areaFlip_node.set_scale(Vector2(1,1))

	
	if (is_colliding()):
		if(get_collider().get_name() == "Player"):
			#get_tree().reload_current_scene()
			emit_signal("hit_the_player")
			
func set_life(new_value):
	life = new_value
	if(life <= 0):
		queue_free()