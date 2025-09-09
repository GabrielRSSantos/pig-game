extends PlayerState

func enter(previous_state_path: String, data := {}) -> void:
	print("[Enter] Hurt state")
	player.velocity = Vector2.ZERO
	%AnimatedSprite2D.play("Hurt")

func physics_update(_delta: float) -> void:
	player.velocity.y += player.gravity * _delta
	player.move_and_slide()
	
	if !%AnimatedSprite2D.is_playing():
		finished.emit(IDLE)

func _on_hurt_box_area_shape_entered(area_rid: RID, area: Area2D, area_shape_index: int, local_shape_index: int) -> void:
	%AnimatedSprite2D.stop()
	%AnimatedSprite2D.play("Hurt")
