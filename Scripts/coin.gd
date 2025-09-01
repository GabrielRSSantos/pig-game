extends RigidBody2D

var impulse_applied = false

func _on_coin_area_body_entered(body: Node2D) -> void:
	print(body)
	if body.is_in_group("Player"):
		body.update_coin(1)
		queue_free()

func _ready() -> void:
	apply_impulse(Vector2(0, -250), Vector2(0,0))
