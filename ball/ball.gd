extends RigidBody2D


@export var initial_velocity = 100.0

var _velocity = Vector2.ONE


func _process(delta: float) -> void:
	var direction = Vector2(0.0, 1.0)

	var collision = move_and_collide(_velocity * initial_velocity * delta)

	if collision != null:
		_velocity = _velocity.bounce(collision.get_normal())
