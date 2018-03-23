extends Button

func _on_SwitchToEasy_pressed():
	SaveFile.load_settings()
	if(SaveFile.get_easy_mode()):
		get_tree().change_scene("res://scenes/WorldMap/WorldMap.tscn")
		SaveFile.set_easy_mode(0)
	else:
		get_tree().change_scene("res://scenes/WorldMap/WorldMapEasy.tscn")
		SaveFile.set_easy_mode(1)
	SaveFile.save_settings()


func _on_CheckButton_toggled( pressed ):
	if(pressed):
		get_tree().change_scene("res://scenes/WorldMap/WorldMap.tscn")
		SaveFile.set_easy_mode(0)
	else:
		get_tree().change_scene("res://scenes/WorldMap/WorldMapEasy.tscn")
		SaveFile.set_easy_mode(1)
	SaveFile.save_settings()
