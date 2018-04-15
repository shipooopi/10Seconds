extends Button

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var icon_hover = preload("res://scenes/WorldMap/imports/Boss_hover.tex")
var icon = preload("res://scenes/WorldMap/imports/boss.tex")

func _ready():
	pass


func _on_LevelBoss_mouse_enter():
	self.set_button_icon(icon_hover)
	pass # replace with function body


func _on_LevelBoss_mouse_exit():
	self.set_button_icon(icon)
	pass # replace with function body
