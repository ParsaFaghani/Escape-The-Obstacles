extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	var data = get_tree().get_nodes_in_group("Persist")
	print(data)
