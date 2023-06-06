extends RigidBody2D

#export (int) var rotate_speed = 250

var velocity = Vector2()
var lwall
var rwall

# Called when the node enters the scene tree for the first time.
func _ready():
	#velocity.x += rotate_speed
	$"Timer".start(6)


func start(pos,dir):
	position = pos
	rotation = dir


func _on_Timer_timeout():
	queue_free()

func _process(delta):
	pass

func _on_Area2D_body_entered(body):
	if body.name.left(3) == '@Bu' or body.name.left(3) == 'Bul':
		queue_free()
