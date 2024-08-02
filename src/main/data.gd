extends Node


var color : Array = [
	"e5e5e5", 
	"d62838", 
	"197f42", 
	"334784", 
	"33a9d0", 
	"843360", 
	"e0c12f", 
	"db6638"]

var shader_color : Array = [
	Color(1.5, 1.5, 1.5, 1),
	Color(1.5, 0, 0, 1),
	Color(0, 1.5, 0, 1),
	Color(0, 0, 1.5, 1),
	Color(0, 1, 1.5, 1),
	Color(1.5, 0, 1, 1),
	Color(1.5, 1, 0, 1),
	Color(1.5, 0.5, 0, 1)]

var head : Array = []
var body : Array = []
var background : Array = []
var menumusic : Array = []
var levelmusic : Array = []

var head_dir := "res://assets/player/head"
var body_dir := "res://assets/player/body"
var back_dir := "res://assets/background"
var menum_dir := "res://assets/music/menu"
var levelm_dir := "res://assets/music/level"


func _init() -> void:
	var dir := DirAccess.open(head_dir)
	
	
	if dir.change_dir(head_dir) == OK:
		dir.list_dir_begin() # TODOConverter3To4 fill missing arguments https://github.com/godotengine/godot/pull/40547
		var file_name := dir.get_next()
		while(file_name != ""):
			if file_name.ends_with(".png.import"):
				file_name = file_name.replace(".import", "")
				head.append(file_name)
			file_name = dir.get_next()
	head.sort()
	
	if dir.change_dir(body_dir) == OK:
		dir.list_dir_begin() # TODOConverter3To4 fill missing arguments https://github.com/godotengine/godot/pull/40547
		var file_name := dir.get_next()
		while(file_name != ""):
			if file_name.ends_with(".png.import"):
				file_name = file_name.replace(".import", "")
				body.append(file_name)
			file_name = dir.get_next()
	body.sort()
	
	if dir.change_dir(back_dir) == OK:
		dir.list_dir_begin() # TODOConverter3To4 fill missing arguments https://github.com/godotengine/godot/pull/40547
		var file_name := dir.get_next()
		while(file_name != ""):
			if file_name.ends_with(".jpg.import") or file_name.ends_with(".png.import"):
				file_name = file_name.replace(".import", "")
				background.append(file_name)
			file_name = dir.get_next()
	background.sort()
	
	if dir.change_dir(menum_dir) == OK:
		dir.list_dir_begin() # TODOConverter3To4 fill missing arguments https://github.com/godotengine/godot/pull/40547
		var file_name := dir.get_next()
		while(file_name != ""):
			if file_name.ends_with(".ogg.import"):
				file_name = file_name.replace(".import", "")
				menumusic.append(file_name)
			file_name = dir.get_next()
	menumusic.sort()
	
	if dir.change_dir(levelm_dir) == OK:
		dir.list_dir_begin() # TODOConverter3To4 fill missing arguments https://github.com/godotengine/godot/pull/40547
		var file_name := dir.get_next()
		while(file_name != ""):
			if file_name.ends_with(".ogg.import"):
				file_name = file_name.replace(".import", "")
				levelmusic.append(file_name)
			file_name = dir.get_next()
	levelmusic.sort()
