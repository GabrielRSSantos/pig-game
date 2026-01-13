extends EnemyState

var bomb = null
var direction_to_bomb = 0

func enter(previous_state_path: String, data := {}) -> void:
	enemy.state_label.text = "TAKEBOMB"
	print("TAKEBOMB")
	enemy.enemy_sprite.play("Run")
	bomb = data.bomb

func physics_update(_delta: float) -> void:
	if bomb != null:
		direction_to_bomb = sign(bomb.position.x - enemy.position.x)
	else:
		direction_to_bomb = 0
	
	var speed := 50
	enemy.velocity.x = direction_to_bomb * speed

func _on_enemy_close_detection_body_entered(body: Node2D) -> void:
	if body.is_in_group("Bomb"):
		bomb = null
		direction_to_bomb = 0
		enemy.enemy_sprite.play("PickBomb")
		enemy.enemy_holding_item = body
		body.get_parent().remove_child(body)

func _on_enemy_sprite_animation_finished() -> void:
	finished.emit("Idle")
