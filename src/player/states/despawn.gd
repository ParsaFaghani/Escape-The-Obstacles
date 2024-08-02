extends PlayerState

@onready var timer := $Timer

func enter() -> void:
	player.eraser_det.set_collision_mask_value(0, false)
	player.linear_velocity = Vector2.ZERO
	player.is_despawning = true
	timer.start()
	player.anim_tree["parameters/playback"].travel("despawn")
	player.despawn_sfx.play()
	await timer.timeout
	
	player.emit_signal("player_hitted")
