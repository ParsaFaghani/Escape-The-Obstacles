extends Area2D
class_name Element

signal next_triggered()

@onready var rgen := get_parent()
@onready var collision_shape := $CollisionShape2D
@onready var sprite := $Sprite2D
@onready var sfx := $SFX



@export var _gravity := -8.0

var velocity := Vector2.ZERO
var trigger_pos := -1
var is_ := true
var tween : Tween


func _physics_process(delta: float) -> void:
	tween = get_tree().create_tween()
	var current_ypos := get_global_position().y
	
	if is_ and current_ypos <= 1280:
		rgen.level.score += 1 * rgen.level.multiplier
		is_ = false
	
	if (next_triggered.is_connected(Callable(rgen, "generate")) and 
	current_ypos <= trigger_pos):
		emit_signal("next_triggered")
		next_triggered.disconnect(Callable(rgen, "generate"))
	
	if current_ypos <= 0:
		queue_free()
	
	velocity.y = clamp(velocity.y + _gravity * delta, -800.0, 0.0)
	translate(velocity * delta)

func _on_body_entered(body: Node) -> void:
	if body is Player:
		on_body_entered(body)

func on_body_entered(player : Player) -> void:
	pass
