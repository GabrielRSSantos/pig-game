extends EnemyState

func enter(previous_state_path: String, data := {}) -> void:
	enemy.state_label.text = "ATTACK"
	print("ATTACK")
	enemy.enemy_sprite.play("Attack")

func physics_update(_delta: float) -> void:
	
	enemy.velocity = Vector2.ZERO
	enemy.move_and_slide()

func _on_enemy_sprite_animation_finished() -> void:
	if enemy.player == null:
		finished.emit("Chasing")
	else:
		finished.emit("Attack")

func _on_enemy_attack_box_body_exited(body: Node2D) -> void:
	print(body)
	enemy.player = null
	finished.emit("Chasing")
