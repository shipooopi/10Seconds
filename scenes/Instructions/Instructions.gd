extends CanvasLayer

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	set_process(true)
	pass

func _process(delta):
	if(Input.is_action_pressed("Quit")):
		queue_free()