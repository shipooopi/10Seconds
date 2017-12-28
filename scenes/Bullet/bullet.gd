extends Area2D

export var velocity = Vector2()
const scn_flare = preload("res://scenes/Flare/Flare.tscn")
func _ready():
	set_process(true)
	create_flare()
	
	yield(get_node("visNotifier"), "exit_screen")
	queue_free()
	
func _process(delta):
	translate(velocity * delta)


func create_flare():
	var flare = scn_flare.instance()
	flare.set_pos(get_pos())
	utils.main_node.add_child(flare)