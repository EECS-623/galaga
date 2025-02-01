extends Control
var shoot_button
var left_button
var right_button

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	shoot_button = get_node("VBoxContainer/HBoxContainer/VBoxContainer2/Shoot")
	left_button = get_node("VBoxContainer/HBoxContainer/VBoxContainer/Left")
	right_button = get_node("VBoxContainer/HBoxContainer/VBoxContainer3/Right")

	pass # Replace with function body.


func _input(event):
	if event is InputEventKey and event.pressed:
		if event.keycode == KEY_SPACE:
			shoot_button.grab_focus()
		elif event.keycode == KEY_A or event.keycode == KEY_LEFT:
			left_button.grab_focus()  # Triggers highlight effect
		elif event.keycode == KEY_D or event.keycode == KEY_RIGHT:
			right_button.grab_focus()  # Triggers highlight effect





func _on_quit_pressed() -> void:
	get_tree().change_scene_to_file("res://menu.tscn")
