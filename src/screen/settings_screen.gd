extends PopupPanel

@onready var master_value := $Control/VBoxContainer/HBoxContainer/MasterHSlider
@onready var sfx_value := $Control/VBoxContainer/HBoxContainer2/SFXHSlider
@onready var music_value := $Control/VBoxContainer/HBoxContainer3/MusicHSlider
@onready var master_label := $Control/VBoxContainer/HBoxContainer/Value
@onready var sfx_label := $Control/VBoxContainer/HBoxContainer2/Value
@onready var music_label := $Control/VBoxContainer/HBoxContainer3/Value
@onready var ads_button := $Control/AdsCheckButton
@onready var lang_button := $Control/VBoxContainer/lang/lang_value
@onready var button_sfx := $ButtonSFX

@onready var close_button = $Control/CloseButton
@onready var volume_lable = $Control/VBoxContainer/HBoxContainer/Label
@onready var effects_lable = $Control/VBoxContainer/HBoxContainer2/Label
@onready var music_lable = $Control/VBoxContainer/HBoxContainer3/Label



var array := [-72, -64, -56, -48, -40, -32, -24, -16, -8, 0]

var lang_change = false

func _ready() -> void:
	if UserData.lang:
		close_button.text = Lang.close[1]
		volume_lable.text = Lang.volume[1]
		effects_lable.text = Lang.effects[1]
		music_lable.text = Lang.Music[1]
	elif UserData.lang == 0:
		close_button.text = Lang.close[0]
		volume_lable.text = Lang.volume[0]
		effects_lable.text = Lang.effects[0]
		music_lable.text = Lang.Music[0]
	
	await owner.ready
	master_value.set_value(UserData.bus["master"])
	sfx_value.set_value(UserData.bus["sfx"])
	music_value.set_value(UserData.bus["music"])
	master_label.set_text(str(UserData.bus["master"]).pad_zeros(2))
	sfx_label.set_text(str(UserData.bus["sfx"]).pad_zeros(2))
	music_label.set_text(str(UserData.bus["music"]).pad_zeros(2))
	if not Engine.has_singleton("GodotAdMob"):
		ads_button.set_disabled(true)
		UserData.ads = false
	ads_button.set_pressed(UserData.ads)
	lang_button.set_value(UserData.lang)
	button_sfx.set_stream_paused(false)

func _on_MasterHSlider_value_changed(value: int) -> void:
	AudioServer.set_bus_volume_db(0, array[value])
	master_label.set_text(str(value).pad_zeros(2))
	if not button_sfx.get_stream_paused():
		button_sfx.play()
	UserData.bus["master"] = value

func _on_SFXHSlider_value_changed(value: int) -> void:
	AudioServer.set_bus_volume_db(1, array[value])
	sfx_label.set_text(str(value).pad_zeros(2))
	if not button_sfx.get_stream_paused():
		button_sfx.play()
	UserData.bus["sfx"] = value

func _on_MusicHSlider_value_changed(value: int) -> void:
	AudioServer.set_bus_volume_db(2, array[value])
	music_label.set_text(str(value).pad_zeros(2))
	if not button_sfx.get_stream_paused():
		button_sfx.play()
	UserData.bus["music"] = value

func _on_AdsCheckButton_toggled(button_pressed: bool) -> void:
	if not button_sfx.get_stream_paused():
		button_sfx.play()
	UserData.ads = button_pressed

func _on_CalibrateButton_pressed() -> void:
	pass # Replace with function body.

func _on_CloseButton_pressed() -> void:
	SaveLoad.save_game()
	button_sfx.play()
	if lang_change:
		get_tree().reload_current_scene()
	set_visible(false)


func _on_lang_toggled(button_pressed: bool) -> void:
	if not button_sfx.get_stream_paused():
		button_sfx.play()
	UserData.lang = button_pressed


func _on_lang_value_value_changed(value):
	if not button_sfx.get_stream_paused():
		button_sfx.play()
	print(value)
	UserData.lang = value
	lang_change = true
