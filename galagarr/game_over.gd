extends Control

func _ready() -> void:
	# Set focus on the Play Again button so the user can quickly restart
	$VBoxContainer/PlayAgain.grab_focus()

func _on_play_again_pressed() -> void:
	# Change back to the main game scene
	get_tree().change_scene("res://main.tscn")

func _on_quit_pressed() -> void:
	# Quit the game
	get_tree().quit()
