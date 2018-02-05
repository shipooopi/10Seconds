extends Button


func _ready():
	pass

func _on_clear_save_pressed():
	SaveFile.delete_save()
