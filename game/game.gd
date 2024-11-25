extends Node


enum GameMode {
	NORMAL = 10,
	HECTIC = 20,
}


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("start"):
		%BallManager.spawn_ball()


var _game_mode = GameMode.NORMAL:
	set(value):
		if _game_mode == value:
			return

		_game_mode = value
		match _game_mode:
			GameMode.NORMAL:
				%BallManager.ball_mode = %BallManager.BallMode.NORMAL
				%Paddle.paddle_mode = %Paddle.PaddleMode.LONG
			GameMode.HECTIC:
				%BallManager.ball_mode = %BallManager.BallMode.FAST
				%Paddle.paddle_mode = %Paddle.PaddleMode.SHORT



func _on_boundary_top_collided_with_top() -> void:
	_game_mode = GameMode.HECTIC


func _on_ball_despawner_ball_out() -> void:
	_game_mode = GameMode.NORMAL
