extends Area2D

@export var next_position : Vector2 = Vector2.ZERO

func _on_body_entered(body: Node2D) -> void:
	printerr(body)
	if body.is_in_group("Player"):
		pass
