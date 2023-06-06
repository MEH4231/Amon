extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_Area2D_body_entered(body):
	if body.name.left(4) == 'Amon':
		body.HP += 5
		body.check_stats()
		queue_free()
