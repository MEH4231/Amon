extends TileMap



func _ready():
	pass

func get_input():
	var down = Input.is_action_pressed('ui_down')
	if down:
		collision_layer = false
		$"platform_down_timer".start(0.2)
func _process(delta):
	get_input()


func _on_platform_down_timer_timeout():
	collision()

func collision():
	collision_layer = true
