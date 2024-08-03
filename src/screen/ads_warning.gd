extends AcceptDialog

signal can_show_ads()

@onready var label := $RichTextLabel
@onready var tween : Tween

var ads_warning := "Take a look at this ad to %s"

func download(link, path):
	var http = HTTPRequest.new()
	add_child(http)
	http.connect("request_completed", Callable(self, "_http_request_completed"))

	http.set_download_file(path)
	var request = http.request(link)
	if request != OK:
		push_error("Http request error")

func _http_request_completed(result, _response_code, _headers, _body):
	if result != OK:
		push_error("Download Failed")
	else:
		var texture = preload("res://assets/banner.jpeg")
	remove_child($HTTPRequest)

func _on_ads_warning_triggered(string : String) -> void:
	tween = create_tween()
	var text : String
	if UserData.ads:
		text = ads_warning % string
	else:
		if UserData.lang:
			text = """[right]ﺪﯿﻨﮑﯿﻣ ﺖﻓﺎﯾﺭﺩ ﻪﮑﺳ ﻎﯿﻠﺒﺗ ﻥﺪﯾﺩ ﺎﺑ[/right]
[right]ﻪﮑﺳ 300 ﻎﯿﻠﺒﺗ ﺮﻫ[/right]"""
		else:
			text = "Noob... do you wanna respawn?"
	label.parse_bbcode(text)
	if UserData.lang:
		popup()
	else:
		label.visible = 0
		popup()
		tween.tween_property(label, "percent_visible", 1, 0.5)
		tween.play()

