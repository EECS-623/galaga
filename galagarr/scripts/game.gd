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
	
	# while num enemies < max enemies:
	var pirate = pirate_ship.instantiate()
	
	var path_follow = PathFollow2D.new()
	
	var pirate_ship_path = $PiratePath/BottomLeftPath
	
	pirate_ship_path.add_child(path_follow)
	
	path_follow.position = pirate_ship_path.get_position()
	
	path_follow.progress_ratio = 0
	
	#pirate ship rotate 
	
	print(path_follow.progress)
	print(path_follow.position)
	print(path_follow.global_position)
	
	#pirate = path_follow.position
	
	#pirate.global_position = 
	#Vector2(randf_range(50.0, 1150.0), 120.0)
	
	path_follow.add_child(pirate)
	
