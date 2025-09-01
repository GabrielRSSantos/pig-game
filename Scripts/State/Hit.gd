extends PlayerState

func enter(previous_state_path: String, data := {}) -> void:
	player.state.text = "HIT"
	print("HIT")
	player.animation_player.play("Hit")
	var knockback_direction = (player.global_position - data.enemy_direction).normalized()
	print(knockback_direction)
	apply_knockback(knockback_direction, 150.0, 0.12)

func physics_update(_delta: float) -> void:
	player.velocity += player.get_gravity() * _delta
	
	if knockback_timer > 0.0:
		player.velocity = knockback
		knockback_timer -= _delta
		if knockback_timer < 0.0:
			knockback = Vector2.ZERO
	else:
		finished.emit("Idle")
	player.move_and_slide()

func exit():
	player.velocity = Vector2.ZERO
var knockback : Vector2 = Vector2.ZERO
var knockback_timer : float
func apply_knockback(direction, force, duration) -> void:
	knockback = direction * force
	knockback_timer = duration
