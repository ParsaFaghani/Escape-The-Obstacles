extends Node

@onready var splash_screen = "res://src/screen/SplashScreen.tscn"
@onready var main_screen = "res://src/screen/MainScreen.tscn"
@onready var customization_screen := "res://src/screen/CustomizationScreen.tscn"
@onready var level := "res://src/level/Level.tscn"
@onready var tutorial := "res://src/level/Tutorial.tscn"
@onready var os := OS.get_name()

@onready var info_string_name_fa : Dictionary = {
	0: "ﮒﺮﻣ ﺩﺮﻣ",
	1: "ﻭﺩﻮﮔ",
	2: "ﯽﮑﯿﮐ",
	3: "ﺱﺁ",
	4: "ﺭﻭﺩﺭﺍ",
	5: "ﻢﻠﻫ",
	6: "ﭻﯾﺍ",
	7: "ﺖﮐﻮﺘﮐﺍ",
	8: "ﻮﻨﮔ",
	9: "ﺲﮐﺎﺗ",
	10: "ﺎﺳﻮﻓ",
	11: "ﺮﻔﯿﻠﮔ",
	12: "ﺰﺑ"
}

@onready var info_string_name : Dictionary = {
	0: "Deathguy",
	1: "Godot",
	2: "Kiki",
	3: "Ace",
	4: "Ardour",
	5: "Helm",
	6: "Itch",
	7: "Octocat",
	8: "Gnu",
	9: "Tux",
	10: "Fossa",
	11: "Glyphr",
	12: "goat"
}

@onready var info_string_url : Dictionary = {
	0: "https://amdotblacksheep.itch.io/deathguy",
	1: "https://godotengine.org/",
	2: "https://krita.org/",
	3: "https://www.aseprite.org/",
	4: "https://ardour.org/",
	5: "https://tytel.org/helm/",
	6: "https://itch.io/",
	7: "https://github.com/",
	8: "http://www.gnu.org/gnu/gnu.html",
	9: "https://www.linuxfoundation.org/",
	10: "https://ubuntu.com/",
	11: "https://www.glyphrstudio.com/",
	12: "https://amdotblacksheep.itch.io/"
}

@onready var tutorial_strings : Dictionary = {
	0 : "Hey noob! You wanna play the tutorial?"
}

@onready var ads_reward_string : Dictionary = {
	0 : "earn %d coins...beggar...",
	1 : "have a second chance... noob..."
}

@onready var fake_ads_img : Dictionary = {
	0: preload("res://icon.png"),
	1: preload("res://assets/fakeads/banner_deathguy.jpeg")
}

@onready var fake_ads_text : Dictionary = {
	0: "[b]open source game[/b]\n\nGo to check",
	# 1: "[b]Join the deathsquad on itch.io.[/b]\n\nIf you are too noob to play from your smartphone you can join the cause even from your PC."
}

@onready var fake_ads_url : Dictionary = {
	0: "https://github.com/FDarkCoder/Escape-The-Obstacles",
	1: "https://amdotblacksheep.itch.io/deathguy"
}
