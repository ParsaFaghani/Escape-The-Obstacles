extends ConfirmationDialog


signal unlocked(index)


@onready var label := $RichTextLabel
@onready var button_sfx := $ButtonSFX
@onready var error_sfx := $ErrorSFX
@onready var tween : Tween

var node : Node
var method : String
var index : int
var cost : int
var text := "You're in the mood for shopping... this requires %d coins. Do you want to buy it?"
var text_fa := " %d  :ﻪﮑﺳ ﺩﺍﺪﻌﺗ ؟ﺪﯾﺮﺨﺑ ﺍﺭ ﻥﺍ ﻪﮐ ﺪﯿﻠﯾﺎﻣ ﺎﯾﺍ"
func _ready() -> void:
	tween = create_tween()
	get_cancel_button().pressed.connect(Callable(self, "_on_UnlockScreen_cancelled"))
	get_cancel_button().pressed.connect(Callable(self, "_on_UnlockScreen_cancelled"))

func _on_unlock_pressed(
	new_node : Node, 
	new_method : String, 
	new_index : int, 
	new_cost : int
	) -> void:
	
	if node:
		unlocked.disconnect(Callable(node, method))
	
	unlocked.connect(Callable(new_node, new_method))
	
	node = new_node
	method = new_method
	index = new_index
	cost = new_cost
	label.parse_bbcode(text_fa % cost)
	label.visible = 0
	
	popup()
	tween.tween_property(label, "percent_visible", 1, 0.5)
	tween.play()

func _on_UnlockScreen_confirmed() -> void:
	if UserData.wallet >= cost:
		emit_signal("unlocked", index)
		button_sfx.play()
	else:
		error_sfx.play()

func _on_UnlockScreen_cancelled() -> void:
	if not button_sfx.is_playing():
		button_sfx.play()
