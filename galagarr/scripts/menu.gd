extends Control
@onready var lore_window = $Lore  # Reference the Window node

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.


func _on_lore_pressed() -> void:
	lore_window.show_menu()

func _on_controls_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/controls.tscn")


func _on_quit_pressed() -> void:
	get_tree().quit() # Replace with function body.
