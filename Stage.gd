extends Node2D



func _ready():
	for node in get_children():
		if node is Area2D:
			node.connect("body_entered", self, '_on_Area2D_body_entered', [node.name])
			node.connect("body_exited", self, '_on_Area2D_body_exited', [node.name])

func _process(delta):
	pass

func _on_Area2D_body_entered(body,area_name):
	if body.name == 'Amon':
		get_node(area_name + '/Camera').current = true
func _on_Area2D_body_exited(body,area_name):
	get_node(area_name + '/Camera').current = false
