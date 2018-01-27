extends StaticBody2D

const scn_ducl = preload("res://scenes/Bullet/DuclBullet.tscn")
var timer
var position
var sprite_node

export var direction = 1

func _ready():
	sprite_node = get_node("Sprite")
	timer = get_node("Timer")
	if(direction > 0):
		sprite_node.set_flip_h(true)
		position = get_node("PositionRight")
	else:
		sprite_node.set_flip_h(false)
		position = get_node("PositionLeft")
	set_process(true)
	
	pass

func _process(delta):
	if(!timer.is_active()):
		timer.start()
		
	pass
	
func create_bullet(pos):
	var bullet = scn_ducl.instance()
	bullet.set_pos(pos)
	if(direction > 0):
		bullet.get_node("Sprite").set_flip_h(true)
	else:
		bullet.get_node("Sprite").set_flip_h(false)
	bullet.velocity = bullet.velocity * direction
	utils.main_node.add_child(bullet)
	utils.main_node.move_child(bullet, 2)
	
	
func _shoot():
	create_bullet(position.get_global_pos())

func _on_Timer_timeout():
	_shoot()
	sprite_node.set_frame(0)
	sprite_node.play("shoot")
	pass # replace with function body
