extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


func _on_death_animRIP_screen_timeout():
	if $"/root/Main/Menu/Game/Amon".dead == true:
		$Camera2D.current = true
		$"/root/Main/Menu/Game".queue_free()
		self.visible = true




func _on_rip_button_pressed():
		self.visible = false 
		$'/root/Main/Menu/Backround'.visible = !$'/root/Main/Menu/Backround'.visible
