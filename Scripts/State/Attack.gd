extends PlayerState

func enter(previous_state_path: String, data := {}) -> void:
	player.state.text = "ATTACK"
	print("ATTACK")
	print(player.actual_attack)
	if player.actual_attack == player.ATTACK.UP:
		print("player.ATTACK.UP")
		player.animation_player.play("Attack")
		player.actual_attack = player.ATTACK.DOWN
	else:
		print("player.ATTACK.DOWN")
		player.animation_player.play("DownAttack")
		player.actual_attack = player.ATTACK.UP
	player.collision_attack.disabled = false
	
	if not player.animation_player.is_connected("animation_finished", on_animation_finished):
		player.animation_player.connect("animation_finished", on_animation_finished)

func physics_update(_delta: float) -> void:
	player.velocity += player.get_gravity() * _delta
	var input_direction_x := Input.get_axis("A", "D")
	
	player.animation_player.flip_h = true if input_direction_x < 0 else false if input_direction_x > 0 else player.animation_player.flip_h
	
	player.velocity.x = player.SPEED * input_direction_x
	
	if player.is_on_floor() and Input.is_action_just_pressed("W"):
		player.velocity.y = 0
		finished.emit("Jump")
			
	player.move_and_slide()

func on_animation_finished() -> void:
	if player.is_on_floor():
		finished.emit("Idle")
	else:
		finished.emit("Fall")

func exit() -> void:
	player.collision_attack.disabled = true
