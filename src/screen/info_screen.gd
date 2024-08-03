extends Window


@onready var label := $RichTextLabel
@onready var tween : Tween

# ﯽﻨﮐ ﺭﺎﺘﻓﺭ ﺏﻮﺧ ﺵﺎﻫﺎﺑ ﻩﺮﺘﻬﺑ ﺖﺴﻫ ﻮﻨﮔ ﻥﻭﺍ ﻢﺳﺍ
var info_string_fa := """[right].ﺖﺴﻫ %s ﻥﻭﺍ ﻢﺳا [/right]
[right]!ﯽﻨﮐ ﺭﺎﺘﻓﺭ ﺏﻮﺧ ﺵﺎﻫﺎﺑ ﻩﺮﺘﻬﺑ[/right]""" #\n\n[color=#0000EE][url]%s[/url][/color]"
var info_string := "He is %s.\n\nHe's a friend of mine so treat him well"

func _on_info_triggered(type : int) -> void:
	tween = create_tween()
	if UserData.lang:
		label.parse_bbcode(info_string_fa % Main.info_string_name_fa[type])
	else:
		label.parse_bbcode(info_string % Main.info_string_name[type])
		label.visible = 0
		tween.tween_property(label, "percent_visible", 1, 1.5)
		tween.play()
	#label.set_bbcode(
	#	info_string % [Main.info_string_name[type], 
	#	Main.info_string_url[type]])
	# label.set_percent_visible(0)
	popup()
	# tween.interpolate_property(
	# 	label, "percent_visible", 0, 1, 1.5, 
	# 	Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	# tween.start()

func _on_Meta_clicked(meta) -> void:
	OS.shell_open(meta)
