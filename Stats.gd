extends Node2D

#var ammo_counter = 20

func ready():
	$'/root/Main/Menu/Game/Stage/Area/Camera'.current = true

func _physics_process(delta):
	pass


func _on_invince_frames_timeout():
	get_parent().invince_frames = false
