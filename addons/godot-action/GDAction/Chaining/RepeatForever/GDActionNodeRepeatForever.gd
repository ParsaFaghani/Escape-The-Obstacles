class_name GDActionNodeRepeatForever extends GDActionNodeInstant

var action_repeat


func get_class() -> String:
	return "GDActionNodeRepeatForever"


func _init(action, key, node):
	super(action, key, node)
	pass


func start_repeat(action_repeat, delay: float , speed: float):
	self.action_repeat = action_repeat
	self.delay = delay
	self.speed = speed

	_reset_value()
	_run()


func _start_action():
	_run_action_repeat()


func _on_action_object_completed(action_node):
	action_node.disconnect("finished", Callable(self, "_on_action_object_completed"))
	_run_action_repeat()


func _run_action_repeat():
	if not is_instance_valid(node):
		_finished()
		return
	
	var action_node = action_repeat._start_from_action(node, key, speed)
	
	if not action_node.is_connected("finished", Callable(self, "_on_action_object_completed")):
		action_node.connect("finished", Callable(self, "_on_action_object_completed"))

