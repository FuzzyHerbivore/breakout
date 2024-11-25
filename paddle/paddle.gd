extends CharacterBody2D


enum PaddleMode {
	LONG = 10,
	SHORT = 20,
}


@export var speed = 250.0

var paddle_mode = PaddleMode.LONG:
	set(value):
		if paddle_mode == value:
			return

		paddle_mode = value
		match paddle_mode:
			PaddleMode.LONG:
				%Sprite2D.region_rect = Rect2(18, 303, 24, 6)
				%CollisionShape2D.shape.height = 24.0
			PaddleMode.SHORT:
				%Sprite2D.region_rect = Rect2(0, 303, 16, 6)
				%CollisionShape2D.shape.height = 16.0


func _physics_process(_delta):
	velocity = Vector2.ZERO

	var direction := Input.get_axis("ui_left", "ui_right")

	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

	move_and_slide()
