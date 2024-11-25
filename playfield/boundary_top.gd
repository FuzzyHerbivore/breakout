extends StaticBody2D


signal collided_with_top


func on_collision_with_ball():
	collided_with_top.emit()
