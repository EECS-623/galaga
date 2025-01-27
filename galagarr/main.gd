extends Node

@export var pirate_scene: PackedScene
var score

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#get_tree().change_scene_to_file("res://menu.tscn")
	pass

func new_game():
	score = 0
	$MobTimer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#pass
