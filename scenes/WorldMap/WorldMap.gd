extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass


func _on_Level1_pressed():
	#get_tree().change_scene("res://World.tscn")
	get_tree().change_scene("res://scenes/Levels/Level1/LevelTest.tscn")


func _on_Level1Life_pressed():
	get_tree().change_scene("res://scenes/Levels/Level1Life/Level1Life.tscn")
	pass # replace with function body


func _on_Level1Attack_pressed():
	get_tree().change_scene("res://scenes/Levels/Level1Attack/Level1Attack.tscn")
	pass # replace with function body
