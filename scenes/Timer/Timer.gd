extends CanvasLayer

var label_node
var timer_node

const scn_youDead = preload("res://scenes/YouDead/YouDead.tscn")
const scn_youWin = preload("res://scenes/YouWin/YouWin.tscn")

var winShow = false

signal levelFinish

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

func _on_Area2D_body_enter( body ):
	if(body.get_name() == "Player"):
		timer_node.set_process(false)
		get_tree().set_pause(true)
		if(not winShow):
			if(timer_node.get_time_left() > 0 and not Globals.get("gameOver")):
				winShow = true
				var youWin = scn_youWin.instance()
				utils.main_node.add_child(youWin)
				utils.main_node.move_child(youWin,0)
				emit_signal("levelFinish")
			elif(timer_node.get_time_left() <= 0 and not Globals.get("gameOver")):
				winShow = true
				var youDead = scn_youDead.instance()
				utils.main_node.add_child(youDead)
				utils.main_node.move_child(youDead,0)

	pass # replace with function body
