# script: utils

extends Node

func _ready():
	get_tree().get_root().set_pause_mode(2)
	set_process(true)
	
func _process(delta):
	if Input.is_action_pressed("End"):
		get_tree().quit()
	if Input.is_action_pressed("Restart"):
		get_tree().set_pause(false)
		get_tree().reload_current_scene()