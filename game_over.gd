extends Control

func _ready() -> void:
	$VBoxContainer3/FinalScoreLabel.text = "Final Score: " + str(Global.final_score)
	$VBoxContainer2/PlayAgain.grab_focus()

func _on_play_again_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main.tscn")

func _on_quit_pressed() -> void:
	get_tree().quit()

func _on_main_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menu.tscn")
