extends Window


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hide() 
	
func show_menu():
	popup_centered()  # Adjust size if needed

func _on_close_requested():
	hide()
	
func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main.tscn")
