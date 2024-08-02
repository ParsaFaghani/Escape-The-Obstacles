extends Node2D

signal score_updated(new_score)
signal wallet_updated(new_wallet)
signal multiplier_updated(new_multiplier)
signal update_tutorial()

@onready var player := $Player
@onready var rand_gen := $RandomGenerator

@onready var background := $ParallaxBackground
@onready var gui := $CanvasLayer/GUI

@onready var mult_timer := $MultiplierTimer

@onready var tween := $Tween
@onready var anim_play := $AnimationPlayer

@onready var tutorial_screen := $CanvasLayer/TutorialScreen

@onready var raycast := $RayCast2D

var score := 0 :
	set(value): set_score(value)
var wallet := 0 :
	set(value): set_wallet(value)
var multiplier := 1 : 
	set(value): set_multiplier(value)


func _ready() -> void:
	get_tree().set_pause(false)
	
	BackGroundMusic.set_stream(
		load(Data.levelm_dir + '/' + Data.levelmusic[0]))
	BackGroundMusic.play()
	
	score_updated.connect(gui._on_score_updated)
	wallet_updated.connect(gui._on_wallet_updated)
	multiplier_updated.connect(gui._on_multiplier_updated)
	update_tutorial.connect(tutorial_screen._on_UpdateTutorial)
	
	player.player_hitted.connect(_on_player_hitted)
	# rand_gen.state_changed.connect(_on_state_changed)

func _physics_process(delta: float) -> void:
	background.parallax.motion_offset.x = clamp(background.parallax.motion_offset.x - player.linear_velocity.x / 10, -1080, 1080)
	
	if not raycast.is_enabled():
		return
	
	raycast.force_raycast_update()
	if raycast.is_colliding():
		emit_signal("update_tutorial")
		raycast.set_enabled(false)

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
	
	emit_signal("update_tutorial")

func _on_state_changed() -> void:
	anim_play.play("glitch")
	if tutorial_screen.phase == 0:
		await anim_play
		emit_signal("update_tutorial")

func _on_MultiplierTimer_timeout() -> void:
	multiplier = 1
	emit_signal("multiplier_updated", multiplier)
