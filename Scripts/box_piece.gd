extends RigidBody2D

func _ready() -> void:
	apply_impulse(Vector2(randf_range(-100,100), -300), Vector2(0,0))


func _on_delete_timer_timeout() -> void:
	queue_free()
