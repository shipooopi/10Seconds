extends KinematicBody2D

# Variables
var sprite_node
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
const MAX_SPEED = 900
const ACCELERATION = 3500
const DECELERATION = 6000
const SPEED_DIVISOR = 7

func _ready():
	set_process(true)
	sprite_node = get_node("Sprite")
	directionToA = pointA - pointB
 
func _process(delta):

	# MOVEMENT
	if changedPointRightNow:
		speed /= SPEED_DIVISOR

	speed += ACCELERATION * delta
	speed = clamp(speed, 0, MAX_SPEED)
		
	velocity = speed * delta * directionToA.normalized()
	
	if get_pos().distance_to(pointA) < lastDistanceToA and !reachedPointA:
		lastDistanceToA = get_pos().distance_to(pointA)
		var movement_remainder = move(velocity)
	elif get_pos().distance_to(pointA) >= lastDistanceToA and !reachedPointA:
		reachedPointA = true
		lastDistanceToB = 100000
	elif get_pos().distance_to(pointB) < lastDistanceToB and reachedPointA:
		lastDistanceToB = get_pos().distance_to(pointB)
		var movement_remainder = move(-velocity)
	elif get_pos().distance_to(pointB) >= lastDistanceToB and reachedPointA:	#
		reachedPointA = false
		lastDistanceToA = 100000
		
	if (is_colliding()):
		if(get_collider().get_name() == "Player"):
			get_tree().reload_current_scene()