extends Node2D

signal score_updated(new_score)
signal wallet_updated(new_wallet)
signal multiplier_updated(new_multiplier)

@onready var player := $Player
@onready var rand_gen := $RandomGenerator

@onready var background := $ParallaxBackground
@onready var gui := $CanvasLayer/GUI

@onready var mult_timer := $MultiplierTimer


@onready var anim_play := $AnimationPlayer

var score := 0: set = set_score
var wallet := 0: set = set_wallet
var multiplier := 1: set = set_multiplier

func _ready() -> void:
	get_tree().set_pause(false)
	
	BackGroundMusic.set_stream(
		load(Data.levelm_dir + '/' + Data.levelmusic[0]))
	BackGroundMusic.play()
	
	score_updated.connect(Callable(gui, "_on_score_updated"))
	wallet_updated.connect(Callable(gui, "_on_wallet_updated"))
	multiplier_updated.connect(Callable(gui, "_on_multiplier_updated"))
	
	player.player_hitted.connect(Callable(self, "_on_player_hitted"))
	player.player_hitted.connect(Callable(gui, "_on_player_hitted"))
	rand_gen.state_changed.connect(Callable(self, "_on_state_changed"))
	gui.respawn_triggerd.connect(Callable(self, "_on_respawn_triggerd"))
	
	await anim_play.animation_finished

func _physics_process(delta: float) -> void:
	background.parallax.motion_offset.x = clamp(
		background.parallax.motion_offset.x - player.linear_velocity.x / 10,
		-1080, 1080)

func set_score(points : int) -> void:
	score = points
	emit_signal("score_updated", score)

func set_wallet(coins : int) -> void:
	wallet = coins
	emit_signal("wallet_updated", wallet)

func set_multiplier(new_mult : int) -> void:
	if new_mult <= 8:
		multiplier = new_mult
		emit_signal("multiplier_updated", multiplier)
	mult_timer.start()

func _on_player_hitted() -> void:
	get_tree().set_pause(true)
	
	if UserData.score_record < int(score):
		UserData.score_record = int(score)
	UserData.wallet += wallet + score/100  
	
	SaveLoad.save_game()

func _on_state_changed() -> void:
	anim_play.play("glitch")

func _on_respawn_triggerd() -> void:
	get_tree().set_pause(false)
	player.state_machine.transition_to("Respawn")

func _on_MultiplierTimer_timeout() -> void:
	multiplier = 1
	emit_signal("multiplier_updated", multiplier)
