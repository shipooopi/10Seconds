extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	SaveFile.set_attack(1)
	SaveFile.set_magic(0)
	SaveFile.set_life(0)
	pass


func _on_Timer_levelFinish():
	SaveFile.load_settings()
	SaveFile.set_attack(1)
	SaveFile.save_settings()
	pass # replace with function body
