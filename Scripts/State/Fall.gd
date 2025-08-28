extends PlayerState

func enter(previous_state_path: String, data := {}) -> void:
	player.state.text = "FALL"
	#player.velocity.y = 0

func physics_update(_delta: float) -> void:
	player.velocity += player.get_gravity() * _delta
	
	var input_direction_x := Input.get_axis("A", "D")
	player.animation_player.flip_h = true if input_direction_x < 0 else false if input_direction_x > 0 else player.animation_player.flip_h
	player.velocity.x = player.SPEED * input_direction_x

	if Input.is_action_just_pressed("E"):
		finished.emit("Attack")
	if player.is_on_ceiling():
		player.velocity.y = 0
	if player.is_on_floor() and input_direction_x == 0:
		player.velocity.y = 0
		finished.emit("Idle")
	
	if player.is_on_floor() and input_direction_x != 0:
		finished.emit("Walk")
		
	player.move_and_slide()
