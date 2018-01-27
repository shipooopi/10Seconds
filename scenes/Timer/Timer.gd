extends CanvasLayer

var label_node
var timer_node

func _ready():
	label_node = get_node("Label")
	timer_node = get_node("Timer")
	timer_node.set_one_shot(true)
	timer_node.set_wait_time(10)
	timer_node.set_autostart(true)
	set_process(true)
	pass
	
func _process(delta):
	if(timer_node.get_time_left() > 0):
		label_node.set_text(str(stepify(timer_node.get_time_left(),0.01)))
	else:
		label_node.set_text("0.00")
		
	if(timer_node.get_time_left() <= 3):
		label_node.add_color_override("font_color", Color(1,0,0))
	


func _on_Player_time_freeze():
	timer_node.set_process(false)


func _on_Player_time_freeze_end():
	timer_node.set_process(true)