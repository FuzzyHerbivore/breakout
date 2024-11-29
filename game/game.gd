extends Node


enum GameMode {
	NORMAL = 10,
	HECTIC = 20,
	GAME_OVER = 50,
}


@export var extra_lives_start = 5


var _extra_lives = 0:
	set(value):
		_extra_lives = value
		%ExtraLivesLabel.text = "%d" % _extra_lives


var _score = 0:
	set(value):
		_score = value
		%ScoreLabel.text = "%05d" % _score


var _paddle_start_position = Vector2.ZERO


func _ready() -> void:
	_paddle_start_position = %Paddle.position
	_reset_game()


func _reset_game():
	_game_mode = GameMode.NORMAL
	%Paddle.position = _paddle_start_position
	_score = 0
	_extra_lives = extra_lives_start


func _process(_delta):
	if _game_mode == GameMode.GAME_OVER:
		if Input.is_action_just_pressed("start"):
			_reset_game()
	else:
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
			GameMode.GAME_OVER:
				pass # TODO


func _on_boundary_top_collided_with_top():
	_game_mode = GameMode.HECTIC


func _on_ball_despawner_ball_out():
	_extra_lives -= 1
	if _extra_lives == 0:
		_game_mode = GameMode.GAME_OVER
	else:
		_game_mode = GameMode.NORMAL
