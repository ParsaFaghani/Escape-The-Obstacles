extends Panel

onready var Lable = $Label
onready var button = $Button


func _ready():
	if UserData.lang:
		Lable.text = Persian.reshaper(Lang.game_pause[1])
		button.text = Persian.reshaper(Lang.exit[1])
	elif UserData.lang == 0:
		Lable.text = Lang.game_pause[0]
		button.text = Lang.exit[0]
	

func _on_Button_pressed():
	get_tree().change_scene("res://src/screen/MainScreen.tscn")
