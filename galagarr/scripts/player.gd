extends Area2D
signal hit
@export var player_bullet: PackedScene = preload("res://scenes/player_bullet.tscn")
@export var barrel: PackedScene = preload("res://scenes/barrel.tscn")
@export var speed = 250 # How fast the player will move (pixels/sec)
@onready var bar = $cooldownbar
@onready var barAlt = $cooldownbarAlt

var screen_size # size of the game window
var sprite_size # size of the sprite
var lives: int = 3
var progress = 100
var cooldown = false
var progressAlt = 100
var cooldownAlt = false

var bar_speed = 2.5
var barAlt_speed = 0.1

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	connect("area_entered", Callable(self, "_on_area_entered"))
	add_to_group("player")
	$AnimatedSprite2D.play()
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
	#else:
		#$AnimatedSprite2D.stop()

	position += velocity * delta
	if sprite_size and screen_size:
		position = position.clamp(sprite_size / 2, screen_size - sprite_size / 2)
		
	if cooldown:
		progress += bar_speed
		if progress >= 100:
			cooldown = false
	bar.value = progress
	if cooldownAlt:
		progressAlt += barAlt_speed
		if progressAlt >= 100:
			cooldownAlt = false
	barAlt.value = progressAlt	

#3
func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("enemies"):
		$CollisionShape2D.set_deferred("disabled", true)
		print("hit detected") 
		if lives == 1:
			lives = 0
			$PlayerDeathAudio.play()
			# add player cannot move here with 
			# maybe a sinking animation 
			# change line below to be longer in case of sinking animation
			hide()
			hit.emit()
		else:
			$PlayerHitAudio.play()
			lives -= 1
			hit.emit()
			for i in range(10):
				$AnimatedSprite2D.hide()
				await get_tree().create_timer(0.1).timeout
				$AnimatedSprite2D.show()
				await get_tree().create_timer(0.1).timeout
		$CollisionShape2D.set_deferred("disabled", false)
		print("Lives left: ", lives)

func _unhandled_input(event):
	if event.is_action_pressed("shoot"):
		fire_cannon()
	if event.is_action_pressed("alt_fire"):
		print("Firing Barrel Finally")
		fireBarrel()		

func fire_cannon():
	if not cooldown:
		var bullet = player_bullet.instantiate()
		$PlayerShotAudio.play()
	#POSITION OF BULLET SPAWN
		bullet.position = global_position + Vector2(0,-10) #for some reason have to offset by this weird number to get it to shoot from front. Might have to change if get a new image - Will
		cooldown = true
		progress = 0
		get_parent().add_child(bullet)
		
func fireBarrel():
	if not cooldownAlt:
		var explosive = barrel.instantiate()
		#POSITION OF BULLET SPAWN
		$DeployBarrelAudio.play()
		explosive.position = global_position + Vector2(0,-10) 
		cooldownAlt = true
		progressAlt = 0
		get_parent().add_child(explosive)		
		
func start(pos: Vector2):
	position = pos
	show()
	$CollisionShape2D.disabled = false
