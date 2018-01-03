extends KinematicBody2D

var normalPosition = Vector2()
var attackDirection = Vector2()

export var attackRadius = 150
export var attackSpeed = 1000
export var goBackSpeed = 300
export var ATTACK_TIMER = 50

var attackTimer = ATTACK_TIMER
var movementRemainder = Vector2()

var readyToAttack = true

func _ready():
	normalPosition = get_pos()
	set_process(true)

func _process(delta):
	var distanceFromNormal = normalPosition.distance_to(get_pos())

	if(attackDirection.length() > 0 && readyToAttack && distanceFromNormal < attackRadius):
		movementRemainder = move(attackSpeed * delta * attackDirection)
		
	if((distanceFromNormal >= attackRadius or movementRemainder.length() > 0) && attackTimer > 0):
		attackTimer -= 1
		readyToAttack = false
	
	if(attackTimer == 0 && distanceFromNormal > 5):
		move(goBackSpeed * delta * -attackDirection)
		
	if(attackTimer == 0 && distanceFromNormal <= 5):
		attackTimer = ATTACK_TIMER
		attackDirection = Vector2()
		readyToAttack = true
		movementRemainder = Vector2()
		
		

func _on_Area2D_body_enter( body ):
	if(body.get_name() == "Player"):
		attackDirection = (body.get_pos() - normalPosition).normalized()

