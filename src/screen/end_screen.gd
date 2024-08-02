extends Control


@onready var score_text := $Score
@onready var wallet_text := $Wallet/Label
@onready var record_text := $Record

@onready var button_sfx := $ButtonSFX
@onready var tween := $Tween
@onready var anim_play := $AnimationPlayer

@onready var RetryButton := $Button/RetryButton
@onready var CustomizeButton := $Button/CustomizeButton
@onready var ExitButton := $Button/ExitButton


var score := 0: set = set_score
var wallet := 0: set = set_wallet
var record := 0: set = set_record


func _ready() -> void:
	record = UserData.score_record
	if UserData.lang:
		record_text.set_text(Lang.record_text[1] % record)
		RetryButton.text =Lang.Retry[1]
		CustomizeButton.text = Lang.Customize[1]
		ExitButton.text =Lang.exit[1]
	else:
		record_text.set_text(Lang.record_text[0] % record)
		RetryButton.text = Lang.Retry[0]
		CustomizeButton.text = Lang.Customize[0]
		ExitButton.text = Lang.exit[0]

func _on_end_screen_triggered() -> void:
	anim_play.play("show")
	await anim_play.animation_finished
	
	tween.interpolate_property(self, "score",
		0, get_parent().get_parent().score, 1.0,
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.interpolate_property(self, "wallet",
		0, get_parent().get_parent().wallet, 0.5,
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()
	await tween.tween_all_completed
	
	tween.interpolate_property(self, "wallet",
	wallet, wallet + (score/100), 1.0, 
	Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()
	await tween.tween_all_completed
	
	if score > record:
		tween.interpolate_property(self, "record",
			record, score, 0.5,
			Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		tween.start()
	await tween.tween_all_completed

func _on_RetryButton_pressed() -> void:
	SaveLoad.save_game()
	button_sfx.play()
	anim_play.play("exit")
	await anim_play.animation_finished
	get_tree().reload_current_scene()

func _on_CustomizeButton_pressed() -> void:
	SaveLoad.save_game()
	button_sfx.play()
	anim_play.play("exit")
	await anim_play.animation_finished
	BackGroundMusic.stop()
	get_tree().change_scene_to_packed(preload("res://src/screen/CustomizationScreen.tscn"))

func _on_LeaderButton_pressed() -> void:
	pass # Replace with function body.

func _on_ExitButton_pressed() -> void:
	SaveLoad.save_game()
	button_sfx.play()
	anim_play.play("exit")
	await anim_play.animation_finished
	BackGroundMusic.stop()
	get_tree().change_scene_to_packed(Main.main_screen)

func set_score(points : int) -> void:
	score = points
	score_text.set_text(str(score).pad_zeros(12))

func set_wallet(coins : int) -> void:
	wallet = coins
	wallet_text.set_text(str(wallet))

func set_record(points : int) -> void:
	record = points
	record_text.set_text("Your record: %012d" % record)
