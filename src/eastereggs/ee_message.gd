extends RichTextLabel

var string := "[shake rate=5 level=100][rainbow freq=0.2 sat=10 val=20]   Escape\n     The\n OBSTACLES[/rainbow][/shake]"

func _on_easteregg_triggered() -> void:
	set_bbcode(string)
