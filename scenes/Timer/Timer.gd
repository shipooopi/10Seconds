extends CanvasLayer

var label_node
var timer_node
var count = 0

func _ready():
	label_node = get_node("Label")
	timer_node = get_node("Timer")
	timer_node.set_one_shot(true)
	timer_node.set_wait_time(10)
	timer_node.set_autostart(true)
	set_process(true)
	pass
	
func _process(delta):
	label_node.set_text(str(stepify(timer_node.get_time_left(),0.01)))
