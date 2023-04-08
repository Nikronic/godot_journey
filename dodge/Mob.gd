extends Area2D


# mob mov speed
var base_mov_speed = 300.0

# if game still running
var move_allowed = true

# rng for mov direction of mobs
var rng = RandomNumberGenerator.new()

# generate two random numbers for random direction of mob move
# one rng for top-down, and one for left-right
var random_x_dir = rng.randi_range(-1, 1)
var random_y_dir = rng.randi_range(-1, 1)
var random_anim  = rng.randi_range(0, 2)

# walk, swim, and fly animations for the mob
@onready var animated_sprite = $AnimatedSprite2D


func _process(_delta):
	if move_allowed:  # if move allowed (e.g., game not ended)
		random_move_object(_delta)

func random_move_object(_delta):
	# The mob's movement vector (init = 0)
	var velocity = Vector2.ZERO
	
	velocity.x += float(random_x_dir)
	velocity.y += float(random_y_dir)
	
	# if mob is moving
	if velocity.length() > 0:
		velocity = velocity.normalized() * base_mov_speed
		# random animation
		animate_sprite(animated_sprite)
	# stop animation if no key pressed
	else:
		animated_sprite.stop()
	
	position += velocity * _delta

# player animation w.r.t. player movement
func animate_sprite(animated_sprite):
	# walk, swim, and fly
	var anim_types = animated_sprite.sprite_frames.get_animation_names()
	animated_sprite.play(anim_types[random_anim])
	

func _ready():
	rng.seed = 8569

# reset after "hit"
func start(pos):
	position = pos
	# $CollisionShape2D.disabled = false

# delete mob when out of screen
func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

# stop mob from mov if "hit" player
func _on_player_hit():
	move_allowed = false
