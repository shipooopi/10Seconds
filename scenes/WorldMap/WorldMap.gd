extends Node2D

const scn_instruction = preload("res://scenes/Instructions/Instructions.tscn")
var instructions

func _ready():
	get_tree().set_pause(false)
	SaveFile.load_settings()
	if(SaveFile.get_easy_mode()):
		get_node("CheckButton").set_pressed(false)
	else:
		get_node("CheckButton").set_pressed(true)
	if(SaveFile.is_empty()):
		instructions = scn_instruction.instance()
		utils.main_node.add_child(instructions)
		SaveFile.set_introduction_shown(1)
		SaveFile.save_settings()
	if(SaveFile.get_easy_mode() and get_tree().get_root().get_name() == "WorldMap"):
		get_tree().change_scene("res://scenes/WorldMap/WorldMapEasy.tscn")

#func _on_Level1_pressed():
#	#get_tree().change_scene("res://World.tscn")
#	get_tree().change_scene("res://scenes/Levels/Level1/LevelTest.tscn")


func _on_Level1Life_pressed():
	if(SaveFile.get_easy_mode()):
		get_tree().change_scene("res://scenes/Levels/Level1Life/Level1LifeEasy.tscn")
	else:
		get_tree().change_scene("res://scenes/Levels/Level1Life/Level1Life.tscn")
	pass # replace with function body


func _on_Level1Attack_pressed():
	if(SaveFile.get_easy_mode()):
		get_tree().change_scene("res://scenes/Levels/Level1Attack/Level1AttackEasy.tscn")
	else:
		get_tree().change_scene("res://scenes/Levels/Level1Attack/Level1Attack.tscn")
	pass # replace with function body


func _on_Level1Magic_pressed():
	if(SaveFile.get_easy_mode()):
		get_tree().change_scene("res://scenes/Levels/Level1Magic/Level1MagicEasy.tscn")
	else:
		get_tree().change_scene("res://scenes/Levels/Level1Magic/Level1Magic.tscn")
	pass # replace with function body


func _on_LevelBoss_pressed():
	if(SaveFile.get_easy_mode()):
		get_tree().change_scene("res://scenes/Levels/LevelBoss/LevelBossEasy.tscn")
	else:
		get_tree().change_scene("res://scenes/Levels/LevelBoss/LevelBoss.tscn")
