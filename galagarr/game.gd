extends Node2D
@export var pirate_ship: PackedScene
@export var shark: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.wave = 0
	Global.enemies_left = 0
	Global.start_enemies = 4

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#print("Enemies Left: ")
	#print(Global.enemies_left)
	if Global.enemies_left == 0:
		Global.start_enemies += 2
		Global.wave += 1
		Global.enemies_left = Global.start_enemies * 2
		print("reached new wave")
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
	var shark_paths = [$SharkPath/BottomLeftPath]
	
	# ratio for sharks spawning should be less than pirates
	# sharks should be faster than pirates as well
	for x in range(Global.start_enemies/2):
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
			
			#Delay before spawning next shark
		await get_tree().create_timer(0.4).timeout
		
		#might be better to spawn one side at a time and then wait a bit before spawning the next side...
		
	#HERE YOU GO @ANDREW
	var paths = [$PiratePath/BottomLeftPath, $PiratePath/TopPath1, $PiratePath/TopPath2, $PiratePath/BottomRightPath]
	#var paths = [$PiratePath/BottomLeftPath]

	#I chose this order of loop so that the ships come in from all paths at once.
	for x in range(Global.start_enemies/2):
		for pirate_ship_path in paths:
			
			var path_num
			if(pirate_ship_path == $PiratePath/BottomLeftPath):
				path_num = 0
			elif(pirate_ship_path == $PiratePath/TopPath1 or pirate_ship_path == $PiratePath/TopPath2):
				path_num = 1
			elif(pirate_ship_path == $PiratePath/BottomRightPath):
				path_num = 2
			
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

	
	
func start_wave():
	#Check if all enemies are dead
	#if Global.enemies_left == 0:
		#If they are, wait for 2 seconds
		#DISPLAY LEVEL ICON HERE (use Global.wave)
	print("wave number: ")
	print(Global.wave)
	await get_tree().create_timer(2).timeout 

	spwan_enemies()
	
	
