extends Area2D

var speed = 700
func _ready() -> void:
	add_to_group("player_bullet")
	set_monitoring(true)
func _physics_process(delta):
	position -= transform.y * speed * delta
	
	

#func _on_body_entered(body: Node2D) -> void:
	#if body.is_in_group("pirate_ship"):
		#print("pirate hit")
		#body.queue_free()
		#queue_free()
