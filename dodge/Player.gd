extends Area2D

# collision with enemy
signal hit

# screen size to bound the characters
var screen_size

# player mov speed
var base_mov_speed = 300.0
# enable/disable player mov
var move_allowed = true

# up (mirror down), walk (mirror left) animations for the player
@onready var animated_sprite = $AnimatedSprite2D


func _process(_delta):
	# rotate_object(delta)
	
	if move_allowed:  # if move allowed via button 
		manual_move_object(_delta)
	

func manual_move_object(_delta):
	# The player's movement vector (init = 0)
	var velocity = Vector2.ZERO

	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1.0
		
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1.0
		
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1.0
		
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1.0
	
	# if player is moving
	if velocity.length() > 0:
		velocity = velocity.normalized() * base_mov_speed
		# animation w.r.t. direction of mov
		animate_sprite(animated_sprite, velocity)
	# stop animation if no key pressed
	else:
		animated_sprite.stop()
	
	position = clamp_player_pos(position, screen_size)
	position += velocity * _delta

# player animation w.r.t. player movement
func animate_sprite(animated_sprite, velocity: Vector2):
	# left/right
	if velocity.x != 0:
		animated_sprite.flip_h = velocity.x < 0
		animated_sprite.flip_v = false
		animated_sprite.play("walk")
	# down/up
	if velocity.y != 0:
		animated_sprite.flip_h = false
		animated_sprite.flip_v = velocity.y > 0
		animated_sprite.play("up")

# prevent player from moving outside of the screen
func clamp_player_pos(position, screen_size):
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)
	return position

func _ready():
	screen_size = get_viewport_rect().size

func _on_hit():
	print("Game Over")

# reset after "hit"
func start(pos):
	position = pos
	$CollisionShape2D.disabled = false

# collision detected => "hit"
func _on_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	hit.emit()
	# Must be deferred as we can't change physics properties on a physics callback
	$CollisionShape2D.set_deferred("disabled", true)
