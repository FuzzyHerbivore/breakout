extends StaticBody2D


signal block_points_awarded(points)


@export var point_value = 10


func on_collision_with_ball():
	block_points_awarded.emit(point_value)
	queue_free()
