extends Area2D

@export var next_area_position : Area2D
var player : Player = null

func _process(delta: float) -> void:
	if player != null and Input.is_action_just_pressed("W"):
		player.position = next_area_position.position

func _on_body_entered(body: Node2D) -> void:
	print(next_area_position)
	if body.is_in_group("Player"):
		player = body


func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		player = null
