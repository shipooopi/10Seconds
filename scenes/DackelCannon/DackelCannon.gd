extends StaticBody2D

const scn_ducl = preload("res://scenes/Bullet/DuclBullet.tscn")
var timer
var position

export var direction = 1

func _ready():
	timer = get_node("Timer")
	if(direction > 0):
		position = get_node("PositionRight")
	else:
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
	bullet.velocity = bullet.velocity * direction
	utils.main_node.add_child(bullet)
	
func _shoot():
	create_bullet(position.get_global_pos())

func _on_Timer_timeout():
	_shoot()
	pass # replace with function body
