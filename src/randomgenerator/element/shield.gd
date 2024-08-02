extends Element

func on_body_entered(player : Player) -> void:
	var tween = create_tween()
	sfx.play()
	collision_shape.call_deferred("set_disabled", true)
	tween.tween_property(sprite, "scale",Vector2(2.0, 2.0), 0.5)
	tween.tween_property(sprite, "global_position",player.get_global_position(), 0.5)
	tween.play()
	if not player.is_shielded or not player.shield_timer.is_stopped():
		player.shield_timer.stop()
		player.is_shielded = true
		player.anim_tree["parameters/playback"].travel("shielded")
	await tween.finished
	set_visible(false)
