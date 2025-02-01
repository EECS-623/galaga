extends Area2D
signal hit
@export var player_bullet: PackedScene
@export var speed = 250 # How fast the player will move (pixels/sec)
@onready var bar = $cooldownbar
var screen_size # size of the game window
var sprite_size # size of the sprite
var lives = 3
var progress = 100
var cooldown = false
var bar_speed = 2.5

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	connect("area_entered", Callable(self, "_on_area_entered"))
	
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
		bar.value = progress
			
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
		
	if cooldown:
		progress += bar_speed
		if progress >= 100:
			cooldown = false
	bar.value = progress

#3
func _on_area_entered(area: Area2D) -> void:
		
	if area.is_in_group("pirate_cannonball"):
		print("hit detected") 
		if(lives == 1):
			hide()
		else:
			lives -= 1
		print(lives)

		hit.emit()  # Emit hit signal

func _unhandled_input(event):
	if event.is_action_pressed("shoot"):
		fire_cannon()

func fire_cannon():
	if not cooldown:
		var bullet = player_bullet.instantiate()
	#POSITION OF BULLET SPAWN
		bullet.position = global_position + Vector2(-125,-110) #for some reason have to offset by this weird number to get it to shoot from front. Might have to change if get a new image - Will
		cooldown = true
		progress = 0
		get_parent().add_child(bullet)

func start(pos: Vector2):
	position = pos
	show()
	$CollisionShape2D.disabled = false
