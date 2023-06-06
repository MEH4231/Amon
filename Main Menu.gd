extends Control

var Game = preload('res://Game.tscn')
var Amon = preload('res://Amon.tscn')
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().paused = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func Game():
	var b = Game.instance()
	add_child(b)

func toggle_menu_visibility():
	$Backround.visible = !$Backround.visible


func _on_Start_pressed():
	Game()
	toggle_menu_visibility()
	load_game()

func load_game():
	var new_file = File.new()
	var error = new_file.open("user://savegame.save", File.READ)
	if error == OK:
		var data = parse_json(new_file.get_as_text())
		get_child(2).Amon_location = data.get('global_pos_amon')
	else:
		get_child(2).Amon_location = '(1700, 800)'
	new_file.close()

func _on_Exit_pressed():
	get_tree().quit()

func toggleexit():
	get_child(0).visible = !get_child(0).visible
	$Backround.visible = !$Backround.visible

func _on_Discord_pressed():
	OS.shell_open("https://discord.gg/wekchmzZNk")


func _on_Settings_button_pressed():
	$Backround/Settings_button/Settings.visible = !$Backround/Settings_button/Settings.visible
	$Backround/Settings_button/Settings.set_values()


func _on_godot_license_pressed():
	OS.shell_open("https://godotengine.org/")
