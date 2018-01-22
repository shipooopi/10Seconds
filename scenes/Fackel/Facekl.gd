extends AnimatedSprite

var tempElapsed = 0

func _ready():
   set_process(true)
   
func _process(delta):
	pass
#   tempElapsed = tempElapsed + delta
   
#   if(tempElapsed > 1):
#      if(get_frame() == get_sprite_frames().get_frame_count("Burning")-1):
#         set_frame(0)
#      else:
#         self.set_frame(get_frame() + 1)
#      
#      tempElapsed = 0

func _on_Player_time_freeze():
	self.set_process(false)
	pass # replace with function body


func _on_Player_time_freeze_end():
	self.set_process(true)
	pass # replace with function body


func _on_Fackel_frame_changed():
	self.get_sprite_frames().set_animation_speed("default", floor(rand_range(3, 6)))
	#
	pass # replace with function body
