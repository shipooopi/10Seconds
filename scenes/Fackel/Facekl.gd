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