extends Area2D
signal hit
@export var speed = 250 # How fast the player will move (pixels/sec)
var screen_size # size of the game window
var sprite_size # size of the sprite

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size

	# This is all code to prevent the ship from being half off the screen -Will
	var sprite_node = $AnimatedSprite2D
	if sprite_node and sprite_node.sprite_frames:
		var sprite_frames = sprite_node.sprite_frames
		var texture = sprite_frames.get_frame_texture("ship", 0) #if we change the name of the ship, change it here.
		if texture:
			var texture_size = texture.get_size()
			sprite_size = texture_size * sprite_node.get_scale()
		else:
			print("Error: Texture for animation 'ship' not found. Perhaps, you renamed the ship animation sprite")
	else:
		print("Error: AnimatedSprite2D or sprite_frames is not set up correctly.")
	
	#hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float):
	var velocity = Vector2.ZERO # The player's movement vector
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1

	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()

	position += velocity * delta
	if sprite_size and screen_size:
		position = position.clamp(sprite_size / 2, screen_size - sprite_size / 2)

func _on_body_entered(body: Node2D) -> void:
	hit.emit()
	# Must be deferred as we can't change physics properties on a physics callback.
	$CollisionShape2D.set_deferred("disabled", true)

func start(pos: Vector2):
	position = pos
	show()
	$CollisionShape2D.disabled = false
