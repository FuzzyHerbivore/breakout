extends Area2D


signal ball_out


func _on_body_entered(body: Node2D) -> void:
	ball_out.emit()
	body.queue_free()
