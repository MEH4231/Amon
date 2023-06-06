extends Area2D



func _ready():
	for node in get_children():
		if node is Area2D:
			node.connect("body_entered", self, '_on_Area2D_area_entered', [node.name])
			node.connect("body_exited", self, '_on_Area2D_area_exited', [node.name])

func _process(delta):
	pass



func _on_Area2D_area_entered(area):
	$Camera.current = true


func _on_Area2D_area_exited(area):
	$Camera.current = false


func _on_Button_pressed():
	var save_nodes = get_tree().get_nodes_in_group("persist")
	for i in save_nodes:
		save_game()


func save_game():
	var save_game = File.new()
	save_game.open("user://savegame.save", File.WRITE)
	var save_nodes = get_tree().get_nodes_in_group("persist")
	for node in save_nodes:
		var node_data = node.call("save")
		save_game.store_line(to_json(node_data))
	save_game.close()


func _on_Button_button_down():
	var save_nodes = get_tree().get_nodes_in_group("persist")
	for i in save_nodes:
		save_game()
