extends EnemyState

var body_player

func enter(previous_state_path: String, data := {}) -> void:
	print("[Enter Enemy] Idle state")
	%AnimatedSprite2D.play("Idle")
	enemy.velocity.x = 0
	enemy.SPEED = 0

func physics_update(_delta: float) -> void:
	enemy.velocity.y += enemy.GRAVITY * _delta
	enemy.move_and_slide()

	if enemy.moving:
		finished.emit(WALK)
	
	if body_player != null:
		finished.emit("Attack")

func _on_area_to_hit_body_entered(body: Node2D) -> void:
	if body is Player:
		body_player = body
		finished.emit("Attack")

func _on_area_to_hit_body_exited(body: Node2D) -> void:
	body_player = null
