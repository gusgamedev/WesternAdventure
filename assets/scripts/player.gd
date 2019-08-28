extends KinematicBody2D

var bullet = preload("res://assets/scenes/bullet.tscn")

const GRAVITY = 1500
const SPEED = 400
const JUMP_FORCE = -600 

var linear_velocity = Vector2()

var is_shooting = false

func _physics_process(delta):
	
	linear_velocity.y += GRAVITY * delta
	
	var walk_left = Input.is_action_pressed("ui_left")
	var walk_right = Input.is_action_pressed("ui_right")
	var jump = Input.is_action_just_pressed("ui_jump")
	
	if walk_left:
		linear_velocity.x = -SPEED
		$spawn_bullet.position = Vector2(-55,17)
		$animation.flip_h = true
		
	elif walk_right:
		linear_velocity.x = SPEED
		$spawn_bullet.position = Vector2(55,17)
		$animation.flip_h = false
		
	else: 
		linear_velocity.x = 0
		
	if is_on_floor() and jump:
		linear_velocity.y = JUMP_FORCE
		
	linear_velocity = move_and_slide(linear_velocity, Vector2(0,-1))
	
	if Input.is_action_just_pressed("ui_shot") and is_on_floor():
		spawn_bullet()
		
	
	
	#Controle animacoes	
	var anim
		
	if is_on_floor():	
	
		if is_shooting:
			anim = "shot"	
		elif walk_left or walk_right:
			anim = "walk"
		else:
			anim = "idle"
	else:
		anim = "jump"
		
	$animation.play(anim)
	
func spawn_bullet():
	
	is_shooting = true
	
	var clone_bullet = bullet.instance()
	get_parent().add_child(clone_bullet)
	clone_bullet.position = $spawn_bullet.global_position	
	
	if $animation.flip_h: 
		clone_bullet.linear_velocity = Vector2(-800,0)
	else:
		clone_bullet.linear_velocity = Vector2(800,0)
	

func _on_animation_animation_finished():
	
	if $animation.animation == "shot":	
		is_shooting = false
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	