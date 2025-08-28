extends PlayerState

func enter(previous_state_path: String, data := {}) -> void:
	player.state.text = "JUMP"
	print("JUMP")
	player.velocity.y = player.JUMP_VELOCITY 
	# player.animation_player.play("Jump")

func physics_update(_delta: float) -> void:
	player.velocity.y += player.gravity * _delta

	if Input.is_action_just_pressed("E"):
		finished.emit("Attack")
	if player.velocity.y >= 0:
		finished.emit("Fall")
	if Input.is_action_just_released("W") and player.velocity.y < 0:
		finished.emit("Fall")

	var input_direction_x := Input.get_axis("A", "D")
	player.animation_player.flip_h = input_direction_x < 0 if input_direction_x != 0 else player.animation_player.flip_h
	player.velocity.x = player.SPEED * input_direction_x
	player.move_and_slide()

func exit():
	player.velocity.y = 0
