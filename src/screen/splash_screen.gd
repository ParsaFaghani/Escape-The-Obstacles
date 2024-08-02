extends Control

@onready var anim_play := $AnimationPlayer

func _ready() -> void:
	await anim_play.animation_finished
	get_tree().change_scene_to_packed(preload("res://src/screen/MainScreen.tscn"))
