extends StreamPlayer

func _ready():
	var song = load("res://sounds/soundtrack.wav")
	set_stream(song)
	self.play()