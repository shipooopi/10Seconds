extends Node2D

const scn_instruction = preload("res://scenes/Instructions/Instructions.tscn")
var instructions

func _ready():
	get_tree().set_pause(false)
	if(SaveFile.is_empty()):
		instructions = scn_instruction.instance()
		utils.main_node.add_child(instructions)

func _on_Level1_pressed():
	#get_tree().change_scene("res://World.tscn")
	get_tree().change_scene("res://scenes/Levels/Level1/LevelTest.tscn")


func _on_Level1Life_pressed():
	get_tree().change_scene("res://scenes/Levels/Level1Life/Level1Life.tscn")
	pass # replace with function body


func _on_Level1Attack_pressed():
	get_tree().change_scene("res://scenes/Levels/Level1Attack/Level1Attack.tscn")
	pass # replace with function body


func _on_Level1Magic_pressed():
	get_tree().change_scene("res://scenes/Levels/Level1Magic/Level1Magic.tscn")
	pass # replace with function body


func _on_Level2Life_pressed():
	get_tree().change_scene("res://scenes/Levels/Level2Life/Level2Life.tscn")


func _on_LevelBoss_pressed():
	get_tree().change_scene("res://scenes/Levels/LevelBoss/LevelBoss.tscn")
