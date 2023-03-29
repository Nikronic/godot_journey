extends Sprite2D

var speed = 400
var angular_speed = deg_to_rad(90.0)
var base_mov = 5.0

var move_allowed = true


func _process(_delta):
	# rotate_object(delta)
	
	var direction = 0.0
	var position_change = position
	
	if move_allowed:  # if move allowed via button 
		if Input.is_action_pressed("ui_left"):
			direction = Vector2.LEFT
			position_change = direction * base_mov + position
		if Input.is_action_pressed("ui_right"):
			direction = Vector2.RIGHT
			position_change = direction * base_mov + position
		if Input.is_action_pressed("ui_up"):
			direction = Vector2.UP
			position_change = direction * base_mov + position
		if Input.is_action_pressed("ui_down"):
			direction = Vector2.DOWN
			position_change = direction * base_mov + position
	
	position = position_change
	
	

func rotate_object(delta):
	var direction = 0
	
	if Input.is_action_pressed("ui_left"):
		direction = -1
	if Input.is_action_pressed("ui_right"):
		direction = 1
	
	# rotate via arrow (left, right) keys
	var rotation_change = 0.0
	rotation_change = angular_speed * direction
	rotation += rotation_change * delta
	


func _on_button_pressed():
	# disables/enables arrow keys (no longer can move object)
	if move_allowed == true:
		move_allowed = false
	else:
		move_allowed = true
	
