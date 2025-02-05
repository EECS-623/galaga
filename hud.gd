extends Control

# Called from the main game script to update score.
func update_score(score: int) -> void:
	$ScoreLabel.text = "Score: %d" % score

# Called from the main game script to update the visual heart counter.
func update_lives(lives: int) -> void:
	var life_counter = $LifeCounter
	for i in range(life_counter.get_child_count()):
		var heart = life_counter.get_child(i)
		heart.visible = i < lives

# Called from the main game script to update wave
func update_wave(wave: int) -> void:
	$WaveLabel.text = "Wave %d" % wave
