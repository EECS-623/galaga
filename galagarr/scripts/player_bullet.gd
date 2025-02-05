extends Area2D

var speed = 700
func _ready() -> void:
	add_to_group("explosionTrigger")	
	add_to_group("player_bullet")
	set_monitoring(true)
func _physics_process(delta):
	position -= transform.y * speed * delta
	
