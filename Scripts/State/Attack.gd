extends PlayerState

func enter(previous_state_path: String, data := {}) -> void:
	player.state.text = "ATTACK"
	player.animation_player.play("Attack")
	
	if not player.animation_player.is_connected("animation_finished", on_animation_finished):
		player.animation_player.connect("animation_finished", on_animation_finished)

func physics_update(_delta: float) -> void:
	player.velocity += player.get_gravity() * _delta
	var input_direction_x := Input.get_axis("A", "D")
	
	player.animation_player.flip_h = true if input_direction_x < 0 else false if input_direction_x > 0 else player.animation_player.flip_h
	
	player.velocity.x = player.SPEED * input_direction_x
	
	if player.is_on_floor() and Input.is_action_just_pressed("W"):
		finished.emit("Jump")
	if not player.is_on_floor():
		finished.emit("Fall")
			
	player.move_and_slide()

func on_animation_finished() -> void:
	finished.emit("Idle")
