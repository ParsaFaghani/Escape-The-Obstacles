extends PopupPanel

@onready var close_button = $Control/CloseButton
@onready var about_Label = $Control/RichTextLabel

@onready var button_sfx := $ButtonSFX

var text = """created by DarkCoder and modafe

mygithub ([color=#0000EE][url]https://github.com/FDarkCoder[/url][/color])
open source game 

created by GODOT Engine

[MIT]
"""

var text_fa = """[right]ﯽﻧﺎﻘﻓ ﺎﺳﺭﺎﭘ : ﻩﺪﻨﻫﺩ ﻪﻌﺳﻮﺗ ﻭ ﺲﯾﻮﻧ ﻪﻣﺎﻧﺮﺑ[/right]
[right]ﯽﺸﯾﻭﺭﺩ ﺪﻤﺤﻣ : ﯼﺯﺎﺑ ﺡﺍﺮﻃ[/right]
[right]ﺩﺭﺍﺩ ﺭﺍﺮﻗ MIT ﺯﻮﺠﻣ ﺖﺤﺗ ﻭ ﺖﺳﺍ ﺯﺎﺑ ﻦﺘﻣ ﯼﺯﺎﺑ ﻦﯾﺍ[/right]
[right][color=#0000EE][url]https://github.com/FDarkCoder/Escape-The-Obstacles[/url][/color] : ﺏﺎﻫ ﺖﯿﮔ ﮏﻨﯿﻟ [/right]
[right]ﺖﺳﺍ ﻩﺪﺷ ﻪﺘﺧﺎﺳ GODOT ﯼﺯﺎﺳ ﯼﺯﺎﺑ ﺭﻮﺗﻮﻣ ﺎﺑ ﯼﺯﺎﺑ ﻦﯾﺍ[/right]"""

func _ready():
	if UserData.lang:
		close_button.text = Lang.close[1]
		about_Label.text = text_fa
	elif UserData.lang == 0:
		close_button.text = Lang.close[0]
		about_Label.text = text

func _on_CloseButton_pressed() -> void:
	button_sfx.play()
	set_visible(false)
