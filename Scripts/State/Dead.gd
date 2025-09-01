extends PlayerState

func enter(previous_state_path: String, data := {}) -> void:
	player.state.text = "DEAD"
	print("DEAD")
	player.animation_player.play("Dead")
	await get_tree().create_timer(3.0).timeout
	player.position = player.respawn_player
	player.heal(player.max_health)
	finished.emit("Idle")


func physics_update(_delta: float) -> void:
	player.velocity = Vector2.ZERO
	return
