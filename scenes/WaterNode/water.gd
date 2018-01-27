extends Node2D


func _ready():
	set_process(true)

func _on_Water2_body_enter( body ):
	if(body.get_name() == "Player"):
		body._in_water()

func _on_Water2_body_exit( body ):
	if(body.get_name() == "Player"):
		body._out_water()
