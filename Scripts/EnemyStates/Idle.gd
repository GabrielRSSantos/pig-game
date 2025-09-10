extends EnemyState

func enter(previous_state_path: String, data := {}) -> void:
	enemy.state_label.text = "IDLE"
	print("IDLE")
	enemy.enemy_sprite.play("Idle")

func physics_update(_delta: float) -> void:
	enemy.move_and_slide()

func handle_input(_event) -> void:
	if _event.is_action_pressed("E"):
		finished.emit("Attack")
