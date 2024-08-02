extends Node


func save_game():
	var save_game := FileAccess.open_encrypted_with_pass("user://gamedata.bin", FileAccess.WRITE, OS.get_unique_id())
	#var save_game := FileAccess.open("user://gamedata.bin", FileAccess.WRITE)
	var save_nodes = get_tree().get_nodes_in_group("UserData")
	for node in save_nodes:
		if node.name.is_empty():
			print("persistent node '%s' is not an instanced scene, skipped" % node.name)
			continue
	
		if !node.has_method("save"):
			print("persistent node '%s' is missing a save() function, skipped" % node.name)
			continue
	
		var node_data = node.save()
		save_game.store_line(JSON.new().stringify(node_data))
	save_game.close()


func load_game():
	if not FileAccess.file_exists("user://gamedata.bin"):
		return
	var save_game := FileAccess.open_encrypted_with_pass("user://gamedata.bin", FileAccess.READ, OS.get_unique_id())
	var test_json_conv = JSON.new()
	test_json_conv.parse(save_game.get_line())
	var node_data = test_json_conv.get_data()
	var objects = get_tree().get_nodes_in_group("UserData")
	for object in objects:
		for i in node_data.keys():
			if i == "node":
				continue
			object.set(i, node_data[i])
	save_game.close()
