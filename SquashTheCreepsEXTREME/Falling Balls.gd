extends KinematicBody
# Minimum speed of the mob in meters per second.
export var min_speed = 10
# Maximum speed of the mob in meters per second.
export var max_speed = 15
# Maximum distance from the player where the mob can spawn.
export var max_distance_from_player = 6

var velocity = Vector3.ZERO

func _physics_process(_delta):
	move_and_slide(velocity)

# We will call this function from the Main scene.
func initialize(start_position, player_position):
	# We calculate a random point around the player within a certain radius.
	var spawn_position = player_position + Vector3(rand_range(-max_distance_from_player, max_distance_from_player),
												  0,
										   rand_range(-max_distance_from_player, max_distance_from_player))
	# We position the bomb at the random spawn position.
	translation = spawn_position
	# We calculate a random speed.
	var random_speed = rand_range(min_speed, max_speed)
	# We set the velocity to go down (in the negative y direction).
	velocity = Vector3.DOWN * random_speed

func _on_VisibilityNotifier_screen_exited():
	queue_free()
