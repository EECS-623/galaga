extends Area2D
var screen_size
var speed
var to_floating = false
var floating = false
var direction
var above_water_y = 300
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	speed = 250 + 5 * (Global.wave - 1)
	var to_floating = false
	var floating = false
	add_to_group("shark")
	add_to_group("enemies")
	Global.above_water = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if global_position.y >= min(450, above_water_y+10*(Global.wave - 1)):
		$Sprite2D.animation =  "shark_above_water"
		Global.above_water = 1
		#$Sprite2D.play("shark_below_water")
	else:
		$Sprite2D.animation =  "shark_below_water"
		Global.above_water = 0
		#$Sprite2D.play("shark_above_water")
	if (to_floating == false):
		_move(delta)
	#elif (to_floating == true && floating == false):
		#_move_to_path(delta)
	#elif (floating == true):
		#_move(delta)


# Called when a cannon_ball hits the pirateship
#func _on_body_entered(area: Area2D) -> void:
	#print("pirate_hit")
	#if area.is_in_group("player_bullet"):
		#print("pirate hit")
		#var path = get_parent()
		#path.queue_free()
		#queue_free()


func _move(delta: float):
	var path_follower = get_parent()
	path_follower.progress += speed * delta
	
	#if self.rotation != -PI/2, then rotate towards (some math formula involving delta)
	
	#if (path_follower.progress_ratio > 0.99 && floating == false):
		## create if statement here for the different paths
		#var path = get_node("../../../FloatingPath")
		#path_follower.remove_child(self)
		#path.get_parent().add_child(self)
		#self.global_position = path_follower.global_position
		#var start_point = $"../FloatingPath/StartPoint".global_position
		#look_at(start_point)
		#self.rotation -= PI/2
		#direction = (start_point - global_position).normalized()
		#to_floating = true

#func _move_to_path(delta: float):
	#global_position += direction * speed * delta
	#
	## if the distance is less than a certain amount, then floating is true
	## create if statement here for the different paths
	#var path = $"../FloatingPath"
	#var start_point = $"../FloatingPath/StartPoint".global_position
	#print(start_point)
	#var distance = position.distance_to(start_point)
	#print(distance)
	#if (distance < 100):
		#var new_path_follow = PathFollow2D.new()
		#path.get_parent().remove_child(self)
		#path.add_child(new_path_follow)
		#new_path_follow.add_child(self)
		#new_path_follow.global_position = path.global_position
		#self.position = new_path_follow.position
		#
		#self.rotation = -PI/2
		#
		#floating = true

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("player_bullet") and Global.above_water == 1:
		Global.enemies_left -= 1
		print("shark_hit")
		var main = get_tree().get_root().get_node("Main")
		if main:
			main.enemy_defeated("shark")
		queue_free()
		area.queue_free()
