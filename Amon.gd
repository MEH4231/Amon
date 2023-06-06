extends KinematicBody2D

export (int) var run_speed = 300
export (int) var jump_speed = -400
export (int) var gravity = 1200

var dead = false
var rightv = false
var leftv = false
var jump_count = 0
var velocity = Vector2()
var jumping = false
var canshoot = true
var HP = 10
var invince_frames = false
var lives = 3
var ammo_counter = 20
const JUMP_SPEED = -500
const Bullet = preload("res://bullet.tscn")
const Bullet2 = preload("res://bullet2.tscn")
const RIP1 = preload("res://RIP.tscn")


func shoot():
	if canshoot == true:
		if ammo_counter >0:
			shoot_timer()
			var bullet = Bullet.instance()
			if $"Amon-Sprite".animation == 'walking-right-gun':
				bullet.start($Position2D2.global_position, 0)
				canshoot = false
				ammo_counter -= 1
				change_text()
			if $"Amon-Sprite".animation == 'idle-right-gun':
				bullet.start($Position2D2.global_position, 0)
				canshoot = false
				ammo_counter -= 1
				change_text()
			get_parent().add_child(bullet)
func shoot2():
	if canshoot == true:
		if ammo_counter >0:
			shoot_timer()
			var bullet2 = Bullet2.instance()
			if $"Amon-Sprite".animation == 'walking-left-gun':
				bullet2.start($Position2D1.global_position, 0)
				canshoot = false
				ammo_counter -= 1
				change_text()
			if $"Amon-Sprite".animation == 'idle-left-gun':
				bullet2.start($Position2D1.global_position, 0)
				canshoot = false
				ammo_counter -= 1
				change_text()
			get_parent().add_child(bullet2)
		
func shoot_timer():
	$"Shoot_timer".start(0.3)

func _ready():
	change_text()

func get_input():
	velocity.x = 0
	var right = Input.is_action_pressed('ui_right')
	var rightrelease = Input.is_action_just_released('ui_right')
	var left = Input.is_action_pressed('ui_left')
	var leftrelease = Input.is_action_just_released('ui_left')
	var jump = Input.is_action_just_pressed('ui_select')
	var shootanimation = Input.is_action_pressed('ui_c')
	var shootanimationrelease = Input.is_action_just_released('ui_c')

	if jump and is_on_floor():
		if dead == false:
			jumping = true
			velocity.y = jump_speed
	if right:
		if dead == false:
			rightv = true
			leftv = false
			velocity.x += run_speed
			if shootanimation:
				$"Amon-Sprite".animation = 'walking-right-gun'
				$"Amon-Sprite".play()
				shoot()
			else:
				$"Amon-Sprite".animation = 'walking-right'
				$"Amon-Sprite".play()
	if rightrelease:
		if dead == false:
			if shootanimation:
				$"Amon-Sprite".animation = 'idle-right-gun'
				$"Amon-Sprite".play()
				shoot()
			else:
				$"Amon-Sprite".animation = 'idle-right'
				$"Amon-Sprite".play()
	if left:
		if dead == false:
			velocity.x -= run_speed
			leftv = true
			rightv = false
			if shootanimation:
				$"Amon-Sprite".animation = 'walking-left-gun'
				$"Amon-Sprite".play()
				shoot2()
			else:
				$"Amon-Sprite".animation = 'walking-left'
				$"Amon-Sprite".play()
	if leftrelease:
		if dead == false:
			if shootanimation:
				$"Amon-Sprite".animation = 'idle-left-gun'
				$"Amon-Sprite".play()
				shoot2()
			else:
				$"Amon-Sprite".animation = 'idle-left'
				$"Amon-Sprite".play()
	if shootanimation:
		if dead == false:
			if rightv == true:
				if right:
					$"Amon-Sprite".animation = 'walking-right-gun'
					$"Amon-Sprite".play()
					shoot()
				else:
					$"Amon-Sprite".animation = 'idle-right-gun'
					$"Amon-Sprite".play()
					shoot()
			if leftv == true:
				if left:
					$"Amon-Sprite".animation = 'walking-left-gun'
					$"Amon-Sprite".play()
					shoot2()
				else:
					$"Amon-Sprite".animation = 'idle-left-gun'
					$"Amon-Sprite".play()
					shoot2()
	if shootanimationrelease:
		if dead == false:
			if rightv == true:
					$"Amon-Sprite".animation = 'idle-right'
					$"Amon-Sprite".play()
			if leftv == true:
				$"Amon-Sprite".animation = 'idle-left'
				$"Amon-Sprite".play()


func _physics_process(delta):
	get_input()
	velocity.y += gravity * delta
	if jumping and is_on_floor():
		jumping = false
	velocity = move_and_slide(velocity, Vector2(0, -1))
	if (is_on_floor() == true):
		jump_count = 2
	if (Input.is_action_just_pressed('ui_select')):
		if dead == false:
			if (jump_count > 0):
				velocity.y = JUMP_SPEED
				jump_count -= 1

	
func start(pos):
	var cords = pos
	cords.erase(cords.find("("),1)
	cords.erase(cords.find(")"),1)
	cords.replace(cords.find(" "),1)
	var x = cords.left(cords.find(" "))
	var y = cords.right(cords.find(" "))
	cords = Vector2(x,y)
	global_position = cords




func _on_Shoot_timer_timeout():
	canshoot = true


func change_text():
	$'/root/Main/Menu/Game/Amon/Stats/ammo/ammo-count'.text = str(ammo_counter)
	$'/root/Main/Menu/Game/Amon/Stats/lives/lives_label'.text = str(lives)

	
func _on_Area2D_body_entered(body):
	if body.name.left(4) == '@bal' or body.name.left(4) == 'ball':
		if HP >= 0:
			lose_HP()
	if body.name.left(6) == '@Spide' or body.name.left(6) == 'Spider':
		if lives > 0:
			lose_life()
		if lives <= 0:
			HP = 1
			invince_frames = false
			lose_HP()
			death()
	if HP <= 0 and lives >= 1:
		lives -= 1
		HP = 10
	if HP <= 0 and lives <= 0:
		death()
		invince_frames = false
		lose_HP()

func lose_life():
	lives = 0

func check_HP():
	if HP > 10:
		lives += 1
		HP -= 10
	if lives > 5:
		lives = 5 
		HP = 10
	elif HP == 10:
		$"Stats/HP".animation = '10'
		$"Stats/HP".play()
	elif HP == 9:
		$"Stats/HP".animation = '9'
		$"Stats/HP".play()
	elif HP == 8:
		$"Stats/HP".animation = '8'
		$"Stats/HP".play()
	elif HP == 7:
		$"Stats/HP".animation = '7'
		$"Stats/HP".play()
	elif HP == 6:
		$"Stats/HP".animation = '6'
		$"Stats/HP".play()
	elif HP == 5:
		$"Stats/HP".animation = '5'
		$"Stats/HP".play()
	elif HP == 4:
		$"Stats/HP".animation = '4'
		$"Stats/HP".play()
	elif HP == 3:
		$"Stats/HP".animation = '3'
		$"Stats/HP".play()
	elif HP == 2:
		$"Stats/HP".animation = '2'
		$"Stats/HP".play()
	elif HP == 1:
		$"Stats/HP".animation = '1'
		$"Stats/HP".play()
	elif HP == 0:
		$"Stats/HP".animation = '0'
		$"Stats/HP".play()


func lose_HP():
	if invince_frames == false:
		HP -= 1
		if HP > 10:
			lives += 1
			HP -= 10
		elif HP == 10:
			$"Stats/HP".animation = '10'
			$"Stats/HP".play()
			invince_frames()
		elif HP == 9:
			$"Stats/HP".animation = '9'
			$"Stats/HP".play()
			invince_frames()
		elif HP == 8:
			$"Stats/HP".animation = '8'
			$"Stats/HP".play()
			invince_frames()
		elif HP == 7:
			$"Stats/HP".animation = '7'
			$"Stats/HP".play()
			invince_frames()
		elif HP == 6:
			$"Stats/HP".animation = '6'
			$"Stats/HP".play()
			invince_frames()
		elif HP == 5:
			$"Stats/HP".animation = '5'
			$"Stats/HP".play()
			invince_frames()
		elif HP == 4:
			$"Stats/HP".animation = '4'
			$"Stats/HP".play()
			invince_frames()
		elif HP == 3:
			$"Stats/HP".animation = '3'
			$"Stats/HP".play()
			invince_frames()
		elif HP == 2:
			$"Stats/HP".animation = '2'
			$"Stats/HP".play()
			invince_frames()
		elif HP == 1:
			$"Stats/HP".animation = '1'
			$"Stats/HP".play()
			invince_frames()
		elif HP == 0:
			$"Stats/HP".animation = '0'
			$"Stats/HP".play()
			invince_frames()
func invince_frames():
	$"Stats/HP/invince_frames".start(0.07)
	invince_frames = true
	change_text()

func check_stats():
	if ammo_counter > 50:
		ammo_counter = 50
	change_text()
	check_HP()

func death():
	$"Amon-Sprite".animation = 'death'
	$"Amon-Sprite".play()
	dead = true
	$"/root/Main/Menu/RIP/death_anim-RIP_screen".start(1)

func save():
	var save_dict = {
		"global_pos_amon" : global_position,
		"amon_HP" : HP,
		"amon_lives" : lives,
		"amon_ammo" : ammo_counter
		}
	return save_dict

