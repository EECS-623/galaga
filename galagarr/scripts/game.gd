extends Node2D
@export var pirate_ship: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.wave = 1
	Global.enemies_left = 12
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	start_wave()
	

# When the mob timer times out, spawn a child instance of pirate ship
#func _on_mob_timer_timeout() -> void:
	#
	## while num enemies < max enemies:
	#var pirate = pirate_ship.instantiate()
	#
	#var path_follow = PathFollow2D.new()
	#
	#var pirate_ship_path = $PiratePath/BottomLeftPath
	#
	#pirate_ship_path.add_child(path_follow)
	#
	#path_follow.position = pirate_ship_path.get_position()
	#
	#path_follow.progress_ratio = 0
	#
	##pirate ship rotate 
	#
	#print(path_follow.progress)
	#print(path_follow.position)
	#print(path_follow.global_position)
	#
	##pirate = path_follow.position
	#
	##pirate.global_position = 
	##Vector2(randf_range(50.0, 1150.0), 120.0)
	#
	#path_follow.add_child(pirate)
	#
func spwan_enemies():	
	
	#TODO Similar spawning for sharks on shark paths
	
	#HERE YOU GO @ANDREW
	#var paths = [$PiratePath/BottomLeftPath, $PiratePath/TopPath, $PiratePath/BottomRightPath]
	var paths = [$PiratePath/BottomLeftPath]

	#I chose this order of loop so that the ships come in from all paths at once.
	for x in range(4):
		for pirate_ship_path in paths:
			var pirate = pirate_ship.instantiate()

		
			var path_follow = PathFollow2D.new()
			
			pirate_ship_path.add_child(path_follow)
			
			path_follow.position = pirate_ship_path.get_position()
			
			path_follow.progress_ratio = 0
			
			#pirate ship rotate 
			pirate.rotation -= PI / 2

			print(path_follow.progress)
			print(path_follow.position)
			print(path_follow.global_position)
			
			#pirate = path_follow.position
			
			#pirate.global_position = 
			#Vector2(randf_range(50.0, 1150.0), 120.0)
			
			path_follow.add_child(pirate)
			
			#Delay before spawning next pirate
		await get_tree().create_timer(0.5).timeout

	
	
func start_wave():
	#Check if all enemies are dead
	if Global.enemies_left == 0:
		#If they are, wait for 2 seconds
		#DISPLAY LEVEL ICON HERE (use Global.wave)
		Global.enemies_left = 12
		Global.wave += 1
		print(Global.wave)
		await get_tree().create_timer(2).timeout 

		spwan_enemies()
	
	
