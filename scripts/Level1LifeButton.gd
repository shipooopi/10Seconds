extends Button

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var icon_beaten = preload("res://scenes/WorldMap/imports/Life.tex")
var icon_hover = preload("res://scenes/WorldMap/imports/Hover.tex")
var icon = preload("res://scenes/WorldMap/imports/Castle.tex")
var not_beaten = true
var not_beaten_easy = true

func _ready():
	SaveFile.load_settings()
	if(SaveFile.get_easy_mode()):
		if(SaveFile._get_save_dictionary()["progressEasy"]["life"] > 0):
			not_beaten_easy = false
			self.set_button_icon(icon_beaten)
	else:
		if(SaveFile._get_save_dictionary()["progress"]["life"] > 0):
			not_beaten = false
			self.set_button_icon(icon_beaten)
	pass


func _on_clear_save_pressed():
	SaveFile.load_settings()
	if(SaveFile.get_easy_mode()):
		if(SaveFile._get_save_dictionary()["progressEasy"]["life"] > 0):
			not_beaten_easy = false
			self.set_button_icon(icon_beaten)
		else:
			not_beaten_easy = true
			self.set_button_icon(icon)
	else:
		if(SaveFile._get_save_dictionary()["progress"]["life"] > 0):
			not_beaten = false
			self.set_button_icon(icon_beaten)
		else:
			not_beaten = true
			self.set_button_icon(icon)
	pass # replace with function body


func _on_Level1Life_mouse_enter():
	SaveFile.load_settings()
	if((SaveFile.get_easy_mode() and not_beaten_easy) or (not SaveFile.get_easy_mode() and not_beaten)):
		self.set_button_icon(icon_hover)
	pass # replace with function body


func _on_Level1Life_mouse_exit():
	SaveFile.load_settings()
	if((SaveFile.get_easy_mode() and not_beaten_easy) or (not SaveFile.get_easy_mode() and not_beaten)):		
		self.set_button_icon(icon)
	pass # replace with function body
