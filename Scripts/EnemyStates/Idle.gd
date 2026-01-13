extends EnemyState

func enter(previous_state_path: String, data := {}) -> void:
	enemy.state_label.text = "IDLE"
	print("IDLE")
	enemy.enemy_sprite.play("Idle")
	if enemy.enemy_holding_item != null and enemy.enemy_holding_item.is_in_group("Bomb"):
		enemy.enemy_sprite.play("IdleBomb")

func physics_update(_delta: float) -> void:
	enemy.velocity = Vector2(0,0)
	enemy.move_and_slide()
