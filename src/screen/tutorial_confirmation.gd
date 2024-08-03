extends ConfirmationDialog

@onready var label := $RichTextLabel

func _on_tutorial_triggered() -> void:
	var tween = create_tween()
	label.parse_bbcode(Main.tutorial_strings[0])
	label.visible = 0
	popup()
	tween.tween_property(label, "percent_visible",1, 1.5)
	tween.play()
