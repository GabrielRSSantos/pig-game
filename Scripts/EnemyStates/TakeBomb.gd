extends EnemyState

var bomb = null

func enter(previous_state_path: String, data := {}) -> void:
	enemy.state_label.text = "TAKEBOMB"
	print("TAKEBOMB")
	enemy.enemy_sprite.play("Run")
	bomb = data.bomb

func physics_update(_delta: float) -> void:
	var direction_to_bomb: int = sign(bomb.position.x - enemy.position.x)
	
	var speed := 50
	enemy.velocity.x = direction_to_bomb * speed

func handle_input(_event) -> void:
	if _event.is_action_pressed("E"):
		finished.emit("Attack")
