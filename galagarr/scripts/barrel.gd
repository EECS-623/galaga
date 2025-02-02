extends Area2D
@export var explosion: PackedScene

var speed = 350
func _ready() -> void:
	add_to_group("player_bullet")
	set_monitoring(true)
func _physics_process(delta):
	if(position.y > 235):
		position -= transform.y * speed * delta
		
func _on_area_entered(area: Area2D) -> void:
		
	if area.is_in_group("explosionTrigger"):
		print("boom") 
		var boom = explosion.instantiate()
		#POSITION OF BULLET SPAWN
		boom.position = global_position + Vector2(-125,-110) #for some reason have to offset by this weird number to get it to shoot from front. Might have to change if get a new image - Will
		get_parent().add_child(boom)
		hide()
		queue_free()
