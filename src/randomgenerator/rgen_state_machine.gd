extends StateMachine


func _ready() -> void:
	await owner.ready
