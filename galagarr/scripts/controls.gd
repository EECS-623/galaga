extends Control
var cannon_button
var barrel_button
var left_button
var right_button

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	cannon_button = get_node("VBoxContainer/VBoxContainer2/Cannon")
	left_button = get_node("VBoxContainer/HBoxContainer/VBoxContainer/Left")
	right_button = get_node("VBoxContainer/HBoxContainer/VBoxContainer3/Right")
	barrel_button = get_node("VBoxContainer/VBoxContainer4/Barrel")
	pass # Replace with function body.


func _input(event):
	if Input.is_action_pressed("shoot"):
		cannon_button.grab_focus()
	if Input.is_action_pressed("move_left"):
		left_button.grab_focus() 
	if Input.is_action_pressed("move_right"):
		right_button.grab_focus()
	if Input.is_action_pressed("alt_fire"):
		barrel_button.grab_focus()






func _on_quit_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menu.tscn")
