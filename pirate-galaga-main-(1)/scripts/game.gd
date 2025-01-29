extends Node2D
@export var pirate_ship: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

# When the mob timer times out, spawn a child instance of pirate ship
func _on_mob_timer_timeout() -> void:
	var pirate = pirate_ship.instantiate()
	
	#var pirate_ship_spawn_location = $/MobPath/MobSpawnLocatio
	#pirate_ship_spawn_location.progress_ratio = randf()
	
	#pirate.position = pirate_ship_spawn_location.position
	
	pirate.global_position = Vector2(randf_range(50.0, 1150.0), 120.0)
	
	add_child(pirate)
	
