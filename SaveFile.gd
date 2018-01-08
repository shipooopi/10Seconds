extends Node

# Change to "user://Config.cfg" later!
const SAVE_PATH = "res://Config.cfg"

var config_file = ConfigFile.new()
var save_dictionary = {
	"progress": {
		"attack" : 0,
		"life" : 0,
		"magic" : 0
	}
} setget , _get_save_dictionary

func _ready():
	load_settings()
	#save_settings()
	pass

func save_settings():
	for section in save_dictionary.keys():
		for key in save_dictionary[section]:
			config_file.set_value(section, key, save_dictionary[section][key])
	config_file.save(SAVE_PATH)
	
func load_settings():
	var error = config_file.load(SAVE_PATH)
	if (error != OK):
		print("Failed loading the config file. Error code %s." % error)
		return null
		
	for section in save_dictionary.keys():
		for key in save_dictionary[section]:
			save_dictionary[section][key] = config_file.get_value(section, key, null)
			print(str(save_dictionary[section][key]))

func _get_save_dictionary():
	return save_dictionary
	pass