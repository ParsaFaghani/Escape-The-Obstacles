extends State
class_name RGenState


var rgen: Node2D


func _ready() -> void:
	await owner.ready
	rgen = owner

func check_off_screen(x : int, distance : int, max_x : int) -> int:
	if x + distance > max_x:
		return x + distance - max_x
	
	elif x + distance <= 0:
		return x + distance + max_x
	
	return x + distance

func add_element(x : int, y: int, element : PackedScene) -> Area2D:
	print(element)
	var new_element : Area2D = element.instantiate()
	print(new_element)
	new_element.set_position(Vector2(x, y))
	new_element.velocity = rgen.velocity
	rgen.add_child(new_element)
	return new_element

