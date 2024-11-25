extends RigidBody2D


var direction = Vector2.ZERO
var speed = 0.0


func _process(delta):
	var collision = move_and_collide(direction * speed * delta)

	if collision != null:
		var collider = collision.get_collider()
		if collider.has_method("on_collision_with_ball"):
			collider.on_collision_with_ball()
		direction = direction.bounce(collision.get_normal())
