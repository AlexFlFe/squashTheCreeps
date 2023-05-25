extends Node
export (PackedScene) var mob_scene
export (PackedScene) var fallingballs_scene

func _ready():
	randomize()
	$UserInterface/Retry.hide()


func _on_MobTimer_timeout():
	# Create a new instance of the Mob scene.
	var mob = mob_scene.instance()
	
	# Choose a random location on the SpawnPath.
	# We store the reference to the SpawnLocation node.
	var mob_spawn_location = get_node("SpawnPath/SpawnLocation")

	# And give it a random offset.
	mob_spawn_location.unit_offset = randf()
	
	var player_position = $Player.transform.origin
	mob.initialize(mob_spawn_location.translation, player_position)
	
	add_child(mob)
	# We connect the mob to the score label to update the score upon squashing one.
	mob.connect("squashed", $UserInterface/ScoreLabel, "_on_Mob_squashed")


func _on_Player_hit():
	$MobTimer.stop()
	$BombTimer.stop()
	$UserInterface/Retry.show()

func _unhandled_input(event):
	if event.is_action_pressed("ui_accept") and $UserInterface/Retry.visible:
	# This restarts the current scene.
		get_tree().reload_current_scene()

func _on_BombTimer_timeout():
	var bomb = fallingballs_scene.instance()
	var bomb_spawn_location = get_node("SpawnPath/SpawnBombLocation")
	bomb_spawn_location.unit_offset = randf()
	var player_position = $Player.transform.origin
	bomb.initialize(bomb_spawn_location.translation, player_position)
	add_child(bomb)
