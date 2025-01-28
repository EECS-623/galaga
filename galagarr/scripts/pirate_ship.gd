extends Node
signal hit
var screen_size
var time = 0
@export var projectile: PackedScene
@export var cannon_ball: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$ProjectileTimer.start


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

# Called when a cannon_ball hits the pirateship
func _on_body_entered(body: Node2D) -> void:
	if body.name == cannon_ball.name:
		print("Collided with: ", body.name)
		queue_free()

func _shoot_projectile():
	var new_projectile = projectile.instantiate()
	
	new_projectile.position = Vector2(0.0, 50.0 )
	
	add_child(new_projectile)

func _on_projectile_timer_timeout() -> void:
	_shoot_projectile()
	
	await get_tree().create_timer(0.5).timeout
	
	_shoot_projectile()


#func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	#queue_free()
