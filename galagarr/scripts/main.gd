extends Node

var score: int = 0
var hud

func _ready() -> void:
	hud = $HUD/Control
	update_hud()
	$Game/Player.connect("hit", Callable(self, "_on_player_hit"))

# Update both score and lives in the HUD.
func update_hud() -> void:
	var player = $Game/Player
	hud.update_score(score)
	hud.update_lives(player.lives)

# Called when a pirate ship or shark is defeated.
func enemy_defeated(enemy_type: String) -> void:
	if enemy_type == "pirate":
		score += 100
	elif enemy_type == "shark":
		score += 200
	update_hud()

# Update HUD on player hit; if lives reach zero, show Game Over.
func _on_player_hit() -> void:
	update_hud()
	if $Game/Player.lives <= 0:
		Global.final_score = score
		get_tree().change_scene_to_file("res://scenes/game_over.tscn")
