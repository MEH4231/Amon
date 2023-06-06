extends KinematicBody2D

export (int) var gravity = 1200
export var speed = Vector2(150.0, 550.0)

var ball_count = 0
var velocity = Vector2()

var amon

const Ballet = preload("res://ball.tscn")

func Ball_throw():
	var ballet = Ballet.instance()
	ballet.start(self.global_position + Vector2(0,0),0)
	if amon:
		var amon_side = position - amon.position
		if amon_side.x < 0:
			ballet.set_applied_torque(10)
		if amon_side.x > 0:
			ballet.set_applied_torque(-10)
	get_parent().add_child(ballet)
func _ready():
	Balls_shoot_timer()
func Balls_shoot_timer():
	$"Timer".start(2)
	$"animation_timer".start(1.3)

func _physics_process(delta):
	velocity.y += gravity * delta
	velocity.x = speed.x
	velocity = move_and_slide(velocity, Vector2(0, -1))
	if is_on_wall():
		speed = -speed

func _on_Area2D_body_entered(body):
	if body.name.left(3) == '@Bu' or body.name.left(3) == 'Bul':
		queue_free()

func _on_Timer_timeout():
	Ball_throw()
	$spider_sprite.animation = 'no_ball'
	$spider_sprite.play()



func _on_animation_timer_timeout():
	$spider_sprite.animation = 'ball'
	$spider_sprite.play()


func _on_DetectAmonArea2D_body_entered(body):
	if body.name.left(4) == 'Amon' or body.name.left(5) == '@Amon':
		amon = body
