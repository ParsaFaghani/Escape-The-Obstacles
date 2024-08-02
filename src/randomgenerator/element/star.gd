extends Element


func on_body_entered(player : Player) -> void:
	var tween = create_tween()
	sfx.play()
	collision_shape.call_deferred("set_disabled", true)
	tween.tween_property(sprite, "scale",Vector2(0.5, 0.5), 0.5)
	tween.tween_property(sprite, "global_position", player.get_global_position(), 0.5)
	tween.play()
	await tween.finished
	rgen.level.multiplier *= 2
	set_visible(false)
