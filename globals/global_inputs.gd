# script: utils

extends Node

func _ready():
	set_process(true)
	
func _process(delta):
	if Input.is_action_pressed("End"):
		get_tree().quit()