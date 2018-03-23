extends Node

# Change to "user://Config.cfg" later!
const SAVE_PATH = "user://Config.cfg"

var config_file = ConfigFile.new()
var save_dictionary = {
	"progress": {
		"attack" : 0,
		"life" : 0,
		"magic" : 0
	},
	"progressEasy": {
		"attack" : 0,
		"life" : 0,
		"magic" : 0
	},	
	"switchToEasy": {
		"EasyMode" : 0
	},
	"introduction": {
		"shown" : 0
	}
} setget , _get_save_dictionary

func _ready():
	load_settings()
	#save_settings()
	pass

func delete_save():
	for section in save_dictionary.keys():
		for key in save_dictionary[section]:
			save_dictionary[section][key] = 0
	save_settings()


func is_empty():
	load_settings()
	var empty = true
	for section in save_dictionary.keys():
		for key in save_dictionary[section]:
			if(save_dictionary[section][key] != 0):
				empty = false
	if(empty):
		return true
	else:
		return false
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
			var valueToSave = config_file.get_value(section, key, null)
			if(valueToSave != null):
				save_dictionary[section][key] = valueToSave
			else:
				save_settings()
				break


func _get_save_dictionary():
	return save_dictionary
	pass
	
func set_magic(newValue):
	save_dictionary["progress"]["magic"] = newValue
	
func set_life(newValue):
	save_dictionary["progress"]["life"] = newValue
	
func set_attack(newValue):
	save_dictionary["progress"]["attack"] = newValue
	
func set_easy_magic(newValue):
	save_dictionary["progressEasy"]["magic"] = newValue
	
func set_easy_life(newValue):
	save_dictionary["progressEasy"]["life"] = newValue
	
func set_easy_attack(newValue):
	save_dictionary["progressEasy"]["attack"] = newValue
	
func set_easy_mode(value):
	if(value):
		save_dictionary["switchToEasy"]["EasyMode"] = 1
	else:
		save_dictionary["switchToEasy"]["EasyMode"] = 0
		
func get_easy_mode():
	return save_dictionary["switchToEasy"]["EasyMode"]
	
func set_introduction_shown(value):
	save_dictionary["introduction"]["shown"] = value
	
func get_introduction_shown():
	return save_dictionary["introduction"]["shown"]