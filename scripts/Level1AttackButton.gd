extends Button

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	SaveFile.load_settings()
	if(SaveFile.get_easy_mode()):
		if(SaveFile._get_save_dictionary()["progressEasy"]["attack"] > 0):
			get_node("Sprite").set_hidden(false)
	else:
		if(SaveFile._get_save_dictionary()["progress"]["attack"] > 0):
			get_node("Sprite").set_hidden(false)
	pass


func _on_clear_save_pressed():
	SaveFile.load_settings()
	if(SaveFile.get_easy_mode()):
		if(SaveFile._get_save_dictionary()["progressEasy"]["attack"] > 0):
			get_node("Sprite").set_hidden(false)
		else:
			get_node("Sprite").set_hidden(true)
	else:
		if(SaveFile._get_save_dictionary()["progress"]["attack"] > 0):
			get_node("Sprite").set_hidden(false)
		else:
			get_node("Sprite").set_hidden(true)
	pass # replace with function body