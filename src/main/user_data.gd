extends Node


var score_record : int = 0
var wallet : int = 0
var last_color : int = 0
var last_head : int = 0
var last_body : int = 0
var last_background : int = 0
var unlocked_color : Array = [0]
var unlocked_head : Array = [0]
var unlocked_body : Array = [0]
var unlocked_background : Array = [0]
var tutorial : bool = true
var bus : Dictionary = {
	"master" : 9,
	"sfx" : 9,
	"music" : 9
}
var ads : bool = false
var lang : int = 1

func save() -> Dictionary:
	var save_dict : Dictionary = {
		"score_record" : score_record,
		"wallet" : wallet,
		"last_color" : last_color,
		"last_head" :last_head,
		"last_body" : last_body,
		"last_background" : last_background,
		"unlocked_color": unlocked_color,
		"unlocked_head" : unlocked_head,
		"unlocked_body" : unlocked_body,
		"unlocked_background": unlocked_background,
		"tutorial" : tutorial,
		"bus" : bus,
		"lang": lang,
		}
	return save_dict
