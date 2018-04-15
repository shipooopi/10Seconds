extends Button


func _ready():
	pass

func _on_clear_save_pressed():
	SaveFile.delete_save()
	SaveFile.set_introduction_shown(1)
	SaveFile.save_settings()
