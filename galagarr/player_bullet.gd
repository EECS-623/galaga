extends Area2D

var speed = 700

func _physics_process(delta):
	position -= transform.y * speed * delta
	
	

func _on_body_entered(body: Node2D) -> void:
	body.queue_free()
