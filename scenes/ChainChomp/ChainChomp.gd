extends KinematicBody2D

var normalPosition = Vector2()
var attackDirection = Vector2()

export var attackRadius = 150
export var attackSpeed = 1000
export var goBackSpeed = 300
export var ATTACK_TIMER = 50

var attackTimer = ATTACK_TIMER
var movementRemainder = Vector2()
var distanceFromNormal = 0

var readyToAttack = true

var playerInside = false

var playerObject

var chainItemSprite1
var chainItemSprite2
var chainItemSprite3
var chainItemSprite4
var chainItemSprite5
var chainItemSprite6
var chainItemSprite7
var chainItemSprite8
var sprite

var state = "idle"

const scn_pflock = preload("res://scenes/Pflock/Pflock.tscn")
var pflock
var pflockDrawn = false

export var life = 9 setget set_life

func _ready():
	chainItemSprite1 = get_node("chainItem1")
	chainItemSprite2 = get_node("chainItem2")
	chainItemSprite3 = get_node("chainItem3")
	chainItemSprite4 = get_node("chainItem4")
	chainItemSprite5 = get_node("chainItem5")
	chainItemSprite6 = get_node("chainItem6")
	chainItemSprite7 = get_node("chainItem7")
	chainItemSprite8 = get_node("chainItem8")
	sprite = get_node("Sprite")

	normalPosition = get_pos()
	pflock = scn_pflock.instance()
	pflock.set_pos(Vector2(normalPosition.x, normalPosition.y))
	set_process(true)


func _process(delta):
	if(!pflockDrawn):
		utils.main_node.add_child(pflock)
		utils.main_node.move_child(pflock, get_index() - 1)
		pflockDrawn = true

	distanceFromNormal = normalPosition.distance_to(get_pos())

	chainItemSprite1.set_pos((normalPosition - get_pos()) * 0.9)
	chainItemSprite2.set_pos((normalPosition - get_pos()) * 0.8)
	chainItemSprite3.set_pos((normalPosition - get_pos()) * 0.7)
	chainItemSprite4.set_pos((normalPosition - get_pos()) * 0.6)
	chainItemSprite5.set_pos((normalPosition - get_pos()) * 0.5)
	chainItemSprite6.set_pos((normalPosition - get_pos()) * 0.4)
	chainItemSprite7.set_pos((normalPosition - get_pos()) * 0.3)
	chainItemSprite8.set_pos((normalPosition - get_pos()) * 0.2)
	

	if(attackDirection.length() > 0 && readyToAttack && distanceFromNormal < attackRadius):
		sprite.stop()
		state = "attack"
		movementRemainder = move(attackSpeed * delta * attackDirection)
		if(playerObject.get_pos().x < normalPosition.x):
			sprite.set_flip_h(true)
		else:
			sprite.set_flip_h(false)
		
	if((distanceFromNormal >= attackRadius or movementRemainder.length() > 0) && attackTimer > 0):
		if(state == "attack"):
			sprite.play("bite")
			state = "justAttacked"
		attackTimer -= 1
		readyToAttack = false
	
	if(attackTimer == 0):
		if(state == "justAttacked" ):
			sprite.stop()
			state = "idle"
		if(distanceFromNormal <= 3):
			attackTimer = ATTACK_TIMER
			attackDirection = Vector2()
			readyToAttack = true
			movementRemainder = Vector2()
			if(state == "idle"):
				sprite.play("idle")
		else:
			move(goBackSpeed * delta * (normalPosition - get_pos()).normalized())
		
	if(attackTimer == ATTACK_TIMER && distanceFromNormal <= 3 && playerInside):
		attackDirection = (playerObject.get_pos() - normalPosition).normalized()


func _on_Area2D_body_enter( body ):
	if(body.get_name() == "Player"):
		if(playerObject == null):
			playerObject = body
		playerInside = true

func _on_Area2D_body_exit( body ):
	playerInside = false
	pass # replace with function body
	
func set_life(new_value):
	life = new_value
	if(life <= 0):
		queue_free()
