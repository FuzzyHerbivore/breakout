extends StaticBody2D


signal points_awarded(points)


@export var point_value = 10


func on_collision_with_ball():
	points_awarded.emit(point_value)
	queue_free()
