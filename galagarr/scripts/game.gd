extends Node2D
@export var pirate_ship: PackedScene
var num_enemies = 0
var max_enemies = 10

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

# When the mob timer times out, spawn a child instance of pirate ship
func _on_mob_timer_timeout() -> void:
	
	# if num enemies < max enemies (initially 10):
	if (num_enemies < max_enemies): 
		
		# create new pirate and PathFollow2D
		var pirate = pirate_ship.instantiate()
		var path_follow = PathFollow2D.new()
		
		# find path for pirate to spawn out of 
		var rng = RandomNumberGenerator.new()
		var random_number = rng.randi_range(0, 1)
		var pirate_ship_path
		if (random_number == 0):
			pirate_ship_path = $PiratePath/BottomLeftPath
		elif (random_number == 1):
			pirate_ship_path = $PiratePath/BottomRightPath
		
		pirate_ship_path.add_child(path_follow)
		
		path_follow.position = pirate_ship_path.get_position()
		
		path_follow.progress_ratio = 0
		
		pirate.rotation -= PI / 2
		
		path_follow.add_child(pirate)
		num_enemies += 1
