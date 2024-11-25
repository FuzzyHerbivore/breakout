extends Marker2D


@export var ball_scene: PackedScene
@export var normal_speed = 100.0
@export var fast_speed = 150.0


enum BallMode {
	NORMAL = 10,
	FAST = 20,
}


var ball_mode = BallMode.NORMAL:
	set(value):
		ball_mode = value
		match ball_mode:
			BallMode.NORMAL:
				_set_ball_speed(normal_speed)
			BallMode.FAST:
				_set_ball_speed(fast_speed)


func spawn_ball():
	if get_child_count() > 0:
		return

	var ball = ball_scene.instantiate()
	var direction_radians = randf_range(0, PI)
	var direction = Vector2.from_angle(direction_radians)

	ball.speed = normal_speed
	ball.direction = direction

	add_child(ball)


func _set_ball_speed(speed):
	print("Ball speed is: %s" % speed)
	var ball = get_child(0)
	if ball != null:
		ball.speed = fast_speed
