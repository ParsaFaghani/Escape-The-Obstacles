extends State
class_name PlayerState


var player: CharacterBody2D


func _ready() -> void:
	await owner.ready
	player = owner
