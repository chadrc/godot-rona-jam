extends KinematicBody2D

export (int) var run_speed = 200
export (int) var jump_speed = -400
export (int) var gravity = 1200

var velocity = Vector2()
var isJumping = false

func get_input():
	velocity.x = 0
	
	var jump = Input.is_key_pressed(KEY_SPACE)
	
	if jump and is_on_floor():
		isJumping = true
		velocity.y = jump_speed
		
	if Input.is_key_pressed(KEY_A):
		velocity.x = -run_speed
	elif Input.is_key_pressed(KEY_D):
		velocity.x = run_speed

func _physics_process(delta):
	get_input()
	velocity.y += gravity * delta
	
	if isJumping and is_on_floor():
		isJumping = false
		
	velocity = move_and_slide(velocity, Vector2(0, -1))
