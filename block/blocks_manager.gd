extends Node2D


signal points_awarded(points)


func _ready():
	var blocks = get_children().filter(
		func (child):
			var child_signals = child.get_signal_list().map(func(signal_dict): return signal_dict.name)
			return child_signals.has("block_points_awarded")
	)

	for block in blocks:
		block.block_points_awarded.connect(_on_block_points_awarded)


func _on_block_points_awarded(points):
	points_awarded.emit(points)
