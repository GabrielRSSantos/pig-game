extends EnemyState

@onready var nav: NavigationAgent2D = %NavigationAgent2D

func enter(previous_state_path: String, data := {}) -> void:
	print("[Enter Enemy] attack state")
	enemy.velocity = Vector2.ZERO
	%AnimatedSprite2D.play("Attack")

func physics_update(delta: float) -> void:
	if enemy.player != null:
		enemy.DIRECTION = -enemy.player.to_local(nav.get_next_path_position()).normalized().x

	if enemy.DIRECTION > 0:
		%AnimatedSprite2D.flip_h = false
	elif enemy.DIRECTION < 0:
		%AnimatedSprite2D.flip_h = true
	
	if %AnimatedSprite2D.frame == 4 or %AnimatedSprite2D.frame == 8:
		$"../../HitBox/HitBoxCollision".disabled = false
	else:
		$"../../HitBox/HitBoxCollision".disabled = true
	
	if !%AnimatedSprite2D.is_playing():
		if enemy.moving and enemy.is_chasing_state:
			finished.emit("ChasingState")
		elif !enemy.moving:
			finished.emit(IDLE)

func exit() -> void:
	$"../../HitBox/HitBoxCollision".call_deferred("set", "disabled", true)

func _on_area_to_hit_body_entered(body: Node2D) -> void:
	enemy.player = body
