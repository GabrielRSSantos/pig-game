extends PlayerState

func enter(previous_state_path: String, data := {}) -> void:
	player.state.text = "IDLE"
	print("IDLE")
	player.animation_player.play("Idle")

func physics_update(_delta: float) -> void:
	player.velocity += player.get_gravity() * _delta
	var input_direction_x := Input.get_axis("A", "D")
	
	if input_direction_x != 0:
		finished.emit("Walk")
	if player.is_on_floor() and Input.is_action_just_pressed("W"):
		finished.emit("Jump")
	if Input.is_action_just_released("W") and player.velocity.y < 0 or not player.is_on_floor():
		finished.emit("Fall")
	player.move_and_slide()

func handle_input(_event) -> void:
	if _event.is_action_pressed("E"):
		finished.emit("Attack")
