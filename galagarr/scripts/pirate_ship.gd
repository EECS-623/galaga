extends Area2D
var screen_size
@export var projectile: PackedScene
var speed
var shot_delay = randf_range(2.5, 15)
var to_floating = false
var floating = false
var direction
var path_name = ["TopLeftCircle", "TopRightCircle", "TopMiddleCircle1", "TopMiddleCircle2"]
var path_num

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	speed = 250 + 1.5 * (Global.wave - 1)
	$ProjectileTimer.wait_time = shot_delay - .80 * (Global.wave - 1)
	$ProjectileTimer.start()
	add_to_group("pirate_ship")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (to_floating == false):
		_move(delta)
	elif (to_floating == true && floating == false):
		_move_to_path(delta)
	elif (floating == true):
		_move(delta)

func _shoot_projectile():
	var new_projectile = projectile.instantiate()
	
	var game = $/root/Main/Game
	
	new_projectile.global_position = get_global_position()
	
	game.add_child(new_projectile)

func _on_projectile_timer_timeout() -> void:
	print("reached timeout")
	_shoot_projectile()
	
	await get_tree().create_timer(0.4).timeout
	
	_shoot_projectile()
	
	$ProjectileTimer.wait_time = shot_delay - .80 * (Global.wave - 1)
	$ProjectileTimer.start()

func _move(delta: float):
	var path_follower = get_parent()
	if (path_follower.get_parent().get_name() == path_name[path_num]):
		path_follower.progress += speed/(1.5) * delta
	else:
		path_follower.progress += speed * delta
	#if self.rotation != -PI/2, then rotate towards (some math formula involving delta)
	
	if (path_follower.progress_ratio > 0.99 && floating == false):
		# create if statement here for the different paths
		var path
		
		path = get_node("../../../" + path_name[path_num]) 
		
		path_follower.remove_child(self)
		path.get_parent().add_child(self)
		self.global_position = path_follower.global_position
		
		var start_point_string = "../" + path_name[path_num] + "/StartPoint"
		var start_point = get_node(start_point_string).global_position
			
		look_at(start_point)
		self.rotation -= PI/2
		direction = (start_point - global_position).normalized()
		to_floating = true

func _move_to_path(delta: float):
	global_position += direction * speed * delta
	
	# if the distance is less than a certain amount, then floating is true
	# create if statement here for the different paths
	var path
	path = get_node("../" + path_name[path_num]) 
	var start_point = get_node("../" + path_name[path_num] + "/StartPoint").global_position
	
	var distance = position.distance_to(start_point)
	
	if (distance < 5):
		var new_path_follow = PathFollow2D.new()
		path.get_parent().remove_child(self)
		path.add_child(new_path_follow)
		new_path_follow.add_child(self)
		new_path_follow.global_position = path.global_position
		self.position = new_path_follow.position
		
		self.rotation = -PI/2
		
		floating = true

func _on_area_entered(area: Area2D) -> void:
	Global.enemies_left -= 1
	print("pirate_hit")
	var main = get_tree().get_root().get_node("Main")
	if main:
		main.enemy_defeated("pirate")
	queue_free()
	area.queue_free()
	
# Called when a cannon_ball hits the pirateship
#func _on_body_entered(area: Area2D) -> void:
	#print("pirate_hit")
	#if area.is_in_group("player_bullet"):
		#print("pirate hit")
		#var path = get_parent()
		#path.queue_free()
		#queue_free()
