extends Node2D
@export var pirate_ship: PackedScene
@export var shark: PackedScene
var main


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	main = $"../../Main"
	Global.wave = 0
	Global.enemies_left = 0
	#start_wave()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Global.enemies_left == 0:
		Global.enemies_left = 15
		Global.wave += 1
		print("Updating Wave")
		print(Global.wave)
		start_wave()
	
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
			
			#Delay before spawning ext pirate
		await get_tree().create_timer(0.4).timeout
		
	var top_paths = [$PiratePath/TopPath1, $PiratePath/TopPath2]
	# weird visual bug here in spawning more objects than 
	# are actually spawned...
	for x in range(2):
		for path in top_paths:
			var pirate_ship_path = path
			var pirate = pirate_ship.instantiate()
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
	Global.wave_start = true

	$"../GalleyGarrTheme".stream_paused = true;
	$"../AmbientWavesAudio".stream_paused = true;
	print("Playing wave audio")
	$WaveAudio.play()
	await get_tree().create_timer(1.5).timeout
	
	Global.wave_start = false
	$"../GalleyGarrTheme".stream_paused = false;
	$"../AmbientWavesAudio".stream_paused = false;
	await get_tree().create_timer(2).timeout
	spawn_enemies()
	
