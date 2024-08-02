@tool

class_name AweSplashScreen extends Node2D

signal finished

@export var is_skip_appear_transition: bool = false
@export var is_skip_disappear_transition: bool = false

@onready var aspect_node: AspectNode: get = _get_aspect_node
@onready var outline_frame: Control = null :
	set(value): _get_outline_frame()

var origin_size: Vector2: get = _get_origin_size


### BUILD IN ENGINE METHODS ====================================================

func _ready():
	var outline_frame = self.outline_frame
	if outline_frame != null:
		self.outline_frame.visible = false


func _get_configuration_warnings():
	var warnings = PackedStringArray()
	if not self.outline_frame:
		warnings.append("%s is missing a AspectNode" % name)
		warnings.append("You can add AspectNode from \"Instance child scene\" button ")
		warnings.append("or you can drag and drop AspectNode.tscn from addons/awesome_splash/")
	return "\n".join(warnings)

### PUBLIC METHODS =============================================================

func update_aspect_node_frame(parent_size: Vector2):
	var aspect_node = self.aspect_node
	if aspect_node == null:
		return
	aspect_node.parrent_size = parent_size


func load_texture(path: String) -> ImageTexture:
	var image = Image.new()
	var stream_texture = load(path)
	var texture = ImageTexture.new()
	if stream_texture == null:
		print("%s is load fail" % path)
		return texture
	image = stream_texture.get_data()
	false # image.lock() # TODOConverter3To4, Image no longer requires locking, `false` helps to not break one line if/else, so it can freely be removed
	
	texture.create_from_image(image) #,0
	return texture

### PRIVATE METHODS ============================================================


func _get_aspect_node() -> AspectNode:
	for child in get_children():
		if child is AspectNode:
			return child
	return null


func _get_outline_frame() -> Control:
	var aspect_node = self.aspect_node
	
	if aspect_node == null:
		return null
	
	for child in aspect_node.get_children():
		if child.name == "OutlineFrame":
			return child
	return null


func _get_origin_size() -> Vector2:
	var aspect_node = self.aspect_node
	if aspect_node == null:
		return Vector2.ZERO
	return aspect_node.origin_size


func finished_animation():
	emit_signal("finished")


func skip():
	emit_signal("finished")


### VIRTUAL FUNC ===============================================================

func _get_name() -> String:
	return ""


func play():
	pass
