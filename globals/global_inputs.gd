# script: utils

extends Node

const scn_instruction = preload("res://scenes/Instructions/Instructions.tscn")
var instructions

func _ready():
	get_tree().get_root().set_pause_mode(2)
	set_process(true)
	
func _process(delta):
	if Input.is_action_pressed("End"):
		get_tree().quit()
	if Input.is_action_pressed("Restart"):
		get_tree().set_pause(false)
		get_tree().reload_current_scene()
	if(Input.is_action_pressed("Quit")):
		if(get_tree().get_current_scene().get_name() != "WorldMap"):
			get_tree().change_scene("res://scenes/WorldMap/WorldMap.tscn")
	if(Input.is_action_pressed("Instructions")):
		instructions = scn_instruction.instance()
		utils.main_node.add_child(instructions)
			
	