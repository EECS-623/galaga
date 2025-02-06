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
	hud.update_wave(Global.wave)

# Called when a pirate ship or shark is defeated.
func enemy_defeated(enemy_type: String) -> void:
	if enemy_type == "pirate":
		score += 100 + 10*(Global.wave - 1)
	elif enemy_type == "shark":
		score += 200 + 20*(Global.wave - 1)
	update_hud()
	

# Update HUD on player hit; if lives reach zero, show Game Over.
func _on_player_hit() -> void:
	update_hud()
	if $Game/Player.lives <= 0:
		Global.final_score = score
		for enemy in get_tree().get_nodes_in_group("pirate_ship"):
			enemy.get_node("ProjectileTimer").stop()
			$GalleyGarrTheme.stop()
		await $Game/Player/PlayerDeathAudio.finished
		$"WAA-WAAAAA".play()
		await get_tree().create_timer(2.5).timeout
		call_deferred("_change_scene")

func _change_scene() -> void:	
	if is_inside_tree():
		get_tree().change_scene_to_file("res://scenes/game_over.tscn")
