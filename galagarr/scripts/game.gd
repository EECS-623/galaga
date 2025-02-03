extends Node2D
@export var pirate_ship: PackedScene
@export var shark: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.wave = 0
	Global.enemies_left = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#print("Enemies Left: ")
	#print(Global.enemies_left)
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
func spawn_enemies():	
	
	var shark_paths = [$SharkPath/MiddlePath, $SharkPath/LeftPath, $SharkPath/RightPath]
	
	# ratio for sharks spawning should be less than pirates
	# sharks should be faster than pirates as well
	for shark_path in shark_paths:
		var my_shark = shark.instantiate()
		var path_follow = PathFollow2D.new()
		shark_path.add_child(path_follow)
		path_follow.position = shark_path.get_position()
		path_follow.progress_ratio = 0
		#shark ship rotate 
		my_shark.rotation -= PI / 2

		#print(path_follow.progress)
		#print(path_follow.position)
		#print(path_follow.global_position)
		
		#pirate = path_follow.position
		
		#pirate.global_position = 
		#Vector2(randf_range(50.0, 1150.0), 120.0)
		
		path_follow.add_child(my_shark)
		
		
	var paths = [$PiratePath/BottomLeftPath, $PiratePath/BottomRightPath]

	for x in range(4):
		for path_num in range(2):
			var pirate_ship_path = paths[path_num]
			var pirate = pirate_ship.instantiate()
			pirate.path_num = path_num
			var path_follow = PathFollow2D.new()
			pirate_ship_path.add_child(path_follow)
			
			path_follow.position = pirate_ship_path.get_position()
			path_follow.progress_ratio = 0
			
			#pirate ship rotate 
			pirate.rotation -= PI / 2
			path_follow.add_child(pirate)
			
			#Delay before spawning next pirate
		await get_tree().create_timer(0.4).timeout
		
	var top_paths = [$PiratePath/TopPath1, $PiratePath/TopPath2]
	for x in range(2):
		for path in top_paths:
			var pirate_ship_path = path
			var pirate = pirate_ship.instantiate()
			# need to fix this
			if (path == $PiratePath/TopPath1):
				pirate.path_num = 2
			elif (path == $PiratePath/TopPath2):
				pirate.path_num = 3
			var path_follow = PathFollow2D.new()
			pirate_ship_path.add_child(path_follow)
			
			path_follow.position = pirate_ship_path.get_position()
			path_follow.progress_ratio = 0
			
			#pirate ship rotate 
			pirate.rotation -= PI / 2
			path_follow.add_child(pirate)
			#Delay before spawning next pirate
		await get_tree().create_timer(0.4).timeout
	
func start_wave():
	#Check if all enemies are dead
	if Global.enemies_left == 0:
		#If they are, wait for 2 seconds
		#DISPLAY LEVEL ICON HERE (use Global.wave)
		print("reached new wave")
		print("wave number: ")
		print(Global.wave)
		Global.enemies_left = 15
		await get_tree().create_timer(2).timeout 

		spawn_enemies()
	
	
