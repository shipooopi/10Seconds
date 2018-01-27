extends StaticBody2D

const scn_ducl = preload("res://scenes/Bullet/DuclBullet.tscn")
var timer
var position
var sprite_node

signal time_freeze
signal time_freeze_end

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
	utils.main_node.move_child(bullet, utils.main_node.get_node("BackgroundSeperator").get_index() + 1)
	connect("time_freeze", bullet, "_on_time_freeze")
	connect("time_freeze_end", bullet, "_on_time_freeze_end")
	
	
func _shoot():
	create_bullet(position.get_global_pos())

func _on_Timer_timeout():
	_shoot()
	sprite_node.set_frame(0)
	sprite_node.play("shoot")
	pass # replace with function body


func _on_Player_time_freeze():
	set_process(false)
	sprite_node.set_process(false)
	timer.set_process(false)
	emit_signal("time_freeze")


func _on_Player_time_freeze_end():
	set_process(true)
	sprite_node.set_process(true)
	timer.set_process(true)
	emit_signal("time_freeze_end")
