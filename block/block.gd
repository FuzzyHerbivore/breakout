extends StaticBody2D


@export var point_value = 10


func on_collision_with_ball():
	queue_free()
