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
