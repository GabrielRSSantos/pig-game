extends EnemyState

func enter(previous_state_path: String, data := {}) -> void:
	enemy.state_label.text = "CHASING"
	print("Chasing")
	enemy.enemy_sprite.play("Run")

func physics_update(_delta: float) -> void:
	if enemy.player == null:
		finished.emit("Idle")
		
	if enemy.player != null:
		var direction = (enemy.player.global_position - enemy.global_position).normalized().x
		enemy.velocity.x = direction * 50
