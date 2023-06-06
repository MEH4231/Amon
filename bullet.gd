extends RigidBody2D

var velocity = Vector2()
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
const BULLET_VELOCITY = 500.0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _physics_process(delta):
	velocity.y = BULLET_VELOCITY
	
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func start(pos,dir):
	global_position = pos
	rotation = 0

func _on_Bullet_body_shape_entered(body_id, body, body_shape, local_shape):
	queue_free()
