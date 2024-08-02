extends ConfirmationDialog

@onready var label := $RichTextLabel

func _on_tutorial_triggered() -> void:
	var tween = Tween.new()
	label.set_bbcode(Main.tutorial_strings[0])
	label.set_percent_visible(0)
	popup()
	tween.interpolate_property(
		label, "percent_visible", 0, 1, 1.5, 
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()
