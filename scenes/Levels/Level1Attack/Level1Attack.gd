extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var scn_youDead = preload("res://scenes/YouDead/YouDeadAttack.tscn")

func _ready():
	# Initialization here
	get_node("Player").set_deadScn(scn_youDead)
	SaveFile.set_attack(1)
	SaveFile.set_magic(0)
	SaveFile.set_life(0)
	pass


func _on_Timer_levelFinish():
	SaveFile.load_settings()
	SaveFile.set_attack(1)
	SaveFile.save_settings()
	pass # replace with function body
