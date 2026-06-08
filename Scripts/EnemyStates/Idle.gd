extends EnemyState

func enter(previous_state_path: String, data := {}) -> void:
	enemy.state_label.text = "IDLE"
	print("IDLE")
	enemy.enemy_sprite.play("Idle")
	
	if enemy.distance_to_patrol != 0:
		enemy.state_machine._transition_to_next_state("Patrol")
		return

func physics_update(_delta: float) -> void:
	enemy.move_and_slide()


func _on_enemy_sight_body_entered(body: Node2D) -> void:
	enemy.player = body
	enemy.state_machine._transition_to_next_state("Chasing")
