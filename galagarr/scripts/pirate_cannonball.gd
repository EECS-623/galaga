extends Area2D
var speed = 400
var player_position
var direction

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_direction()
	set_monitoring(true)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	_move(delta)

# obtains direction of player and orientates ball towards it
func _direction():
	var player = get_node("../../Player")
	
	player_position = player.global_position
	
	look_at(player_position)
	
	direction = (player_position - global_position).normalized()

# moves towards saved player position
func _move(delta: float):
	
	global_position += direction * speed * delta

# On shape entered lose life and remove projectile
func _on_area_shape_entered(area_rid: RID, area: Area2D, area_shape_index: int, local_shape_index: int) -> void:
	queue_free()
