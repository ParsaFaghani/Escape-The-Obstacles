extends Node


# ------------------main----------------

@onready var play : Dictionary = {
	0 : "Play",
	1 : "شروع"
}
@onready var Customize : Dictionary = {
	0 : "Customize",
	1 : "شخصی سازی"
}
@onready var settings : Dictionary = {
	0 : "Settings",
	1 : "تنظیمات"
}
@onready var about : Dictionary = {
	0 : "About",
	1 : "درباره"
}

#--------------------customize---------------

@onready var AdsButton : Dictionary = {
	0 : "More Coin",
	1 : "دریافت سکه"
}
@onready var exit : Dictionary = {
	0 : "Exit",
	1 : "خروج"
}
@onready var unlock_background : Dictionary = {
	0 : "unlock background",
	1 : "خرید پس زمینه"
}
@onready var close : Dictionary = {
	0 : "Close",
	1 : "بستن"
}

#--------------------settings--------------

@onready var volume : Dictionary = {
	0 : "Volume",
	1 : "صدا"
}
@onready var effects : Dictionary = {
	0 : "Effects",
	1 : "صدای دکمه ها"
}
@onready var Music : Dictionary = {
	0 : "Music",
	1 : "اهنگ"
}

#----------------game_play----------------------

@onready var game_pause : Dictionary = {
	0 : "Game Pause!",
	1 : "بازی متوقف شد!"
}
@onready var Eraser : Dictionary = {
	0 : "Eraser",
	1 : "پاک کن!"
}
@onready var Coin : Dictionary = {
	0 : "Coin",
	1 : "سکه"
}
@onready var Shield : Dictionary = {
	0 : "Shield",
	1 : "سپر"
}
@onready var Star : Dictionary = {
	0 : "Star",
	1 : "ستاره"
}
@onready var Eraser_txt : Dictionary = {
	0 : "Avoid this",
	1 : "ازش فرار کن!"
}
@onready var Coin_txt : Dictionary = {
	0 : "Collect them",
	1 : "بگیرشون!"
}
@onready var Shield_txt : Dictionary = {
	0 : "Keep you safe",
	1 : "محافظ"
}
@onready var Star_txt : Dictionary = {
	0 : "Score x2 (max x8)",
	1 : "امتیاز بیشتر"
}
@onready var next : Dictionary = {
	0 : "Next",
	1 : "بعدی"
}

#-------------------END Screen--------------------------
@onready var record_text : Dictionary = {
	0 : "Your record: %012d",
	1 : "%012d : ﺯﺎﯿﺘﻣﺍ ﻦﯾﺮﺘﺸﯿﺑ"
}
@onready var Retry : Dictionary = {
	0 : "Retry",
	1 : "شروع دوباره"
}
@onready var Exit : Dictionary = {
	0 : "Retry",
	1 : "شروع دوباره"
}
