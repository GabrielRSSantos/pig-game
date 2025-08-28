extends PlayerState

func enter(previous_state_path: String, data := {}) -> void:
	player.state.text = "WALK"
	print("WALK")
	player.animation_player.play("Walk")

func physics_update(_delta: float) -> void:
	player.velocity.y += player.gravity * _delta
	var input_direction_x := Input.get_axis("A", "D")
	
	player.animation_player.flip_h = true if input_direction_x < 0 else false if input_direction_x > 0 else player.animation_player.flip_h
	player.velocity.x = player.SPEED * input_direction_x
	
	if player.velocity.x == 0:
		finished.emit("Idle")
	if player.is_on_floor() and Input.is_action_just_pressed("W"):
		finished.emit("Jump")
	
	player.move_and_slide()

func handle_input(_event) -> void:
	if _event.is_action_pressed("E"):
		finished.emit("Attack")
