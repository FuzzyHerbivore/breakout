extends Node2D


signal points_awarded(points)
signal last_block_destroyed


const LEVELS = [
	preload("res://levels/level_0.tscn"),
	preload("res://levels/level_1.tscn"),
	preload("res://levels/level_2.tscn"),
	preload("res://levels/level_3.tscn"),
]


@export var level_position = Vector2.ZERO


func _on_block_points_awarded(points):
	points_awarded.emit(points)


func _on_block_tree_exited():
	var level = get_child(0)
	if level.get_child_count() < 1:
		last_block_destroyed.emit()


func set_level(level_index):
	if level_index >= LEVELS.size():
		return

	var level = LEVELS[level_index].instantiate()
	level.position = level_position
	add_child(level)

	var blocks = level.get_children().filter(
		func (child):
			var child_signals = child\
			.get_signal_list()\
			.map(func(signal_dict): return signal_dict.name)
			
			return child_signals.has("points_awarded")
	)

	for block in blocks:
		block.points_awarded.connect(_on_block_points_awarded)
		block.tree_exited.connect(_on_block_tree_exited)
