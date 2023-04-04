extends Area2D


# player mov speed
var base_mov = 5.0
# enable/disable player mov
var move_allowed = true

# up (mirror down), walk (mirror left) animations for the player
@onready var animated_sprite = $AnimatedSprite2D


func _process(_delta):
	# rotate_object(delta)
	
	if move_allowed:  # if move allowed via button 
		manual_move_object(_delta)
	

func manual_move_object(_delta):
		
	var direction = 0.0
	var position_change = position

	if Input.is_action_pressed("ui_left"):
		direction = Vector2.LEFT
		position_change = direction * base_mov + position
		# animation
		animate_sprite(animated_sprite, 'left')
	if Input.is_action_pressed("ui_right"):
		direction = Vector2.RIGHT
		position_change = direction * base_mov + position
		# animation
		animate_sprite(animated_sprite, 'right')
	if Input.is_action_pressed("ui_up"):
		direction = Vector2.UP
		position_change = direction * base_mov + position
		# animation
		animate_sprite(animated_sprite, 'up')
	if Input.is_action_pressed("ui_down"):
		direction = Vector2.DOWN
		position_change = direction * base_mov + position
		# animation
		animate_sprite(animated_sprite, 'down')
	
	position = position_change
	
	# stop animation if no key pressed
	if not Input.is_anything_pressed():
		animated_sprite.stop()

# player animation w.r.t. player movement
func animate_sprite(animated_sprite, dir):
	if dir == 'left':
		animated_sprite.flip_h = true
		animated_sprite.flip_v = false
		animated_sprite.play("walk")
	if dir == 'right':
		animated_sprite.flip_h = false
		animated_sprite.flip_v = false
		animated_sprite.play("walk")
	if dir == 'up':
		animated_sprite.flip_h = false
		animated_sprite.flip_v = false
		animated_sprite.play("up")
	if dir == 'down':
		animated_sprite.flip_h = false
		animated_sprite.flip_v = true
		animated_sprite.play("up")

	
func _ready():
	pass
