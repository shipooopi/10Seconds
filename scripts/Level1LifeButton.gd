extends Button

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	SaveFile.load_settings()
	if(SaveFile._get_save_dictionary()["progress"]["life"] > 0):
		get_node("Sprite").set_hidden(false)
	pass
