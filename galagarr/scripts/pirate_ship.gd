extends Area2D
signal hit
var screen_size
var time = 0
var speed = 100
@export var projectile: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$ProjectileTimer.start
	add_to_group("pirate_ship")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	_move(delta)

# Called when a cannon_ball hits the pirateship
#func _on_body_entered(area: Area2D) -> void:
	#print("pirate_hit")
	#if area.is_in_group("player_bullet"):
		#print("pirate hit")
		#var path = get_parent()
		#path.queue_free()
		#queue_free()

func _shoot_projectile():
	var new_projectile = projectile.instantiate()
	
	var game = $/root/Main/Game
	
	new_projectile.global_position = get_global_position()
	
	game.add_child(new_projectile)

func _on_projectile_timer_timeout() -> void:
	_shoot_projectile()
	
	await get_tree().create_timer(0.5).timeout
	
	_shoot_projectile()

func _move(delta: float):
	var path = get_parent()
	path.progress += 100 * delta

#func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	#queue_free()

func _on_area_entered(area: Area2D) -> void:
	print("pirate_hit")
	queue_free()
	area.queue_free()
