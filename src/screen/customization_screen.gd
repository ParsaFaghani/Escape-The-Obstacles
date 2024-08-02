extends Control

signal ads_warnig_triggered(string)
signal info_triggered()
signal tutorial_triggered()

@onready var admob := $AdMob
@onready var admob_debugger := $CanvasLayer/AdMobDebug

@onready var player_selector := $PlayerSelector
@onready var background_selector := $BackGroundSelector
@onready var color_selector := $ColorSelector
@onready var ads_warning := $AdsWarning
@onready var info_screen := $InfoScreen
@onready var unlock_screen := $UnlockScreen
@onready var tutorial_screen := $TutorialConfirmation
@onready var fake_ads := $FakeAds
@onready var coin := $Coin/Label

@onready var adsbutton := $Button/AdsButton
@onready var ExitButton := $Button/ExitButton
@onready var PlayButton := $Button/PlayButton


@onready var button_sfx := $ButtonSFX
@onready var anim_play := $AnimationPlayer

var rewarded := false
var is_fake_ads = true
var coin_reward := 300


func _ready() -> void:
	if UserData.lang:
		PlayButton.text = Lang.play[1]
		ExitButton.text = Lang.exit[1]
		adsbutton.text = Lang.AdsButton[1]
	elif UserData.lang == 0:
		PlayButton.text = Lang.play[0]
		ExitButton.text = Lang.exit[0]
		adsbutton.text = Lang.AdsButton[0]
	
	get_tree().set_pause(false)
	SaveLoad.load_game()
	
	connect("tutorial_triggered", Callable(tutorial_screen, "_on_tutorial_triggered"))
	connect("info_triggered", Callable(info_screen, "_on_info_triggered"))
	connect("ads_warnig_triggered", Callable(ads_warning, "_on_ads_warning_triggered"))
	
	player_selector.unlock_pressed.connect(unlock_screen, "_on_unlock_pressed")
	background_selector.unlock_pressed.connect(unlock_screen, "_on_unlock_pressed")
	color_selector.unlock_pressed.connect(unlock_screen, "_on_unlock_pressed")
	color_selector.player_color_changed.connect(player_selector, "_on_player_color_changed")
	tutorial_screen.get_close_button().connect(
		"pressed", self, "_on_TutorialConfirmation_cancelled")
	tutorial_screen.get_cancel_button().connect(
		"pressed", self, "_on_TutorialConfirmation_cancelled")
	ads_warning.get_close_button().connect(
		"pressed", self, "_on_AdsWarning_closed")
	
	coin.set_text(str(UserData.wallet))
	
	if not BackGroundMusic.is_playing():
		BackGroundMusic.set_stream(load(Data.menum_dir + '/' 
									+ Data.menumusic[0]))
		BackGroundMusic.play()
	
	if (UserData.ads and Engine.has_singleton("GodotAdMob")):
		admob.load_interstitial()
		is_fake_ads = false
#	else:
#		admob_debugger.label.set_text("AdMob Java Singleton not found. This plugin will only work on Android.")

func _on_PlayButton_pressed() -> void:
	SaveLoad.save_game()
	button_sfx.play()
	await button_sfx.finished
	if not UserData.tutorial:
		get_tree().change_scene_to_packed(preload("res://src/level/Level.tscn"))
		return
	emit_signal("tutorial_triggered")

func _on_ExitButton_pressed() -> void:
	SaveLoad.save_game()
	button_sfx.play()
	anim_play.play("exit")
	await anim_play.animation_finished
	
	get_tree().change_scene_to_packed(Main.main_screen)

func _on_InfoButton_pressed() -> void:
	button_sfx.play()
	await button_sfx.finished
	emit_signal("info_triggered", player_selector.head)

func _on_InfoScreen_popup_hide() -> void:
	button_sfx.play()
	await button_sfx.finished

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

func _on_AdsButton_pressed() -> void:
	button_sfx.play()
	await button_sfx.finished
	
	emit_signal(
		"ads_warnig_triggered", Main.ads_reward_string[0] % [coin_reward])

func _on_AdsWarning_confirmed() -> void:
	button_sfx.play()
	await button_sfx.finished
	
	BackGroundMusic.set_stream_paused(true)
	
	if not is_fake_ads:
		admob.show_interstitial()
	else:
		fake_ads.show_ads(5)

func _on_FakeAds_closed() -> void:
	UserData.wallet += coin_reward
	coin.set_text(str(UserData.wallet))
	rewarded = true
	adsbutton.set_disabled(true)
	
	BackGroundMusic.set_stream_paused(false)
	
	SaveLoad.save_game()

func _on_AdMob_interstitial_loaded() -> void:
#	admob_debugger.label.set_text("Rewarded video ad loaded.")
	adsbutton.set_disabled(false)

func _on_AdMob_interstitial_failed_to_load(error_code : int) -> void:
#	admob_debugger.label.set_text("Rewarded video ad failed to load with error : %d." % error_code)
	adsbutton.set_disabled(false)
	is_fake_ads = true

func _on_AdMob_interstitial_closed() -> void:
	UserData.wallet += coin_reward
	coin.set_text(str(UserData.wallet))
	rewarded = true
	adsbutton.set_disabled(true)
	
	BackGroundMusic.set_stream_paused(false)
	
	SaveLoad.save_game()
