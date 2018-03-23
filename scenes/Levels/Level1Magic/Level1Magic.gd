extends Node2D

# class member variables go here, for example:
# var a = 2
var scn_youDead = preload("res://scenes/YouDead/YouDeadMagic.tscn")

func _ready():
	# Initialization here
	get_node("Player").set_deadScn(scn_youDead)
	if(SaveFile.get_easy_mode()):
		SaveFile.set_easy_attack(0)
		SaveFile.set_easy_magic(2)
		SaveFile.set_easy_life(0)
	else:
		SaveFile.set_attack(0)
		SaveFile.set_magic(1)
		SaveFile.set_life(0)
	pass


func _on_Timer_levelFinish():
	SaveFile.load_settings()
	if(SaveFile.get_easy_mode()):
		SaveFile.set_easy_magic(2)
	else:
		SaveFile.set_magic(1)
	SaveFile.save_settings()
	pass # replace with function body
