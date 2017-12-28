extends Sprite

func _ready():
	get_node("anim").play("flare_fade_out")
	yield(get_node("anim"), "finished")
	queue_free()