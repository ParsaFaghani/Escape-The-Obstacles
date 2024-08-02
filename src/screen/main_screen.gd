extends Control

signal tutorial_triggered()
signal easteregg_triggered()

@onready var player_sprite := $Sprites
@onready var body_sprite := $Sprites/Body
@onready var head_sprite := $Sprites/Head
@onready var background := $CanvasLayer/Background

@onready var settings_screen := $SettingsScreen
@onready var credits_screen := $AboutScreen
@onready var tutorial_screen:= $TutorialConfirmation

@onready var ee_game := $CanvasLayer/EasterEggGame
@onready var ee_message := $EasterEggMessage
@onready var ee_dialog := $EasterEggDialog

@onready var button_sfx := $ButtonSFX
@onready var ee_sfx := $EasterEggSFX
@onready var anim_play := $AnimationPlayer

#@onready var rate_button := $Logos/Rate

@onready var PlayButton := $MainButtons/HMenu/Menu/PlayButton
@onready var CustomizeButton := $MainButtons/HMenu/Menu/CustomizeButton
@onready var SettingsButton := $MainButtons/HMenu/Menu/SettingsButton
@onready var AboutButton := $MainButtons/HMenu/Menu/AboutButton


func _ready() -> void:
	if UserData.lang:
		print('fa')
		PlayButton.text = Lang.play[1]
		CustomizeButton.text = Lang.Customize[1]
		SettingsButton.text = Lang.settings[1]
		AboutButton.text = Lang.about[1]
	elif UserData.lang == 0:
		print('en')
		PlayButton.text = Lang.play[0]
		CustomizeButton.text = Lang.Customize[0]
		SettingsButton.text = Lang.settings[0]
		AboutButton.text = Lang.about[0]
	get_tree().set_pause(false)
	SaveLoad.load_game()
	
	connect("tutorial_triggered", Callable(tutorial_screen, "_on_tutorial_triggered"))
	connect("easteregg_triggered", Callable(ee_message, "_on_easteregg_triggered"))
	#tutorial_screen.get_cancel_button().pressed.connect(
		#self, "_on_TutorialConfirmation_cancelled")
	#tutorial_screen.canceled.connect(
		#self, "_on_TutorialConfirmation_cancelled")
	#ee_dialog.canceled.connect(
		#self, "_on_EEDialog_closed")
	#ee_game.dialog_triggered.connect(
		#ee_dialog, "_on_EEGame_dialog_triggered")
	#ee_game.hidden_activeted.connect(
		#self, "_on_EEGame_hidden_activeted")
	
	if not BackGroundMusic.is_playing():
		BackGroundMusic.set_stream(load(Data.menum_dir + '/' 
									+ Data.menumusic[0]))
		BackGroundMusic.play()
	#
	#if Main.os == "Android":
		#rate_button.set_normal_texture(load("res://assets/ui/logos/google.png"))
	
	body_sprite.set_texture(
		load(Data.body_dir + '/' + Data.body[UserData.last_body]))
	head_sprite.set_texture(
		load(Data.head_dir + '/' + Data.head[UserData.last_head]))
	player_sprite.set_modulate(Color(Data.color[UserData.last_color]))
	player_sprite.get_material().set_shader_parameter(
		"color", Data.shader_color[UserData.last_color])
	background.set_texture(
		load(Data.back_dir + '/' + Data.background[UserData.last_background]))
	

func _on_PlayButton_pressed() -> void:
	button_sfx.play()
	await button_sfx.finished
	
	# if not UserData.tutorial:
	get_tree().change_scene_to_packed(preload("res://src/level/Level.tscn"))
	# 	return
	# emit_signal("tutorial_triggered")

func _on_CustomizeButton_pressed() -> void:
	button_sfx.play()
	anim_play.play("exit")
	await anim_play.animation_finished
	get_tree().change_scene_to_packed(preload("res://src/screen/CustomizationScreen.tscn"))

func _on_SettingsButton_pressed() -> void:
	button_sfx.play()
	settings_screen.popup()

func _on_CreditsButton_pressed() -> void:
	button_sfx.play()
	credits_screen.popup()

func _on_TutorialConfirmation_confirmed() -> void:
	UserData.tutorial = false
	SaveLoad.save_game()
	button_sfx.play()
	anim_play.play("exit")
	await anim_play.animation_finished
	get_tree().change_scene_to_packed(preload("res://src/level/Tutorial.tscn"))

func _on_TutorialConfirmation_cancelled() -> void:
	UserData.tutorial = false
	SaveLoad.save_game()
	button_sfx.play()
	anim_play.play("exit")
	await anim_play.animation_finished
	get_tree().change_scene_to_packed(preload("res://src/level/Level.tscn"))

func _on_EasterEgg_pressed() -> void:
	if anim_play.is_playing():
		return
	
	ee_sfx.play()
	anim_play.play("sprite_unique")
	await anim_play.animation_finished
	
	emit_signal("easteregg_triggered")
	anim_play.play("easteregg")
	await anim_play.animation_finished
	
	anim_play.play("reset_sprite")



func _on_EEGame_hidden_activeted() -> void:
	anim_play.play("easteregg2")

func _on_EEDialog_closed() -> void:
	get_tree().set_pause(false)
	button_sfx.play()
	await button_sfx.finished


func _on_Myket_pressed():
	button_sfx.play()
	await button_sfx.finished
	OS.shell_open("https://myket.ir/app/me.DarkCoder.escape")



func _on_virasty_pressed():
	button_sfx.play()
	await button_sfx.finished
	OS.shell_open("https://virasty.com/DarkCoder")



func _on_GitHub_pressed():
	button_sfx.play()
	await button_sfx.finished
	OS.shell_open("https://github.com/FDarkCoder/Escape-The-Obstacles")




func _on_Twitter_pressed():
	pass # Replace with function body.

