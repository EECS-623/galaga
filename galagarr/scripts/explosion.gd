extends Area2D
var expolodeTime = 10

func _ready() -> void:
	add_to_group("player_bullet")
	set_monitoring(true)
	
func _physics_process(delta):
	if(expolodeTime < 0):
		expolodeTime = 10
		queue_free()
	else:
		expolodeTime -= 1
	

		
