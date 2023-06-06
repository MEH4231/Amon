extends Node2D

var Amon = preload('res://Amon.tscn')
var spider = preload('res://Spider.tscn')
var map = preload('res://Map_detection.tscn')
var save = preload('res://Save_Room.tscn')
var light = preload('res://light.tscn')
var Ammo = preload('res://Ammo.tscn')
var Lives = preload('res://Lives.tscn')
var HP = preload('res://HP.tscn')
var Amon_location = '1700,800'



func _ready():
	load_level()
	$Timer.start(0.001)

func load_game():
	var new_file = File.new()
	var error = new_file.open("user://savegame.save", File.READ)
	if error == OK:
		var data = parse_json(new_file.get_as_text())
		for node in get_children():
			if node.name == 'Amon' or node.name.left(5) == '@Amon':
				node.HP = data.get('amon_HP')
				node.lives = data.get('amon_lives')
				node.ammo_counter = data.get('amon_ammo')
				node.check_stats()
				if node.HP == null:
					node.HP = ('10')
				if node.lives == null:
					node.lives = ('3')
				if node.ammo_counter == null:
					node.ammo_counter = ('20')

	new_file.close()

func load_amon():
	var amon = Amon.instance()
	amon.start(Amon_location)
	add_child(amon)
	load_game()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func load_level():
	var enemyspider_detect = $'/root/Main/Menu/Game/Stage/enemies'.get_used_cells_by_id(0) 
	var save_room_detect = $'/root/Main/Menu/Game/Stage/places'.get_used_cells_by_id(1) 
	var map_detect = $'/root/Main/Menu/Game/Stage/places'.get_used_cells_by_id(0) 
	var light_detect = $'/root/Main/Menu/Game/Stage/decorations'.get_used_cells_by_id(0) 
	var Ammo_detect = $'/root/Main/Menu/Game/Stage/Items'.get_used_cells_by_id(0) 
	var Lives_detect = $'/root/Main/Menu/Game/Stage/Items'.get_used_cells_by_id(1) 
	var HP_detect = $'/root/Main/Menu/Game/Stage/Items'.get_used_cells_by_id(2) 
	
	for tile in enemyspider_detect:
		var s = spider.instance()
		s.global_position = $'/root/Main/Menu/Game/Stage/enemies'.map_to_world(tile)
		add_child(s)

	for tile in map_detect:
		var m = map.instance()
		m.global_position = $'/root/Main/Menu/Game/Stage/places'.map_to_world(tile)
		$'/root/Main/Menu/Game/Stage/AreaStuff'.add_child(m)
 
	for tile in save_room_detect:
		var s = save.instance()
		s.global_position = $'/root/Main/Menu/Game/Stage/places'.map_to_world(tile)
		$'/root/Main/Menu/Game/Stage/AreaStuff'.add_child(s)

	for tile in light_detect:
		var l = light.instance()
		l.global_position = $'/root/Main/Menu/Game/Stage/decorations'.map_to_world(tile)
		add_child(l)

	for tile in Ammo_detect:
		var A = Ammo.instance()
		A.global_position = $'/root/Main/Menu/Game/Stage/Items'.map_to_world(tile)
		add_child(A)

	for tile in Lives_detect:
		var L = Lives.instance()
		L.global_position = $'/root/Main/Menu/Game/Stage/Items'.map_to_world(tile)
		add_child(L)

	for tile in HP_detect:
		var H = HP.instance()
		H.global_position = $'/root/Main/Menu/Game/Stage/Items'.map_to_world(tile)
		add_child(H)


func _on_Timer_timeout():
	load_amon()
