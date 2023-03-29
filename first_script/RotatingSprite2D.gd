extends Sprite2D

var speed = 400
var angular_speed = deg_to_rad(90.0)
var base_mov = 5.0

var move_allowed = true

var cooldown_timer = 3


func _process(_delta):
	# rotate_object(delta)
	
	if move_allowed:  # if move allowed via button 
		manual_move_object(_delta)
	

func manual_move_object(delta):
		
	var direction = 0.0
	var position_change = position

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
	move_allowed = not move_allowed
	_reset_timer(3)
	
func _ready():
	var timer = get_node("Timer")
	timer.timeout.connect(_on_timer_timeout)
	timer.start(3)

func _on_timer_timeout():
	move_allowed = false

func _reset_timer(seconds):
	var timer = get_node("Timer")
	timer.start(seconds)
	
	
